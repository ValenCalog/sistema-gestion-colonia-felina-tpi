package com.coloniafelina.tpi_colonia_felina_web_paii.servlets;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// escucha todo lo que empiece por /imagenes-gatos/
@WebServlet("/imagenes-gatos/*")
public class ImagenServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        //obtenemos el nombre de la imagen de la URL
        // Si piden: /imagenes-gatos/michi123.jpg -> getPathInfo() devuelve "/michi123.jpg"
        String filename = request.getPathInfo();
        
        if (filename == null || filename.equals("/")) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        
        String uploadPath = "C:\\tpi_gatos_uploads";
        File file = new File(uploadPath, filename);

        // verificamos si existe y lo enviammos
        if (file.exists()) {
            // vemos el tipo de archivo (jpg, png, etc)
            String contentType = getServletContext().getMimeType(file.getName());
            if (contentType == null) {
                contentType = "application/octet-stream";
            }
            response.setContentType(contentType);
            response.setContentLength((int) file.length());

            // se copian los bytes del archivo a la respuesta
            Files.copy(file.toPath(), response.getOutputStream());
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND); // 404
        }
    }
}