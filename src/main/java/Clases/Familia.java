
package Clases;

import java.util.List;

public class Familia {
    private String idFamilia;
    private String disponibilidad;
    private String observaciones;
    private String direccion;
    private String codigoFamilia;
    private List<Usuario> listaUsuarios;

    public Familia(String disponibilidad, String observaciones, String direccion) {
        this.disponibilidad = disponibilidad;
        this.observaciones = observaciones;
        this.direccion = direccion;
        //Falta la implementacion del idFamilia++
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }
    
    public String obtenerInfoFamilia(){
        return "Disponibilidad: " + disponibilidad + " - Direccion: " + direccion;
        //Determinar que mas abarca InfoFamilia
    }
    
}
