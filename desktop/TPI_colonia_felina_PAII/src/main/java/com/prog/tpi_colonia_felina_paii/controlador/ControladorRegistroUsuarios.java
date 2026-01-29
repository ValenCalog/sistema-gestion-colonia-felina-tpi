
package com.prog.tpi_colonia_felina_paii.controlador;

import com.prog.tpi_colonia_felina_paii.dao.IFamiliaDAO;
import com.prog.tpi_colonia_felina_paii.dao.IUsuarioDAO;
import com.prog.tpi_colonia_felina_paii.dao.IVeterinarioDAO;
import com.prog.tpi_colonia_felina_paii.enums.DisponibilidadFamilia;
import com.prog.tpi_colonia_felina_paii.enums.EstadoUsuario;
import com.prog.tpi_colonia_felina_paii.enums.Rol;
import com.prog.tpi_colonia_felina_paii.modelo.Familia;
import com.prog.tpi_colonia_felina_paii.modelo.Usuario;
import com.prog.tpi_colonia_felina_paii.modelo.Veterinario;
import com.prog.tpi_colonia_felina_paii.util.PasswordHasher;


public class ControladorRegistroUsuarios {
    private final IUsuarioDAO usuarioDAO;
    private final IVeterinarioDAO veterinarioDAO;
    private final IFamiliaDAO familiaDAO;
    
    public ControladorRegistroUsuarios(IUsuarioDAO usuarioDAO, IVeterinarioDAO veterinarioDAO, IFamiliaDAO familiaDAO) {
        this.usuarioDAO = usuarioDAO;
        this.veterinarioDAO = veterinarioDAO;
        this.familiaDAO = familiaDAO;
    }
    
    public void registrarFamiliaNuevaConMiembro(
        String nombre,
        String apellido,
        String DNI,
        String emailUsuario,
        String password,
        String telefono,
        DisponibilidadFamilia disp,
        String observaciones,
        String direccion) {

    
        validarEmailUnico(emailUsuario);

        Familia fam = new Familia(disp, observaciones, direccion);      

        String hash = PasswordHasher.hash(password);
        Usuario u = new Usuario(nombre, apellido,DNI, emailUsuario, telefono,hash ,EstadoUsuario.ACTIVO ,Rol.MIEMBRO_FAMILIA);

        fam.agregarMiembroFamilia(u); // setea u.setFamilia(this)
        
        familiaDAO.crear(fam);
        
        if (fam.getIdFamilia() != null) {
            u.setFamilia(fam); 
        }
        
        usuarioDAO.crear(u);    
    
    }
    
     public void registrarAdmin(  String nombre,
        String apellido,
        String DNI,
        String email,
        String password,
        String telefono) {
        try {
            validarEmailUnico(email);
            var hash = PasswordHasher.hash(password);
            usuarioDAO.crear(new Usuario(nombre, apellido,DNI, email, telefono,hash ,EstadoUsuario.ACTIVO, Rol.ADMIN));
        } catch (RuntimeException e) {
            System.out.println("No se pudo registrar el admin");
        }
    }
   
    public void registrarVoluntario(String nombre,
        String apellido,
        String DNI,
        String email,
        String password,
        String telefono) {
        try {
            validarEmailUnico(email);
            var hash = PasswordHasher.hash(password);

            Usuario u = new Usuario(nombre, apellido, DNI, email, telefono, hash, 
                                    EstadoUsuario.PENDIENTE, 
                                    Rol.VOLUNTARIO);

            usuarioDAO.crear(u);
        } catch (RuntimeException e) {
            throw e;
        }
    }
    
     public void registrarVeterinario( String nombre,
        String apellido,
        String DNI,
        String email,
        String password,
        String telefono, String matricula) {
        try {
            validarEmailUnico(email);
            if (matricula == null || matricula.isBlank())
                throw new IllegalArgumentException("Matrícula obligatoria");

            var hash = PasswordHasher.hash(password);
            Usuario user =  new Usuario(nombre, apellido,DNI, email, telefono,hash ,EstadoUsuario.PENDIENTE ,Rol.VETERINARIO);
            usuarioDAO.crear(user);

            Veterinario vet = new Veterinario(matricula);
            veterinarioDAO.crear(vet);
        } catch (RuntimeException e) {
            throw e;
        }
    }
    
    private void validarEmailUnico(String email) {
        if (usuarioDAO.existeEmail(email)) {
            throw new IllegalArgumentException("El email ya está registrado");
        }
    }
    
    public void registrarUsuarioEnFamiliaExistente(String nombre, String apellido, String DNI,
            String email, String password, String telefono, long idFamilia) {

        validarEmailUnico(email);

        Familia familia = familiaDAO.buscarPorId(idFamilia);
        
        if (familia == null) {
            throw new IllegalArgumentException("Error de seguridad: La familia no existe.");
        }

        String hash = PasswordHasher.hash(password);
        
        Usuario nuevoUsuario = new Usuario(
            nombre, 
            apellido, 
            DNI, 
            email, 
            telefono, 
            hash, 
            EstadoUsuario.ACTIVO, // Entra directo porque tiene el código
            Rol.MIEMBRO_FAMILIA
        );

        nuevoUsuario.setFamilia(familia);

        usuarioDAO.crear(nuevoUsuario);
    }
    
    public Familia buscarFamiliaPorCodigo(String codigo) {
        if (codigo == null || codigo.trim().isEmpty()) {
            return null;
        }
        
        return familiaDAO.buscarPorCodigo(codigo.trim().toUpperCase());
    }
}
