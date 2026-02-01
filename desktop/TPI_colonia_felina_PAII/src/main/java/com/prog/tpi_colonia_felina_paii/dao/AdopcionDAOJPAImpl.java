package com.prog.tpi_colonia_felina_paii.dao;

import com.prog.tpi_colonia_felina_paii.modelo.Adopcion;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import java.util.List;

public class AdopcionDAOJPAImpl implements IAdopcionDAO {

    private final EntityManager em = DBService.getEntityManager();

    @Override
    public void guardar(Adopcion adopcion) {
        try {
            DBService.beginTransaction();
            em.persist(adopcion);
            DBService.commitTransaction();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw e;
        }
    }

    @Override
    public void actualizar(Adopcion adopcion) {
        try {
            DBService.beginTransaction();
            em.merge(adopcion);
            DBService.commitTransaction();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw e;
        }
    }

    @Override
    public Adopcion buscarPorId(Long id) {
        return em.find(Adopcion.class, id);
    }

    @Override
    public List<Adopcion> buscarTodas() {
        String jpql = "SELECT a FROM Adopcion a ORDER BY a.fecha DESC";
        TypedQuery<Adopcion> query = em.createQuery(jpql, Adopcion.class);
        return query.getResultList();
    }

    @Override
    public List<Adopcion> buscarPorFamilia(Long idFamilia) {
        String jpql = "SELECT a FROM Adopcion a WHERE a.familiaAdoptante.idFamilia = :idFamilia ORDER BY a.fecha DESC";
        TypedQuery<Adopcion> query = em.createQuery(jpql, Adopcion.class);
        query.setParameter("idFamilia", idFamilia);
        return query.getResultList();
    }
}