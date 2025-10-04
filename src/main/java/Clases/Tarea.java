
package Clases;

import java.util.Date;

public class Tarea {
    private String idTarea;
    private Date fecha;
    private String tipoDeTarea;
    private String observaciones;
    private Usuario unUsuario;
    private Gato unGato;
    private Zona unaZona;

    public Tarea(Date fecha, String tipoDeTarea, String observaciones, Usuario unUsuario, Gato unGato, Zona unaZona) {
        this.fecha = fecha;
        this.tipoDeTarea = tipoDeTarea;
        this.observaciones = observaciones;
        this.unUsuario = unUsuario;
        this.unGato = unGato;
        this.unaZona = unaZona;
    }
    
    //Ultra dudoso este metodo, ver como se implementa despues
    public String obtenerInfoTarea(){
        return unGato.getNombre() + "recibio un/a " + tipoDeTarea + " el " + fecha + " a cargo de " + unUsuario.getNombreYApellido();
    }
    
}
