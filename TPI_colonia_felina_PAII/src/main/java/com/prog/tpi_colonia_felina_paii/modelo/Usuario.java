
package com.prog.tpi_colonia_felina_paii.modelo;

import com.prog.tpi_colonia_felina_paii.enums.EstadoUsuario;
import com.prog.tpi_colonia_felina_paii.enums.Rol;
import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToOne;

@Entity
public class Usuario {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idUsuario;
    
    private String nombre;
    
    private String apellido;
    
    private String DNI;
    
    @Column(unique = true)
    private String correo;
    
    private String telefono;
    
    private String contrasenia; //(encriptada)
    
    @Enumerated(EnumType.STRING)
    private EstadoUsuario Estado;
    
    @Enumerated(EnumType.STRING)
    private Rol rol;
    
    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "id_reputacion", nullable = true) 
    private Reputacion reputacion;
    
    //Relacion con familia si tiene rol MIEMBRO_FAMILIA:
    @ManyToOne
    @JoinColumn(name = "id_familia")
    private Familia familia;
    
}
