
package com.prog.tpi_colonia_felina_paii.dao;

import com.prog.tpi_colonia_felina_paii.modelo.Zona;
import java.util.List;

public interface IZonaDAO {
    public void guardarZona(Zona zona);
    public List<Zona> buscarTodas();
}
