
package com.prog.tpi_colonia_felina_paii.dao;

import com.prog.tpi_colonia_felina_paii.enums.EstadoUsuario;
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
    
    @Override
    public List<Usuario> buscarConFiltros(String textoBusqueda, Rol rolFiltro) {
        // Construimos la consulta base
        StringBuilder jpql = new StringBuilder("SELECT u FROM Usuario u WHERE 1=1");

        // 1. Filtro de Texto (Nombre, Apellido o Correo)
        if (textoBusqueda != null && !textoBusqueda.isEmpty()) {
            jpql.append(" AND (LOWER(u.nombre) LIKE :texto OR LOWER(u.apellido) LIKE :texto OR LOWER(u.correo) LIKE :texto)");
        }

        // 2. Filtro de Rol
        if (rolFiltro != null) {
            jpql.append(" AND u.rol = :rol");
        }

        // Ordenamos
        jpql.append(" ORDER BY u.apellido ASC");

        var query = em.createQuery(jpql.toString(), Usuario.class);

        // Asignamos los parámetros si existen
        if (textoBusqueda != null && !textoBusqueda.isEmpty()) {
            query.setParameter("texto", "%" + textoBusqueda.toLowerCase() + "%");
        }
        if (rolFiltro != null) {
            query.setParameter("rol", rolFiltro);
        }

        return query.getResultList();
    }
    
    @Override
    public List<Usuario> buscarPorEstado(EstadoUsuario estado) {
        String jpql = "SELECT u FROM Usuario u WHERE u.Estado = :estado ORDER BY u.idUsuario DESC";
        TypedQuery<Usuario> query = em.createQuery(jpql, Usuario.class);
        query.setParameter("estado", estado);
        return query.getResultList();
    }
    
    
}
