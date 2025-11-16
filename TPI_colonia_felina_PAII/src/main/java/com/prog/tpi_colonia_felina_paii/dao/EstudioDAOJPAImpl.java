
package com.prog.tpi_colonia_felina_paii.dao;

import com.prog.tpi_colonia_felina_paii.modelo.Estudio;
import jakarta.persistence.EntityManager;


public class EstudioDAOJPAImpl implements IEstudioDAO{
    private final EntityManager em = DBService.getEntityManager();
    
    @Override
    public void guardarEstudio(Estudio e) {
        DBService.beginTransaction();
        em.persist(e);
        DBService.commitTransaction();
    }
}
