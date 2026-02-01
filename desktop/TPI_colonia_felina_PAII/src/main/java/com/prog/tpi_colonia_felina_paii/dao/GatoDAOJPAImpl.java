
package com.prog.tpi_colonia_felina_paii.dao;

import com.prog.tpi_colonia_felina_paii.enums.Disponibilidad;
import com.prog.tpi_colonia_felina_paii.modelo.Gato;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import java.util.ArrayList;
import java.util.List;


public class GatoDAOJPAImpl implements IGatoDAO{

    private final EntityManager em = DBService.getEntityManager();
    
    @Override
    public void guardarGato(Gato gato) {
        try{
            DBService.beginTransaction();  
            em.persist(gato);
            DBService.commitTransaction();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback(); 
            }
            throw e; 
        }
    }

    @Override
    public void actualizar(Gato g) {
        try{
            DBService.beginTransaction();  
            em.merge(g);
            DBService.commitTransaction();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback(); 
            }
            throw e; 
        }
    }

    @Override
    public void eliminar(Gato g) {
        try {
            DBService.beginTransaction();
            Gato adjunto = g;
            if (!em.contains(g)) {
                adjunto = em.merge(g);   
            }
            em.remove(adjunto);          
            DBService.commitTransaction();
        } catch (Exception e) {
                if (em.getTransaction().isActive()) {
                    em.getTransaction().rollback();
                }
                throw e;
        }
    }

    @Override
    public Gato buscarPorId(Long id) {
        return em.find(Gato.class, id);
    }

    @Override
    public List<Gato> buscarTodos() {
        TypedQuery<Gato> q = em.createQuery(
            "SELECT g FROM Gato g ORDER BY g.idGato",
            Gato.class
        );
        return q.getResultList();
    }
    
    @Override
    public List<Gato> buscarDisponibles() {
        try {
            String jpql = "SELECT g FROM Gato g WHERE g.disponibilidad = :estado";
            TypedQuery<Gato> query = em.createQuery(jpql, Gato.class);
            query.setParameter("estado", Disponibilidad.DISPONIBLE);
            return query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>(); 
        }
    }
    
    @Override
    public List<Gato> buscarEsterilizados() {
        String jpql = "SELECT g FROM Gato g WHERE g.esterilizado = true";
        TypedQuery<Gato> query = em.createQuery(jpql, Gato.class);
        return query.getResultList();
    }
}
