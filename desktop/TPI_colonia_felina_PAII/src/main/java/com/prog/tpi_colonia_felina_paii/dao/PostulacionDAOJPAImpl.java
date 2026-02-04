package com.prog.tpi_colonia_felina_paii.dao;

import com.prog.tpi_colonia_felina_paii.enums.EstadoPostulacion;
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
    
    // Este metodo es para mostrarle a las familias todas sus postulaciones que todavia no fueron aceptadas o que fueron rechazadas
    @Override
    public List<Postulacion> buscarActivasPorFamilia(Long idFamilia) {
        EntityManager em = DBService.getEntityManager();
        try {
            /* Explicacion de la consulta:
            Primero filtramos por id familia
           Despues nos fijamos que NO sea ACEPTADA (p.estado <> :aceptada)
             ordenamos con CASE: Si es PENDIENTE vale 1, sino vale 2. (menor va primero)
             ordenamos por ID descendente por si hay empate (las más nuevas primero). */

            String jpql = "SELECT p FROM Postulacion p " +
                          "WHERE p.familiaPostulante.idFamilia = :idFamilia " +
                          "AND p.estado <> :aceptada " +
                          "ORDER BY " +
                          "CASE WHEN p.estado = :pendiente THEN 1 ELSE 2 END ASC, " +
                          "p.idPostulacion DESC";

            return em.createQuery(jpql, Postulacion.class)
                     .setParameter("idFamilia", idFamilia)
                     .setParameter("aceptada", EstadoPostulacion.ACEPTADA)
                     .setParameter("pendiente", EstadoPostulacion.PENDIENTE)
                     .getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public Long contarPendientesPorFamilia(Long idFamilia) {
        EntityManager em = DBService.getEntityManager();
        try {
            String jpql = "SELECT COUNT(p) FROM Postulacion p " +
                          "WHERE p.familiaPostulante.idFamilia = :idFamilia " +
                          "AND p.estado = :pendiente";

            return em.createQuery(jpql, Long.class)
                     .setParameter("idFamilia", idFamilia)
                     .setParameter("pendiente", EstadoPostulacion.PENDIENTE)
                     .getSingleResult();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}