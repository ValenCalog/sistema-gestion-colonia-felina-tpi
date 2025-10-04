
package Clases;

import java.util.Date;

public class Estudio {
    private String idEstudio;
    private Date fecha;
    private String tipoDeEstudio;
    private String observaciones;
    private String rutaArchivo;
    private Veterinario unVeterinario;

    public Estudio(Date fecha, String tipoDeEstudio, String observaciones, String rutaArchivo, Veterinario unVeterinario) {
        this.fecha = fecha;
        this.tipoDeEstudio = tipoDeEstudio;
        this.observaciones = observaciones;
        this.rutaArchivo = rutaArchivo;
        this.unVeterinario = unVeterinario;
        //Falta la implementacion de idEstudio++
    }
    
    public String obtenerInfoEstudio(){
        return "El estudio se realizo el: "+fecha+", por el veterinario: "+unVeterinario.getNombre();
    }
}
