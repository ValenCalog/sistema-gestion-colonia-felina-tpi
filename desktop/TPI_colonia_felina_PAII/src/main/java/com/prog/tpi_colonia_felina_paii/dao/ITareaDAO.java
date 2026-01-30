
package com.prog.tpi_colonia_felina_paii.dao;

import com.prog.tpi_colonia_felina_paii.modelo.Tarea;
import java.util.List;


public interface ITareaDAO {
    public void guardarTarea(Tarea tarea);
    public Tarea buscarPorId(Long id);
    public List<Tarea> buscarPorGato(Long idGato);
    public List<Tarea> buscarPorUsuario(Long idUsuario);
    public void actualizar(Tarea tarea);
}
