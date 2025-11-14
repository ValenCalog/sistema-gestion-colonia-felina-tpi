package com.prog.tpi_colonia_felina_paii.modelo;

import com.prog.tpi_colonia_felina_paii.enums.EstadoUsuario;
import com.prog.tpi_colonia_felina_paii.enums.Rol;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.PrimaryKeyJoinColumn;

@Entity
@PrimaryKeyJoinColumn(name = "id_usuario")
public class Veterinario extends Usuario{
    
    @Column(unique = true, nullable = false)
    private String matricula;

    public Veterinario() {
    }
    
    public Veterinario(String matricula, String nombre, String apellido, String DNI, String correo, String telefono, String contrasenia, EstadoUsuario Estado) {
        super(nombre, apellido, DNI, correo, telefono, contrasenia, Estado, Rol.VETERINARIO);
        this.matricula = matricula;
    }

    public String getMatricula() {
        return matricula;
    }

    public void setMatricula(String matricula) {
        this.matricula = matricula;
    }
    
    

}
