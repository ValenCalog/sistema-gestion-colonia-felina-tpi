
package com.prog.tpi_colonia_felina_paii.dao;

import com.prog.tpi_colonia_felina_paii.modelo.Zona;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import java.util.List;


public class ZonaDAOJPAImpl implements IZonaDAO{
    private EntityManager em = DBService.getEntityManager();

    public ZonaDAOJPAImpl() {
    }

    @Override
    public List<Zona> buscarTodas() {
        TypedQuery<Zona> q = em.createQuery(
            "SELECT z FROM Zona z ORDER BY z.nombre",
            Zona.class
        );
        return q.getResultList();
    }
    
    @Override
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
    
    @Override
    public Zona buscarPorId(long id){
        return em.find(Zona.class, id);
    }
    
    @Override
    public void actualizar(Zona zona) {
        try{
            DBService.beginTransaction();  
            em.merge(zona);
            DBService.commitTransaction();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback(); 
            }
            throw e; 
        }
    }
    
    @Override
    public void eliminar(long id) {
        try {
            DBService.beginTransaction();
            Zona zona = em.find(Zona.class, id);
            if (zona != null){
                em.remove(zona);   
            }
            DBService.commitTransaction();
        } catch (Exception e) {
                if (em.getTransaction().isActive()) {
                    em.getTransaction().rollback();
                }
                throw e;
        }
    }

}
