
package Clases;

import java.util.Date;

public class CertificadoAptitud {
    private String idCertificado;
    private Date fecha;
    private String observaciones;
    private String condiciones;
    private Gato unGato;
    
    //Este seria el metodo que se llama emitirCertificado(), pero no es valido poner ese nombre para un constructor
    public CertificadoAptitud(Date fecha, String observaciones, String condiciones, Gato unGato) {
        this.fecha = fecha;
        this.observaciones = observaciones;
        this.condiciones = condiciones;
        this.unGato = unGato;
        //falta la implementacion de idCertificado++
    }
    
}
