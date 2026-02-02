
package com.prog.tpi_colonia_felina_paii.dao;

import com.prog.tpi_colonia_felina_paii.modelo.HistorialMedico;

public interface IHistorialMedicoDAO {
    HistorialMedico buscarPorIdGato(Long idGato);
    void crear(HistorialMedico h);
}
