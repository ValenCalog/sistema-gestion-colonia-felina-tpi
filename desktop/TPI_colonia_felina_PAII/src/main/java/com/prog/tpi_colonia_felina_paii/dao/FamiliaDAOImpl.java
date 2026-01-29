
package com.prog.tpi_colonia_felina_paii.dao;

import com.prog.tpi_colonia_felina_paii.modelo.Familia;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.TypedQuery;


public class FamiliaDAOImpl implements IFamiliaDAO{
    private final EntityManager em = DBService.getEntityManager();
    
    @Override
    public void crear(Familia familia) {
        try {
            em.getTransaction().begin();
            
            em.persist(familia);
            
            em.getTransaction().commit();
            
        } catch (Exception e) {

            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace();
            throw new RuntimeException("Error al guardar la familia", e);
        }
    }

    @Override
    public Familia buscarPorCodigo(String codigo) {
        try{
        TypedQuery<Familia> q = em.createQuery("SELECT f FROM Familia f WHERE f.codigoFamilia = :codigo", Familia.class);
        q.setParameter("codigo", codigo);
        return q.getSingleResult();
        } catch (NoResultException e) {
            return null;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    
    @Override
    public Familia buscarPorId(long id) {
        return em.find(Familia.class, id);
    }
}
