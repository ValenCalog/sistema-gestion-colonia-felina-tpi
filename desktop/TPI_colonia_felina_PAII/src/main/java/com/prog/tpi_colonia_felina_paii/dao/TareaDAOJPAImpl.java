
package com.prog.tpi_colonia_felina_paii.dao;

import com.prog.tpi_colonia_felina_paii.modelo.Tarea;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import java.util.List;


public class TareaDAOJPAImpl implements ITareaDAO{
    
    private final EntityManager em = DBService.getEntityManager();

    @Override
    public void guardarTarea(Tarea tarea) {
        try{
            DBService.beginTransaction();
            em.persist(tarea);
            DBService.commitTransaction();  
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback(); 
            }
            throw e; 
        }
    }

    @Override
    public Tarea buscarPorId(Long id) {
        return em.find(Tarea.class, id);
    }

    @Override
    public List<Tarea> buscarPorGato(Long idGato) {
        TypedQuery<Tarea> q = em.createQuery("SELECT t FROM Tarea t WHERE t.gato.idGato = :idGato ORDER BY t.fecha DESC, t.idTarea DESC", Tarea.class);
        q.setParameter("idGato", idGato);
        return q.getResultList();
    }

    @Override
    public List<Tarea> buscarPorUsuario(Long idUsuario) {
        TypedQuery<Tarea> q = em.createQuery("SELECT t FROM Tarea t WHERE t.usuario.idUsuario = :idUsuario ORDER BY t.fecha DESC, t.idTarea DESC", Tarea.class);
        q.setParameter("idUsuario", idUsuario);
        return q.getResultList();
    }
    
    @Override
    public void actualizar(Tarea tarea) {
        try {
            DBService.beginTransaction();
            em.merge(tarea); // merge es para actualizar
            DBService.commitTransaction();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw e;
        }
    }
    
    @Override
    public List<Tarea> obtenerTodas(){
        TypedQuery<Tarea> q = em.createQuery("SELECT t FROM Tarea t ORDER BY t.fecha DESC, t.idTarea DESC", Tarea.class);
        return q.getResultList();
    }
    
    @Override
    public List<Tarea> obtenerUltimas5(){
        TypedQuery<Tarea> q = em.createQuery("SELECT t FROM Tarea t ORDER BY t.fecha DESC, t.idTarea DESC", Tarea.class)
                .setMaxResults(5);
        return q.getResultList();
    }
    
}
