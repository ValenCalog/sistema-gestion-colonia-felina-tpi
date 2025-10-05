
package Clases;

import java.util.Date;

public class Diagnostico {
    private String idDiagnostico;
    private Date fecha;
    private String descDetallada;
    private String observaciones;
    private String estadoClinico;
    private HistorialMedico unHistorialMedico;

    public Diagnostico(Date fecha, String descDetallada, String observaciones, String estadoClinico, HistorialMedico unHistorialMedico) {
        this.fecha = fecha;
        this.descDetallada = descDetallada;
        this.observaciones = observaciones;
        this.estadoClinico = estadoClinico;
        this.unHistorialMedico = unHistorialMedico;
        //Falta la implementacion del idDiagnostico++
    }
    
    public String obtenerInfoDiagnostico(){
        return descDetallada;
    }
    
}
