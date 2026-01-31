package com.prog.tpi_colonia_felina_paii.dao;

import com.prog.tpi_colonia_felina_paii.modelo.Adopcion;
import java.util.List;

public interface IAdopcionDAO {
    
    void guardar(Adopcion adopcion);
    
    void actualizar(Adopcion adopcion);
    
    Adopcion buscarPorId(Long id);
    List<Adopcion> buscarTodas();
    
    // Para el panel de "Mis Adopciones" de la familia)
    List<Adopcion> buscarPorFamilia(Long idFamilia);
}