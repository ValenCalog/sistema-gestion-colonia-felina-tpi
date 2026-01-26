
package com.prog.tpi_colonia_felina_paii.controlador;

import com.prog.tpi_colonia_felina_paii.dao.GatoDAOJPAImpl;
import com.prog.tpi_colonia_felina_paii.dao.IGatoDAO;
import com.prog.tpi_colonia_felina_paii.dao.ITareaDAO;
import com.prog.tpi_colonia_felina_paii.dao.TareaDAOJPAImpl;
import com.prog.tpi_colonia_felina_paii.enums.TipoDeTarea;
import com.prog.tpi_colonia_felina_paii.modelo.Gato;
import com.prog.tpi_colonia_felina_paii.modelo.Tarea;
import com.prog.tpi_colonia_felina_paii.modelo.Usuario;
import java.time.LocalDate;
import java.util.List;


public class ControladorTareas {
    private final ITareaDAO tareaDAO;
    private final IGatoDAO gatoDAO;
    
    public ControladorTareas(){
        this.tareaDAO = new TareaDAOJPAImpl();
        this.gatoDAO = new GatoDAOJPAImpl();
    }
    
    public void registrarTarea(Long idGato,
                                Usuario voluntario,
                                LocalDate fecha,
                                String ubicacion,
                                String observaciones,
                                TipoDeTarea tipoDeTarea){
        Gato gato = gatoDAO.buscarPorId(idGato);
        Tarea tarea = new Tarea(fecha, tipoDeTarea, observaciones, gato, voluntario, ubicacion);
        tareaDAO.guardarTarea(tarea);
    }
    
    public List<Tarea> obtenerTareasDeGato(Long idGato){
        return tareaDAO.buscarPorGato(idGato);
    }
    
    public List<Tarea> obtenerTareasDeUsuario(Long idUsuario){
        return tareaDAO.buscarPorUsuario(idUsuario);
    }

}
