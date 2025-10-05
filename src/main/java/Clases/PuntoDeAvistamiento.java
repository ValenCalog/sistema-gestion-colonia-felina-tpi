
package Clases;

public class PuntoDeAvistamiento {
    private String id;
    private String plusCode;
    private String nombre;
    private Zona unaZona;
    
    //Este seria el metodo crearPuntoDeAvistamiento(), esta escrito asi por ser el constructor
    public PuntoDeAvistamiento(String plusCode, String nombre, Zona unaZona) {
        this.plusCode = plusCode;
        this.nombre = nombre;
        this.unaZona = unaZona;
        //Falta la implementacion de id++
    }

    public void modificarPuntoDeAvistamiento(String plusCode) {
        this.plusCode = plusCode;
    }
    
    public String obtenerInfoPuntoDeAvistamiento(){
        return "La ubicacion del punto de avistamiento " + nombre + " es " + plusCode;
    }
}
