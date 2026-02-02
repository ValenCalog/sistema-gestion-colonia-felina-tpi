
package com.prog.tpi_colonia_felina_paii.dao;

import com.prog.tpi_colonia_felina_paii.modelo.Seguimiento;
import java.util.List;

public interface ISeguimientoDAO {
    public void crear(Seguimiento seguimiento);
    public void editar(Seguimiento seguimiento);
    public Seguimiento buscarPorId(Long id);
    public List<Seguimiento> buscarPorAdopcion(Long idAdopcion);
    public List<Seguimiento> buscarTodos();
    public void cerrar();
    
}
