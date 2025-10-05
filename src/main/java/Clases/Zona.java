
package Clases;

public class Zona {
    private String idZona;
    private String nombre;
    private String descripcion;
    
    //Este seria el metodo crearZona(), pero se escribio asi por ser el constructor
    public Zona(String nombre, String descripcion) {
        this.nombre = nombre;
        this.descripcion = descripcion;
        //Falta la implementacion de idZona++
    }

    public void modificarZona(String descripcion) {
        this.descripcion = descripcion;
    }
    
    public String obtenerInfoZona(){
        return "La ubicacion de la zona " + nombre + " es: " + descripcion;
    }
    
}
