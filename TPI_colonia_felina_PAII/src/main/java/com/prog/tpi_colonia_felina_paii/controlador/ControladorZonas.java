
package com.prog.tpi_colonia_felina_paii.controlador;

import com.prog.tpi_colonia_felina_paii.dao.IZonaDAO;
import com.prog.tpi_colonia_felina_paii.dao.ZonaDAOJPAImpl;
import com.prog.tpi_colonia_felina_paii.modelo.Zona;
import java.util.List;


public class ControladorZonas {
    
    private final IZonaDAO zonaDAO;

    public ControladorZonas(IZonaDAO zonaDAO) {
        this.zonaDAO = zonaDAO;
    }
    
    public void registrarZona(String nombre, 
                              String descripcion,
                              Double latitud,
                              Double longitud){
        if (nombre == null || nombre.trim().isEmpty()){
            throw new IllegalArgumentException("El nombre de la zona es obligatorio.");
        }
        
        if(latitud != null && (latitud < -90 ||  latitud > 90)){
            throw new IllegalArgumentException("Latitud fuera de rango (-90 a 90)");
        }
        
        if(longitud != null && (longitud < -180 || longitud > 180 )){
            throw new IllegalArgumentException("Longitud fuera de rango (-180 a 180)");
        }
        
        Zona zona = new Zona(nombre.trim(), descripcion, latitud, longitud);
        
        try{
            zonaDAO.guardarZona(zona);
        }catch(Exception e){
            throw new RuntimeException("Error al registrar la zona", e);
        }
    }
    
    public List<Zona> listarZonas(){
        return zonaDAO.buscarTodas();
    }
    
}
