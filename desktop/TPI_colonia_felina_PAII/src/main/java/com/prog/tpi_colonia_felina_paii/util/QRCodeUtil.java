package com.prog.tpi_colonia_felina_paii.util;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import java.io.File;
import java.nio.file.FileSystems;
import java.nio.file.Path;

public class QRCodeUtil {
    
    public static String generarQR(String texto, String carpetaDestino, String nombreArchivo) {
        try {
            // Crear directorio si no existe
            File directorio = new File(carpetaDestino);
            if (!directorio.exists()) {
                directorio.mkdirs();
            }

            String rutaCompleta = carpetaDestino + File.separator + nombreArchivo;
            
            QRCodeWriter qrCodeWriter = new QRCodeWriter();
            // Generamos una matriz de 350x350 pixeles
            BitMatrix bitMatrix = qrCodeWriter.encode(texto, BarcodeFormat.QR_CODE, 350, 350);
            
            Path path = FileSystems.getDefault().getPath(rutaCompleta);
            MatrixToImageWriter.writeToPath(bitMatrix, "PNG", path);
            
            return nombreArchivo; // Devolvemos solo el nombre para guardar en BD
            
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}