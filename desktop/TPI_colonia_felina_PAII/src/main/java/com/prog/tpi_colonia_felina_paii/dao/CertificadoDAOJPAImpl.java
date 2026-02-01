package com.prog.tpi_colonia_felina_paii.dao;

import com.prog.tpi_colonia_felina_paii.modelo.CertificadoAptitud;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import java.util.List;

public class CertificadoDAOJPAImpl implements ICertificadoDAO{
    
    private final EntityManager em = DBService.getEntityManager();

    @Override
    public CertificadoAptitud buscarPorIdGato(Long idGato) {
        try {
            TypedQuery<CertificadoAptitud> query = em.createQuery(
                "SELECT c FROM CertificadoAptitud c WHERE c.gato.idGato = :idGato", 
                CertificadoAptitud.class);
            query.setParameter("idGato", idGato);
            List<CertificadoAptitud> resultados = query.getResultList();
            return resultados.isEmpty() ? null : resultados.get(0);
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback(); 
            }
            throw e;
        } 
    }
    
    @Override
    public void crear(CertificadoAptitud c){
        try{
            DBService.beginTransaction();  
            em.persist(c);
            DBService.commitTransaction();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback(); 
            }
            throw e; 
        }
    }
    
}
