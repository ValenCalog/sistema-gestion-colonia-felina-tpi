package com.coloniafelina.tpi_colonia_felina_web_paii.servlets;

import com.prog.tpi_colonia_felina_paii.dao.GatoDAOJPAImpl;
import com.prog.tpi_colonia_felina_paii.dao.ZonaDAOJPAImpl;
import com.prog.tpi_colonia_felina_paii.modelo.Gato;
import com.prog.tpi_colonia_felina_paii.modelo.Zona;
import com.prog.tpi_colonia_felina_paii.modelo.PuntoDeAvistamiento; // Importante
import com.prog.tpi_colonia_felina_paii.enums.Disponibilidad;
import com.prog.tpi_colonia_felina_paii.enums.EstadoSalud;

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
                
            case "listar":
            default:
                List<Gato> listaGatos = gatoDAO.buscarTodos();
                request.setAttribute("gatos", listaGatos);
                // Si aún no tienes 'listarGatos.jsp', usamos el formulario para que no de error 404
                cargarFormulario(request, response, zonaDAO, null);
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

        String idZonaStr = request.getParameter("idZona");
        if (idZonaStr != null && !idZonaStr.isEmpty()) {
            Zona zona = zonaDAO.buscarPorId(Long.parseLong(idZonaStr));
            gato.setZona(zona);
        } else {
            gato.setZona(null); 
        }

        // Lógica de IMAGEN
        Part filePart = request.getPart("foto"); 
        String rutaFoto = guardarImagen(filePart); // Llamamos al método mágico
        
        if (rutaFoto != null) {
            gato.setFotografia(rutaFoto);
        } else if (esNuevo) {
            gato.setFotografia(null);
        }
        // Si es edición y rutaFoto es null, mantenemos la foto vieja (no hacemos set)

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
                gato.setPuntoAvistamiento(punto);
            } catch (NumberFormatException e) {
                System.out.println("Error coordenadas: " + e.getMessage());
            }
        }

        // Guardar en Base de Datos
        try {
            if (esNuevo) {
                gatoDAO.guardarGato(gato);
            } else {
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
            String uploadPath = "C:\\Users\\User\\Documents\\tpi_gatos_uploads";
            
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