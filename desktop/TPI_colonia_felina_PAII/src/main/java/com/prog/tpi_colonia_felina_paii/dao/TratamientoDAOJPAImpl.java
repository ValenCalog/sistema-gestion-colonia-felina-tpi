
package com.prog.tpi_colonia_felina_paii.dao;

import com.prog.tpi_colonia_felina_paii.modelo.Tratamiento;
import jakarta.persistence.EntityManager;


public class TratamientoDAOJPAImpl implements ITratamientoDAO{

    private final EntityManager em = DBService.getEntityManager();
    
    @Override
    public void guardarTratamiento(Tratamiento t) {
        DBService.beginTransaction();
        em.persist(t);
        DBService.commitTransaction();
    }
    
}
