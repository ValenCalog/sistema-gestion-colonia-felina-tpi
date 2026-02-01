
package com.prog.tpi_colonia_felina_paii.dao;

import com.prog.tpi_colonia_felina_paii.enums.Disponibilidad;
import com.prog.tpi_colonia_felina_paii.enums.EstadoSalud;
import com.prog.tpi_colonia_felina_paii.modelo.Gato;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import java.util.ArrayList;
import java.util.List;


public class GatoDAOJPAImpl implements IGatoDAO{
    
    @Override
    public void guardarGato(Gato gato) {
        EntityManager em = DBService.getEntityManager();
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
        EntityManager em = DBService.getEntityManager();
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
        EntityManager em = DBService.getEntityManager();
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
        EntityManager em = DBService.getEntityManager();
        return em.find(Gato.class, id);
    }

    @Override
    public List<Gato> buscarTodos() {
        EntityManager em = DBService.getEntityManager();
        TypedQuery<Gato> q = em.createQuery(
            "SELECT g FROM Gato g ORDER BY g.idGato",
            Gato.class
        );
        return q.getResultList();
    }
    
    @Override
    public List<Gato> buscarDisponibles() { 
        EntityManager em = DBService.getEntityManager();
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
        EntityManager em = DBService.getEntityManager();
        String jpql = "SELECT g FROM Gato g WHERE g.esterilizado = true";
        TypedQuery<Gato> query = em.createQuery(jpql, Gato.class);
        return query.getResultList();
    }
    
    @Override
    public List<Gato> buscarTodosOrdenadosPorGravedad() {
        EntityManager em = DBService.getEntityManager();
        try {
            String jpql = "SELECT g FROM Gato g ORDER BY " +
                          "CASE g.estadoSalud " +
                          "   WHEN :e1 THEN 1 " +
                          "   WHEN :e2 THEN 2 " +
                          "   WHEN :e3 THEN 3 " +
                          "   ELSE 4 " +
                          "END ASC";

            TypedQuery<Gato> query = em.createQuery(jpql, Gato.class);

            query.setParameter("e1", EstadoSalud.ENFERMO);
            query.setParameter("e2", EstadoSalud.EN_TRATAMIENTO);
            query.setParameter("e3", EstadoSalud.SANO);

            return query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>(); 
        }
    }
}
