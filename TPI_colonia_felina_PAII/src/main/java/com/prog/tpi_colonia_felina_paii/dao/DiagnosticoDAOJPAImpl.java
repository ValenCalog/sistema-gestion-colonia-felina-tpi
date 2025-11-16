
package com.prog.tpi_colonia_felina_paii.dao;

import com.prog.tpi_colonia_felina_paii.modelo.Diagnostico;
import jakarta.persistence.EntityManager;


public class DiagnosticoDAOJPAImpl implements IDiagnosticoDAO{

    private final EntityManager em = DBService.getEntityManager();
    
    @Override
    public void guardarDiagnostico(Diagnostico d) {
        DBService.beginTransaction();
        em.persist(d);
        DBService.commitTransaction();
    }

    @Override
    public Diagnostico buscarPorId(Long id) {
        if (id == null) return null;
        return em.find(Diagnostico.class, id);
    }
    
}
