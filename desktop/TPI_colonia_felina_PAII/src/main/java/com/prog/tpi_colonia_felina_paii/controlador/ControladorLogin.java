
package com.prog.tpi_colonia_felina_paii.controlador;

import com.prog.tpi_colonia_felina_paii.dao.IUsuarioDAO;
import com.prog.tpi_colonia_felina_paii.dao.UsuarioDAOJPAImpl;
import com.prog.tpi_colonia_felina_paii.enums.EstadoUsuario;
import com.prog.tpi_colonia_felina_paii.modelo.Usuario;
import com.prog.tpi_colonia_felina_paii.util.PasswordHasher;

public class ControladorLogin {
    private final IUsuarioDAO usuarioDAO;

    public ControladorLogin() {
        this.usuarioDAO = new UsuarioDAOJPAImpl();
    }
    
    public Usuario login(String email, String password){
        Usuario u = usuarioDAO.buscarPorEmail(email);
        if (u.getEstado() != EstadoUsuario.ACTIVO) {
                    throw new IllegalArgumentException("Tu cuenta aún no ha sido aprobada por un administrador.");
            }
        if (u == null){
            throw new IllegalArgumentException("Usuario o contraseña incorrectos");
        }
        if (!PasswordHasher.matches(password, u.getContrasenia())){
              throw new IllegalArgumentException("Usuario o contraseña incorrectos");
        }
        return u;
    }

    public Usuario autenticar(String correo, String password) {
        Usuario u = usuarioDAO.buscarPorEmail(correo);
        if(u != null){
            if(PasswordHasher.matches(password, u.getContrasenia())){
                    return u;
            }else{
                return null;
            }
        }else{
            return null;
        }
    }
}
