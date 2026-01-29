
package com.prog.tpi_colonia_felina_paii.dao;

import com.prog.tpi_colonia_felina_paii.enums.Rol;
import com.prog.tpi_colonia_felina_paii.modelo.Usuario;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import java.util.List;

public class UsuarioDAOJPAImpl implements IUsuarioDAO {
    
    private final EntityManager em = DBService.getEntityManager();
    
    
    
    @Override
    public void crear(Usuario usuario) {
        try {
            DBService.beginTransaction();  
            em.persist(usuario);       
            DBService.commitTransaction();  
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback(); 
            }
            throw e; 
        }
    }
     
    @Override
    public Usuario buscarPorEmail(String email) {
        TypedQuery<Usuario> q = em.createQuery("SELECT u FROM Usuario u WHERE u.correo = :email", Usuario.class);
        q.setParameter("email", email);
        Usuario usuario = q.getSingleResult();
        return usuario;
    }
    
    @Override
    public boolean existeEmail(String email) {
        String jpql = "SELECT CASE WHEN COUNT(u) > 0 THEN TRUE ELSE FALSE END " +
                  "FROM Usuario u WHERE u.correo = :email";
        return em.createQuery(jpql, Boolean.class)
             .setParameter("email", email)
             .getSingleResult();
    }

    @Override
    public List<Usuario> buscarPorRol(Rol rol) {
        String jpql = "SELECT u FROM Usuario u WHERE u.rol = :rol ORDER BY u.apellido ASC";

        TypedQuery<Usuario> q = em.createQuery(jpql, Usuario.class);
        q.setParameter("rol", rol);

        return q.getResultList(); 
    }
    
    @Override
    public List<Usuario> listarTodos() {
        String jpql = "SELECT u FROM Usuario u ORDER BY u.apellido ASC, u.nombre ASC";
        TypedQuery<Usuario> q = em.createQuery(jpql, Usuario.class);

        return q.getResultList();
    }
    
    @Override
    public Usuario buscarPorId(Long id) {
        return em.find(Usuario.class, id);
    }
    
    @Override
    public void editar(Usuario usuario) {
        try {
            em.getTransaction().begin();
            em.merge(usuario); // .merge() actualiza un objeto existente
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace();
        }
    }
    
}
