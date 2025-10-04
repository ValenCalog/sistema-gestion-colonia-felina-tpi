
package Clases;

public class Usuario{
    private String idUsuario;
    private String nombre;
    private String apellido;
    private String DNI;
    private String correo;
    private String telefono;
    private String contraseña;
    private String estado;
    private String rol;
    private Reputacion unaReputacion;
    
    //Veterinario deberia seguir siendo subclase de usuario? Siendo que no va a tener Familia.
    
    public Usuario(String idUsuario, String nombre, String apellido, String DNI, String correo, String telefono, String contraseña, String estado, String rol, Reputacion unaReputacion) {
        this.idUsuario = idUsuario;
        this.nombre = nombre;
        this.apellido = apellido;
        this.DNI = DNI;
        this.correo = correo;
        this.telefono = telefono;
        this.contraseña = contraseña;
        this.estado = estado;
        this.rol = rol;
        this.unaReputacion = unaReputacion;
    }

    public String getRol() {
        return rol;
    }

    public void setRol(String rol) {
        this.rol = rol;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public String getNombreYApellido() {
        return nombre + " " + apellido;
    }
    
    public String getInfoBasica(){
        return "Usuario: " + getNombreYApellido() + " - DNI: " + DNI + " - Rol: " + rol;
    }
    
}


