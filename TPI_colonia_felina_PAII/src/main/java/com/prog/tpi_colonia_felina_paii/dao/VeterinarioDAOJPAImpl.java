
package com.prog.tpi_colonia_felina_paii.dao;

import com.prog.tpi_colonia_felina_paii.modelo.Veterinario;
import jakarta.persistence.EntityManager;


public class VeterinarioDAOJPAImpl implements IVeterinarioDAO{
    private final EntityManager em = DBService.getEntityManager();
    
    @Override
    public void crear(Veterinario v) {
        try{
        DBService.beginTransaction();
        em.persist(v);
        DBService.commitTransaction();  
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback(); 
            }
            throw e; 
        }
    }
    
}
