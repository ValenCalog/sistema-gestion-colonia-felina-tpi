package com.coloniafelina.tpi_colonia_felina_web_paii.servlets;

import com.prog.tpi_colonia_felina_paii.modelo.Usuario;
import com.prog.tpi_colonia_felina_paii.modelo.Veterinario;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "DescargarArchivoServlet", urlPatterns = {"/DescargarArchivoServlet"})
public class DescargarArchivoServlet extends HttpServlet {

    // misma ruta base que usamos en EstudioMedicoServlet, usamos la carpeta padre, porque la ruta que viene de la BD ya trae "/estudios/"
    private static final String BASE_DIR = "C:\\tpi_gatos_uploads";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Usuario usuario = (Usuario) session.getAttribute("usuarioLogueado");

        if (usuario == null || !(usuario instanceof Veterinario)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Acceso denegado.");
            return;
        }

        // obtener la ruta relativa desde el parámetro ("/estudios/uuid-123.pdf")
        String rutaRelativa = request.getParameter("ruta");

        if (rutaRelativa == null || rutaRelativa.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Falta la ruta del archivo.");
            return;
        }

        File archivo = new File(BASE_DIR, rutaRelativa);

        if (!archivo.exists()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "El archivo físico no existe en el servidor.");
            return;
        }

        // para evitar hackeos
        if (!archivo.getCanonicalPath().startsWith(new File(BASE_DIR).getCanonicalPath())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Ruta inválida.");
            return;
        }

        
        String mimeType = getServletContext().getMimeType(archivo.getName());
        if (mimeType == null) {
            mimeType = "application/octet-stream"; 
        }
        response.setContentType(mimeType);
        response.setContentLength((int) archivo.length());


        String headerKey = "Content-Disposition";
        String headerValue = String.format("inline; filename=\"%s\"", archivo.getName()); // "inline" = abre en el navegador
        response.setHeader(headerKey, headerValue);

        // escribir el archivo en la respuesta (Stream)
        try (FileInputStream inStream = new FileInputStream(archivo);
             OutputStream outStream = response.getOutputStream()) {

            byte[] buffer = new byte[4096]; // Buffer de 4KB
            int bytesRead;

            while ((bytesRead = inStream.read(buffer)) != -1) {
                outStream.write(buffer, 0, bytesRead);
            }
        }
    }
}