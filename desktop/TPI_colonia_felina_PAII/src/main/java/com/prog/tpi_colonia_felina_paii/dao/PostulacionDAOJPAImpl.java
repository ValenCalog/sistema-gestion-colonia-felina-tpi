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
        // Traemos todas, ordenadas por fecha (las más recientes primero)
        // y por estado (para ver las pendientes agrupadas si quisieras, 
        // pero por fecha es lo más estándar).
        String jpql = "SELECT p FROM Postulacion p ORDER BY p.fecha DESC, p.idPostulacion DESC";
        TypedQuery<Postulacion> query = em.createQuery(jpql, Postulacion.class);
        return query.getResultList();
    }
    
    // Método extra opcional: Buscar las de una familia específica
    // (Útil para que la familia vea sus propias solicitudes)
    public List<Postulacion> buscarPorFamilia(Long idFamilia) {
        String jpql = "SELECT p FROM Postulacion p WHERE p.familiaPostulante.idFamilia = :idFamilia ORDER BY p.fecha DESC";
        TypedQuery<Postulacion> query = em.createQuery(jpql, Postulacion.class);
        query.setParameter("idFamilia", idFamilia);
        return query.getResultList();
    }
}