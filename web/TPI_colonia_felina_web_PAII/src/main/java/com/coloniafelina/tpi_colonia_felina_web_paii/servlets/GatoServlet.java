package com.coloniafelina.tpi_colonia_felina_web_paii.servlets;

import com.prog.tpi_colonia_felina_paii.dao.GatoDAOJPAImpl;
import com.prog.tpi_colonia_felina_paii.dao.ZonaDAOJPAImpl;
import com.prog.tpi_colonia_felina_paii.modelo.Gato;
import com.prog.tpi_colonia_felina_paii.modelo.Zona;
import com.prog.tpi_colonia_felina_paii.modelo.PuntoDeAvistamiento; // Importante
import com.prog.tpi_colonia_felina_paii.enums.Disponibilidad;
import com.prog.tpi_colonia_felina_paii.enums.EstadoSalud;
import com.prog.tpi_colonia_felina_paii.enums.Sexo;

import com.prog.tpi_colonia_felina_paii.util.QRCodeUtil;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet(name = "GatoServlet", urlPatterns = {"/GatoServlet"})
@MultipartConfig // Habilita la subida de archivos
public class GatoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        GatoDAOJPAImpl gatoDAO = new GatoDAOJPAImpl();
        ZonaDAOJPAImpl zonaDAO = new ZonaDAOJPAImpl();

        String accion = request.getParameter("accion");
        if (accion == null) accion = "listar";

        switch (accion) {
            case "crear":
                cargarFormulario(request, response, zonaDAO, null);
                break;

            case "editar":
                try {
                    Long id = Long.parseLong(request.getParameter("id"));
                    Gato gato = gatoDAO.buscarPorId(id);
                    cargarFormulario(request, response, zonaDAO, gato);
                } catch (NumberFormatException e) {
                    response.sendRedirect("GatoServlet?accion=listar");
                }
                break;

            
            case "verDetalle":
                try {
                    Long id = Long.parseLong(request.getParameter("id"));
                    Gato gato = gatoDAO.buscarPorId(id);

                    if (gato != null) {
                        request.setAttribute("gato", gato);
                        request.getRequestDispatcher("detalleGato.jsp").forward(request, response);
                    } else {
                        // si no existe el ID (QR viejo o inválido), volvemos a la lista con error
                        response.sendRedirect("GatoServlet?accion=listar&error=Gato+no+encontrado");
                    }
                } catch (Exception e) {
                    response.sendRedirect("GatoServlet?accion=listar");
                }
                break;

            case "listar":
            default:
                List<Gato> listaGatos = gatoDAO.buscarTodos();
                request.setAttribute("gatos", listaGatos);
                request.getRequestDispatcher("listaGatos.jsp").forward(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        GatoDAOJPAImpl gatoDAO = new GatoDAOJPAImpl();
        ZonaDAOJPAImpl zonaDAO = new ZonaDAOJPAImpl();
        
        String idStr = request.getParameter("idGato");
        
        Gato gato;
        boolean esNuevo = (idStr == null || idStr.isEmpty());

        if (esNuevo) {
            gato = new Gato(); 
        } else {
            gato = gatoDAO.buscarPorId(Long.parseLong(idStr)); 
        }

        gato.setNombre(request.getParameter("nombre"));
        gato.setColor(request.getParameter("color"));
        gato.setCaracteristicas(request.getParameter("caracteristicas"));
        
        try {
            gato.setDisponibilidad(Disponibilidad.valueOf(request.getParameter("disponibilidad")));
            gato.setEstadoSalud(EstadoSalud.valueOf(request.getParameter("estadoSalud")));
        } catch (IllegalArgumentException | NullPointerException e) {
            e.printStackTrace(); 
        }

        // Guardamos la zona en una variable para usarla después)
        Zona zonaSeleccionada = null; 
        String idZonaStr = request.getParameter("idZona");
        
        if (idZonaStr != null && !idZonaStr.isEmpty()) {
            zonaSeleccionada = zonaDAO.buscarPorId(Long.parseLong(idZonaStr));
            gato.setZona(zonaSeleccionada);
        } else {
            gato.setZona(null); 
        }
        
        // Lógica de IMAGEN
        Part filePart = request.getPart("foto"); 
        String rutaFoto = guardarImagen(filePart);
        
        if (rutaFoto != null) {
            gato.setFotografia(rutaFoto);
        } else if (esNuevo) {
            gato.setFotografia(null);
        }

        // Lógica de PUNTO DE AVISTAMIENTO
        String latStr = request.getParameter("latitud");
        String lonStr = request.getParameter("longitud");

        if (latStr != null && !latStr.isEmpty() && lonStr != null && !lonStr.isEmpty()) {
            PuntoDeAvistamiento punto;
            
            if (gato.getPuntoAvistamiento() != null) {
                punto = gato.getPuntoAvistamiento();
            } else {
                punto = new PuntoDeAvistamiento();
            }

            try {
                punto.setLatitud(Double.parseDouble(latStr));
                punto.setLongitud(Double.parseDouble(lonStr));
                
                // Asignamos al punto la misma zona que al gato
                punto.setZona(zonaSeleccionada); 
                // ----------------------------------------
                
                gato.setPuntoAvistamiento(punto);
            } catch (NumberFormatException e) {
                System.out.println("Error coordenadas: " + e.getMessage());
            }
        }
        
        try {
            gato.setSexo(Sexo.valueOf(request.getParameter("sexo")));
            // Boolean.parseBoolean devuelve true solo si el string es "true" (ignorando mayúsculas)
            gato.setEsterilizado(Boolean.parseBoolean(request.getParameter("esterilizado")));
        } catch (Exception e) { e.printStackTrace(); }        

        // GUARDADO Y GENERACIÓN DE QR
        try {
            if (esNuevo) {
                // A) Primero guardamos para generar el ID en la BD
                gatoDAO.guardarGato(gato); 

                // B) Ahora que tiene ID, generamos el QR
                // El texto del QR será una URL que apunte al detalle de este gato
                String contenidoQR = "http://localhost:8080/TPI_colonia_felina_web_PAII/GatoServlet?accion=verDetalle&id=" + gato.getIdGato();
                String nombreArchivoQR = "qr_gato_" + gato.getIdGato() + ".png";

                // Usamos la misma ruta base que las fotos (C:\tpi_gatos_uploads)
                String uploadPath = "C:\\tpi_gatos_uploads"; 

                QRCodeUtil.generarQR(contenidoQR, uploadPath, nombreArchivoQR);

                // C) Actualizamos el gato con la ruta del QR (ruta virtual)
                gato.setQrCodePath("/imagenes-gatos/" + nombreArchivoQR);
                gatoDAO.actualizar(gato);

            } else {
                // Si es edición, solo actualizamos datos normales
                // (Opcional: podrías regenerar el QR si cambió algo importante)
                gatoDAO.actualizar(gato);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("GatoServlet?accion=listar");
    }

    // MÉTODO PARA GUARDAR LA FOTO EN DISCO
    private String guardarImagen(Part filePart) {
        if (filePart == null || filePart.getSize() == 0) {
            return null;
        }

        try {
            // RUTA FÍSICA
            // Usamos doble barra \\ para Windows
            // En el método guardarImagen
            String uploadPath = "C:\\tpi_gatos_uploads";
            
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs(); // mkdirs crea toda la ruta si falta algo
            }

            // Generar nombre único
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String fileExtension = "";
            int i = fileName.lastIndexOf('.');
            if (i > 0) {
                fileExtension = fileName.substring(i);
            }
            String uniqueFileName = UUID.randomUUID().toString() + fileExtension;

            // Guardar archivo físico
            String fullPath = uploadPath + File.separator + uniqueFileName;
            Files.copy(filePart.getInputStream(), Paths.get(fullPath), StandardCopyOption.REPLACE_EXISTING);

            // Retornar RUTA VIRTUAL
            return "/imagenes-gatos/" + uniqueFileName;

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    private void cargarFormulario(HttpServletRequest request, HttpServletResponse response, 
                                  ZonaDAOJPAImpl zonaDAO, Gato gatoEditar) 
            throws ServletException, IOException {
        
        List<Zona> zonas = zonaDAO.buscarTodas(); 
        request.setAttribute("listaZonas", zonas);
        
        if (gatoEditar != null) {
            request.setAttribute("gatoEditar", gatoEditar);
        }
        
        request.getRequestDispatcher("formGato.jsp").forward(request, response);
    }
}