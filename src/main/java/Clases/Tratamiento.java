
package Clases;

import java.util.Date;

public class Tratamiento {
    private String idTratamiento;
    private Date fechaTratamiento;
    private String descripcion;
    private String medicacion;
    private String observaciones;
    private Veterinario unVeterinario;
    private Diagnostico unDiagnostico;

    public Tratamiento(Date fechaTratamiento, String descripcion, String medicacion, String observaciones, Veterinario unVeterinario, Diagnostico unDiagnostico) {
        this.fechaTratamiento = fechaTratamiento;
        this.descripcion = descripcion;
        this.medicacion = medicacion;
        this.observaciones = observaciones;
        this.unVeterinario = unVeterinario;
        this.unDiagnostico = unDiagnostico;
        //Falta la implementacion de idTratamiento++
    }
    
    public String obtenerInfoTratamiento(){
        return "La medicacion asignada al tratamiento es: " + medicacion;
    }
    
}
