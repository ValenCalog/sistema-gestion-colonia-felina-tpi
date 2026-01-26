
package com.prog.tpi_colonia_felina_paii.dao;

import com.prog.tpi_colonia_felina_paii.modelo.Usuario;


public interface IUsuarioDAO {
    public void crear(Usuario usuario);
    public Usuario buscarPorEmail(String email);
    public boolean existeEmail(String email);
}
