
package com.prog.tpi_colonia_felina_paii.dao;

import com.prog.tpi_colonia_felina_paii.modelo.Gato;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import java.util.List;


public class GatoDAOJPAImpl implements IGatoDAO{

    private final EntityManager em = DBService.getEntityManager();
    
    @Override
    public void guardarGato(Gato gato) {
        em.persist(gato);
    }

    @Override
    public void actualizar(Gato g) {
        em.merge(g);
    }

    @Override
    public void eliminar(Gato g) {
        Gato adjunto = g;
        if (!em.contains(g)) {
            adjunto = em.merge(g);
        }
        em.remove(adjunto);
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
    
}
