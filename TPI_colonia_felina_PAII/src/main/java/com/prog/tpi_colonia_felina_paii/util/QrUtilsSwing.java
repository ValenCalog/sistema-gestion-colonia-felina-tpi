
package com.prog.tpi_colonia_felina_paii.util;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import java.awt.image.BufferedImage;

public class QrUtilsSwing {

    public static BufferedImage generarQrParaGato(Long idGato) throws WriterException {
        String contenido = "Gato ID: " + idGato; // texto simple para Swing (sin URL) ya que solo queremos ver una imagen de un QR, sin escanearla (a modo de ejemplo)
        
        QRCodeWriter qrWriter = new QRCodeWriter(); //  objeto encargado de codificar el contenido como un QR
        
        //Ahora se genera una matriz de bits (blanco y negro) que representa el código QR
        //Los parámetros son: contenido, tipo de código (QR), ancho y alto en píxeles
        BitMatrix matrix = qrWriter.encode(contenido, BarcodeFormat.QR_CODE, 200, 200);
        
        //y aca se transforma la matriz en una imagen que podemos mostrar directamente en un JLabel
        return MatrixToImageWriter.toBufferedImage(matrix);
    }
}
