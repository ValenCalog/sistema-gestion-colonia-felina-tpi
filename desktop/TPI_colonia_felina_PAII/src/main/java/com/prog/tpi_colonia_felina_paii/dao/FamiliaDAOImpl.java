
package com.prog.tpi_colonia_felina_paii.dao;

import com.prog.tpi_colonia_felina_paii.modelo.Familia;
import jakarta.persistence.EntityManager;


public class FamiliaDAOImpl implements IFamiliaDAO{
    private final EntityManager em = DBService.getEntityManager();
    
    @Override
    public void crear(Familia familia) {
        em.persist(familia);
    }
}
