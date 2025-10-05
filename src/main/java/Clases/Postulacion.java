
package Clases;

import java.util.Date;

public class Postulacion {
    private String idPostulacion;
    private Date fecha;
    private String tipoAdopcion;
    private String observacion;
    private String estado;
    private Familia unaFamilia;
    private Usuario unUsuario; //Hace falta que se relacione con Usuario y tambien con Familia?
    private Gato unGato;

    public Postulacion(Date fecha, String tipoAdopcion, String observacion, Familia unaFamilia, Usuario unUsuario, Gato unGato) {
        this.fecha = fecha;
        this.tipoAdopcion = tipoAdopcion;
        this.observacion = observacion;
        this.unaFamilia = unaFamilia;
        this.unUsuario = unUsuario;
        this.unGato = unGato;
        this.estado = "En revision"; //Esto va a ser ENUM
        //Falta la implementacion de idPostulacion++
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }
    
    public String obtenerInfoPostulacion(){
        return "La postulacion del usuario " + unUsuario.getNombreYApellido() + "para la adopcion del gato " + unGato.getNombre() + 
                "esta en estado: " + estado;
    }
    
}
