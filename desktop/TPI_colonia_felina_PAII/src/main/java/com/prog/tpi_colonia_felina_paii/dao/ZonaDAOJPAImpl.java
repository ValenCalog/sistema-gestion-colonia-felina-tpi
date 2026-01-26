
package com.prog.tpi_colonia_felina_paii.dao;

import com.prog.tpi_colonia_felina_paii.modelo.Zona;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import java.util.List;


public class ZonaDAOJPAImpl implements IZonaDAO{
    private EntityManager em = DBService.getEntityManager();

    public ZonaDAOJPAImpl() {
    }

    public List<Zona> buscarTodas() {
        TypedQuery<Zona> q = em.createQuery(
            "SELECT z FROM Zona z ORDER BY z.nombre",
            Zona.class
        );
        return q.getResultList();
    }
    
    public void guardarZona(Zona zona) {
       try{
            DBService.beginTransaction();
            em.persist(zona);
            DBService.commitTransaction();  
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback(); 
            }
            throw e; 
        }
    }
    

}
