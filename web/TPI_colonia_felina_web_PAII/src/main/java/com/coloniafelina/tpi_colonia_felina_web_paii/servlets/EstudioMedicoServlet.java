package com.coloniafelina.tpi_colonia_felina_web_paii.servlets;

import com.prog.tpi_colonia_felina_paii.dao.EstudioDAOJPAImpl;
import com.prog.tpi_colonia_felina_paii.dao.GatoDAOJPAImpl;
import com.prog.tpi_colonia_felina_paii.dao.HistorialMedicoDAOJPAImpl;
import com.prog.tpi_colonia_felina_paii.modelo.Estudio;
import com.prog.tpi_colonia_felina_paii.modelo.Gato;
import com.prog.tpi_colonia_felina_paii.modelo.HistorialMedico;
import com.prog.tpi_colonia_felina_paii.modelo.Usuario;
import com.prog.tpi_colonia_felina_paii.modelo.Veterinario;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.time.LocalDate;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@WebServlet(name = "EstudioMedicoServlet", urlPatterns = {"/EstudioMedicoServlet"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10,      // 10MB
        maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class EstudioMedicoServlet extends HttpServlet {

    private final GatoDAOJPAImpl gatoDAO = new GatoDAOJPAImpl();
    private final HistorialMedicoDAOJPAImpl historialDAO = new HistorialMedicoDAOJPAImpl();
    private final EstudioDAOJPAImpl estudioDAO = new EstudioDAOJPAImpl();
    
    // CARPETA DONDE SE GUARDAN LOS ARCHIVOS FISICOS
    private static final String UPLOAD_DIR = "C:\\tpi_gatos_uploads\\estudios";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        Usuario usuario = (Usuario) session.getAttribute("usuarioLogueado");

        if (usuario == null || !(usuario instanceof Veterinario)) {
            response.sendRedirect("login.jsp");
            return;
        }
        Veterinario veterinario = (Veterinario) usuario;

        String accion = request.getParameter("accion");

        if ("subir".equals(accion)) {
            try {
                Long idGato = Long.parseLong(request.getParameter("idGato"));
                String tipoEstudio = request.getParameter("tipoEstudio");
                String fechaStr = request.getParameter("fecha");
                String observaciones = request.getParameter("observaciones");
                Part filePart = request.getPart("archivo");

                Gato gato = gatoDAO.buscarPorId(idGato);
                HistorialMedico historial = historialDAO.buscarPorIdGato(idGato);
                
                if (historial == null) {
                    historial = new HistorialMedico();
                    historial.setGato(gato);
                    historialDAO.crear(historial);
                    historial = historialDAO.buscarPorIdGato(idGato);
                }

                String rutaArchivo = guardarArchivo(filePart);

                Estudio estudio = new Estudio();
                estudio.setFecha(LocalDate.parse(fechaStr));
                estudio.setTipoDeEstudio(tipoEstudio);
                estudio.setObservaciones(observaciones);
                estudio.setRutaArchivo(rutaArchivo); // Guardamos la ruta relativa
                
                estudio.setVeterinario(veterinario);
                estudio.setHistorial(historial);

                estudioDAO.guardarEstudio(estudio);

                response.sendRedirect("VeterinarioServlet?accion=consultorio&idGato=" + idGato);

            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("error.jsp");
            }
        }
    }

    private String guardarArchivo(Part filePart) throws IOException {
        if (filePart == null || filePart.getSize() == 0) return null;

        // crear directorio si no existe
        File uploadDir = new File(UPLOAD_DIR);
        if (!uploadDir.exists()) uploadDir.mkdirs();

        // generar nombre único para evitar colisiones
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String extension = "";
        int i = fileName.lastIndexOf('.');
        if (i > 0) extension = fileName.substring(i);
        
        String uniqueName = UUID.randomUUID().toString() + extension;
        String fullPath = UPLOAD_DIR + File.separator + uniqueName;

        // guardar
        Files.copy(filePart.getInputStream(), Paths.get(fullPath), StandardCopyOption.REPLACE_EXISTING);

        // retornar ruta relativa para la BD (Ej: "/estudios/uuid.pdf")
        return "/estudios/" + uniqueName;
    }
}