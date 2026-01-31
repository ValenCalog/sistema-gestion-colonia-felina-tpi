package com.prog.tpi_colonia_felina_paii.dao;

import com.prog.tpi_colonia_felina_paii.modelo.Postulacion;
import java.util.List;

public interface IPostulacionDAO {
    void guardar(Postulacion postulacion);
    void actualizar(Postulacion postulacion);
    Postulacion buscarPorId(Long id);
    List<Postulacion> buscarTodas();
    boolean existePostulacion(Long idGato, Long idFamilia);
}