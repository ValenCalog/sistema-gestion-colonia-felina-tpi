
package com.prog.tpi_colonia_felina_paii.dao;

import com.prog.tpi_colonia_felina_paii.modelo.Diagnostico;


public interface IDiagnosticoDAO {
    void guardarDiagnostico(Diagnostico d);
    Diagnostico buscarPorId(Long id);
}
