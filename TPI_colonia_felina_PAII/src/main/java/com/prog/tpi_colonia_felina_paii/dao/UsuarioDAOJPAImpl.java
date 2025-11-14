
package com.prog.tpi_colonia_felina_paii.dao;

import com.prog.tpi_colonia_felina_paii.modelo.Usuario;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import java.util.List;

public class UsuarioDAOJPAImpl implements IUsuarioDAO {
    
    private final EntityManager em = DBService.getEntityManager();

    @Override
    public void crear(Usuario usuario) {
        em.persist(usuario);
    }
     
    @Override
    public Usuario buscarPorEmail(String email) {
        TypedQuery<Usuario> q = em.createQuery("SELECT u FROM Usuario u WHERE u.email = :email", Usuario.class);
        q.setParameter("email", email);
        Usuario usuario = q.getSingleResult();
        return usuario;
    }
    
    @Override
    public boolean existeEmail(String email) {
        String jpql = "SELECT CASE WHEN COUNT(u) > 0 THEN TRUE ELSE FALSE END " +
                  "FROM Usuario u WHERE u.email = :email";
        return em.createQuery(jpql, Boolean.class)
             .setParameter("email", email)
             .getSingleResult();
    }
}
