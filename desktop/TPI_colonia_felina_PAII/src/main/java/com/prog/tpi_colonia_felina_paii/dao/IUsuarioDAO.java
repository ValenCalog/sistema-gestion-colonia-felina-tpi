
package com.prog.tpi_colonia_felina_paii.dao;

import com.prog.tpi_colonia_felina_paii.enums.EstadoUsuario;
import com.prog.tpi_colonia_felina_paii.enums.Rol;
import com.prog.tpi_colonia_felina_paii.modelo.Usuario;
import java.util.List;


public interface IUsuarioDAO {
    public void crear(Usuario usuario);
    public Usuario buscarPorEmail(String email);
    public boolean existeEmail(String email);
    public List<Usuario> buscarPorRol(Rol rol);
    public List<Usuario> listarTodos();
    public Usuario buscarPorId(Long id);
    public void editar(Usuario usuario);
    public List<Usuario> buscarConFiltros(String textoBusqueda, Rol rolFiltro);
    public List<Usuario> buscarPorEstado(EstadoUsuario estado);
}
