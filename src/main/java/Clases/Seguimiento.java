
package Clases;
import java.util.Date;
//import java.time.LocalDate; <- En caso de que no usemos Date

public class Seguimiento{
    private String idSeguimiento;
    private Date fecha;
    //private LocalDate fecha;
    private String tipoDeContacto;
    private String observaciones;
    private Usuario unUsuario;

    public Seguimiento(Date fecha, String tipoDeContacto, String observaciones, Usuario unUsuario) {
        this.fecha = fecha;
        this.tipoDeContacto = tipoDeContacto;
        this.observaciones = observaciones;
        this.unUsuario = unUsuario;
        //Falta la implementacion del idSeguimiento++
    }
    
    public String obtenerInfoDeSeguimiento(){
        return "Fecha: " + fecha + " - Observaciones: " + observaciones;
        //↳ Algun otro dato relevante de Seguimiento?
    }
}
