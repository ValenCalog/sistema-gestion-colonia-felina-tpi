
package com.prog.tpi_colonia_felina_paii.modelo;

import com.prog.tpi_colonia_felina_paii.enums.EstadoUsuario;
import com.prog.tpi_colonia_felina_paii.enums.Rol;
import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Inheritance;
import jakarta.persistence.InheritanceType;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;
import java.util.ArrayList;
import java.util.List;

@Entity
@Inheritance(strategy = InheritanceType.JOINED) 
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
    
    @OneToOne(mappedBy = "usuario", cascade = {CascadeType.PERSIST, CascadeType.MERGE}, fetch = FetchType.LAZY, optional = true)
    private Reputacion reputacion;
    
    //Relacion con familia si tiene rol MIEMBRO_FAMILIA:
    @ManyToOne
    @JoinColumn(name = "id_familia")
    private Familia familia;
    
    @OneToMany(mappedBy = "usuario")
    private List<Tarea> tareas = new ArrayList<>(); //tareas que realizó

    public Usuario() {
    }

    public Usuario(String nombre, String apellido, String DNI, String correo, String telefono, String contrasenia, EstadoUsuario Estado, Rol rol) {
        this.nombre = nombre;
        this.apellido = apellido;
        this.DNI = DNI;
        this.correo = correo;
        this.telefono = telefono;
        this.contrasenia = contrasenia;
        this.Estado = Estado;
        this.rol = rol;
    }

    public Long getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(Long idUsuario) {
        this.idUsuario = idUsuario;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getApellido() {
        return apellido;
    }

    public void setApellido(String apellido) {
        this.apellido = apellido;
    }

    public String getDNI() {
        return DNI;
    }

    public void setDNI(String DNI) {
        this.DNI = DNI;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getContrasenia() {
        return contrasenia;
    }

    public void setContrasenia(String contrasenia) {
        this.contrasenia = contrasenia;
    }

    public EstadoUsuario getEstado() {
        return Estado;
    }

    public void setEstado(EstadoUsuario Estado) {
        this.Estado = Estado;
    }

    public Rol getRol() {
        return rol;
    }

    public void setRol(Rol rol) {
        this.rol = rol;
    }

    public Reputacion getReputacion() {
        return reputacion;
    }

    public void setReputacion(Reputacion reputacion) {
        this.reputacion = reputacion;
    }

    public Familia getFamilia() {
        return familia;
    }

    public void setFamilia(Familia familia) {
        this.familia = familia;
    }

    public List<Tarea> getTareas() {
        return tareas;
    }

    public void setTareas(List<Tarea> tareas) {
        this.tareas = tareas;
    }

}
