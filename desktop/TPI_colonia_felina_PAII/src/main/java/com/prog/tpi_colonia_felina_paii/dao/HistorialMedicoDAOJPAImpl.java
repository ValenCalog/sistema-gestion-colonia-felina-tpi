
package com.prog.tpi_colonia_felina_paii.dao;

import com.prog.tpi_colonia_felina_paii.modelo.HistorialMedico;
import jakarta.persistence.EntityManager;


public class HistorialMedicoDAOJPAImpl implements IHistorialMedicoDAO{
    
    private final EntityManager em = DBService.getEntityManager();
    
    @Override
    public HistorialMedico buscarPorIdGato(Long idGato) {
        try {
            String jpql = "SELECT h FROM HistorialMedico h " +
                      "LEFT JOIN FETCH h.estudios " + 
                      "WHERE h.gato.idGato = :idGato";
            return em.createQuery(jpql, HistorialMedico.class)
                     .setParameter("idGato", idGato)
                     .getSingleResult();
        } catch (Exception e) {
            return null;
        }    
    }
    
    @Override
    public void crear(HistorialMedico h){
        try{
            DBService.beginTransaction();  
            em.persist(h);
            DBService.commitTransaction();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback(); 
            }
            throw e; 
        }
    }
}
