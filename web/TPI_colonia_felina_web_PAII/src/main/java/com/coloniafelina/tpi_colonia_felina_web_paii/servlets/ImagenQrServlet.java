package com.coloniafelina.tpi_colonia_felina_web_paii.servlets;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.client.j2se.MatrixToImageWriter; // Misma librería que tu Util
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import com.prog.tpi_colonia_felina_paii.dao.GatoDAOJPAImpl;
import com.prog.tpi_colonia_felina_paii.modelo.Gato;
import java.io.IOException;
import java.io.OutputStream;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "ImagenQrServlet", urlPatterns = {"/ImagenQrServlet"})
public class ImagenQrServlet extends HttpServlet {

    private GatoDAOJPAImpl gatoDAO = new GatoDAOJPAImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. validamos ID
        String idStr = request.getParameter("id");
        if (idStr == null || idStr.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        try {
            // 2. buscamos el gato
            Long idGato = Long.parseLong(idStr);
            Gato gato = gatoDAO.buscarPorId(idGato);

            if (gato != null) {
                // 3. generamos la URL que contendrá el QR
                String contenidoQR = "http://localhost:8080/TPI_colonia_felina_web_PAII/GatoServlet?accion=verDetalle&id=" + idGato;

                // 4. configuraramos la respuesta para que el navegador sepa que es una imagen
                response.setContentType("image/png");
                
                // 5. generamos el qr
                QRCodeWriter qrCodeWriter = new QRCodeWriter();
                // generamos matriz de 200x200
                BitMatrix bitMatrix = qrCodeWriter.encode(contenidoQR, BarcodeFormat.QR_CODE, 200, 200);
                
                // 6. escribimos al navegador usando writeToStream (navegador)
                OutputStream out = response.getOutputStream();
                MatrixToImageWriter.writeToStream(bitMatrix, "PNG", out);
                
                out.flush();
                
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND); // Gato no existe
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}