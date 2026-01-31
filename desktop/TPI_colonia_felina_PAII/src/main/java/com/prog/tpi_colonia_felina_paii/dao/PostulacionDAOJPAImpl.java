package com.prog.tpi_colonia_felina_paii.dao;

import com.prog.tpi_colonia_felina_paii.modelo.Postulacion;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import java.util.List;

public class PostulacionDAOJPAImpl implements IPostulacionDAO {

    private final EntityManager em = DBService.getEntityManager();

    @Override
    public void guardar(Postulacion postulacion) {
        try {
            DBService.beginTransaction();
            em.persist(postulacion);
            DBService.commitTransaction();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw e;
        }
    }

    @Override
    public void actualizar(Postulacion postulacion) {
        try {
            DBService.beginTransaction();
            em.merge(postulacion); // merge actualiza un objeto existente
            DBService.commitTransaction();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw e;
        }
    }

    @Override
    public Postulacion buscarPorId(Long id) {
        return em.find(Postulacion.class, id);
    }

    @Override
    public List<Postulacion> buscarTodas() {
        String jpql = "SELECT p FROM Postulacion p ORDER BY p.fecha DESC, p.idPostulacion DESC";
        TypedQuery<Postulacion> query = em.createQuery(jpql, Postulacion.class);
        return query.getResultList();
    }
    
    public List<Postulacion> buscarPorFamilia(Long idFamilia) {
        String jpql = "SELECT p FROM Postulacion p WHERE p.familiaPostulante.idFamilia = :idFamilia ORDER BY p.fecha DESC";
        TypedQuery<Postulacion> query = em.createQuery(jpql, Postulacion.class);
        query.setParameter("idFamilia", idFamilia);
        return query.getResultList();
    }
    
    @Override
    public Postulacion buscarPorGatoYFamilia(Long idGato, Long idFamilia) {
        try {
            String jpql = "SELECT p FROM Postulacion p WHERE p.gato.idGato = :idGato AND p.familiaPostulante.id = :idFamilia";

            Postulacion postulacion = (Postulacion) em.createQuery(jpql)
                    .setParameter("idGato", idGato)
                    .setParameter("idFamilia", idFamilia)
                    .setMaxResults(1)
                    .getSingleResult();

            return postulacion;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}