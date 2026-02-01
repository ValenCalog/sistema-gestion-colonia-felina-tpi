package com.prog.tpi_colonia_felina_paii.dao;

import com.prog.tpi_colonia_felina_paii.modelo.CertificadoAptitud;

public interface ICertificadoDAO {
    CertificadoAptitud buscarPorIdGato(Long idGato);
    void crear(CertificadoAptitud c);
}
