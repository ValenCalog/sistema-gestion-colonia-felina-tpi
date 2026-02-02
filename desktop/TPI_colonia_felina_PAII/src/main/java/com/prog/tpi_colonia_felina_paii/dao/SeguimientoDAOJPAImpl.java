package com.prog.tpi_colonia_felina_paii.dao;

import com.prog.tpi_colonia_felina_paii.modelo.Seguimiento;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import java.util.List;

public class SeguimientoDAOJPAImpl {

    private final EntityManager em = DBService.getEntityManager();

    public void crear(Seguimiento seguimiento) {
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.persist(seguimiento);
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
        }
    }

    public void editar(Seguimiento seguimiento) {
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.merge(seguimiento);
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
        }
    }

    public Seguimiento buscarPorId(Long id) {
        return em.find(Seguimiento.class, id);
    }

    public List<Seguimiento> buscarPorAdopcion(Long idAdopcion) {
        String jpql = "SELECT s FROM Seguimiento s WHERE s.adopcion.idAdopcion = :idAdopcion ORDER BY s.fecha DESC";
        TypedQuery<Seguimiento> query = em.createQuery(jpql, Seguimiento.class);
        query.setParameter("idAdopcion", idAdopcion);
        return query.getResultList();
    }
    
    public List<Seguimiento> buscarTodos() {
        String jpql = "SELECT s FROM Seguimiento s ORDER BY s.fecha DESC";
        TypedQuery<Seguimiento> query = em.createQuery(jpql, Seguimiento.class);
        return query.getResultList();
    }
    
    public void cerrar() {
        if (em != null && em.isOpen()) {
            em.close();
        }
    }
}