
package Clases;

public class Zona {
    private String idZona;
    private String nombre;
    private String plusCode;
    
    //Este seria el metodo crearZona(), pero se escribio asi por ser el constructor
    public Zona(String nombre, String plusCode) {
        this.nombre = nombre;
        this.plusCode = plusCode;
        //Falta la implementacion de idZona++
    }

    public void modificarZona(String plusCode) {
        this.plusCode = plusCode;
    }
    
    public String obtenerInfoZona(){
        return "La ubicacion de la zona " + nombre + " es: " + plusCode;
    }
    
}
