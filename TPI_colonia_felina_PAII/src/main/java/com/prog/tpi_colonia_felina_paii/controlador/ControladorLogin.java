
package com.prog.tpi_colonia_felina_paii.controlador;

import com.prog.tpi_colonia_felina_paii.dao.IUsuarioDAO;
import com.prog.tpi_colonia_felina_paii.modelo.Usuario;
import com.prog.tpi_colonia_felina_paii.util.PasswordHasher;

public class ControladorLogin {
    private final IUsuarioDAO usuarioDAO;

    public ControladorLogin() {
        this.usuarioDAO = null;
    }
    
    public Usuario login(String email, String password){
        Usuario u = usuarioDAO.buscarPorEmail(email);
        if (u == null){
            throw new IllegalArgumentException("Usuario o contraseña incorrectos");
        }
        if (!PasswordHasher.matches(password, u.getContrasenia())){
              throw new IllegalArgumentException("Usuario o contraseña incorrectos");
        }
        return u;
    }

    public Usuario autenticar(String correo, String password) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}
