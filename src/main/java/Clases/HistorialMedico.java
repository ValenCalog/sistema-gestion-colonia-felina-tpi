
package Clases;
import java.util.List;

public class HistorialMedico {
    private String idHistorial;
    private Gato unGato;
    private List<Estudio> listaEstudios; 

    //Este es el metodo crearHistorialMedico, pero tiene este nombre por ser constructor
    public HistorialMedico(Gato unGato, List<Estudio> listaEstudios) {
        this.unGato = unGato;
        this.listaEstudios = listaEstudios;
        //Falta la implementacion de idHistorial++
    }
    
    public void obtenerResumenHistorial(){
        for (Estudio estudio: listaEstudios){
            System.out.println(estudio.obtenerInfoEstudio());
        }
    }
    
}
