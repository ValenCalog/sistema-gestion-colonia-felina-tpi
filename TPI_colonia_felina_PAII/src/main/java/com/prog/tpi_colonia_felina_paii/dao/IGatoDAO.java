
package com.prog.tpi_colonia_felina_paii.dao;

import com.prog.tpi_colonia_felina_paii.modelo.Gato;
import java.util.List;

public interface IGatoDAO {
    public void guardarGato(Gato gato);
    
    void actualizar(Gato g);

    void eliminar(Gato g);

    Gato buscarPorId(Long id);

    List<Gato> buscarTodos();
}
