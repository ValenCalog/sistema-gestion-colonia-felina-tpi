
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
                              String coordenadas){
        if (nombre == null || nombre.trim().isEmpty()){
            throw new IllegalArgumentException("El nombre de la zona es obligatorio.");
        }
        
        Zona zona = new Zona(nombre.trim(), descripcion, coordenadas);
        
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
