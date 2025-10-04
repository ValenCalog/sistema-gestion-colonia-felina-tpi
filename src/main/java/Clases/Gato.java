
package Clases;

public class Gato {
    private String idGato;
    private String nombre;
    private String color;
    private String caracteristicas;
    private String fotografia; //Ver como se va a terminar implementando esto
    private String estadoSalud;
    private String disponibilidad;

    public Gato(String nombre, String color, String caracteristicas, String fotografia, String estadoSalud) {
        this.nombre = nombre;
        this.color = color;
        this.caracteristicas = caracteristicas;
        this.fotografia = fotografia;
        this.estadoSalud = estadoSalud;
        this.disponibilidad = "Disponible"; //Estos van a ser los estados?
    }

    public String getEstadoSalud() {
        return estadoSalud;
    }

    public void setEstadoSalud(String estadoSalud) {
        this.estadoSalud = estadoSalud;
    }

    public String getDisponibilidad() {
        return disponibilidad;
    }

    public void setDisponibilidad(String disponibilidad) {
        this.disponibilidad = disponibilidad;
    }
    
    public String obtenerInfoGato(){
        return "El nombre del gato es: "+nombre+" y su color es: "+color;
    }

    public String getNombre() {
        return nombre;
    }
    
    
}
