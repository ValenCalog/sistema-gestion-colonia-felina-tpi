
package Clases;

public class Veterinario extends Usuario{
    private int matricula;

    public Veterinario(int matricula, String idUsuario, String nombre, String apellido, String DNI, String correo, String telefono, String contraseña, String estado, String rol, Reputacion unaReputacion) {
        super(idUsuario, nombre, apellido, DNI, correo, telefono, contraseña, estado, rol, unaReputacion);
        this.matricula = matricula;
    }
    
    public String getNombre(){
        return nombre; 
        //Esto obviamente requerira mas adelante otra implementacion
        //Por ahora esta asi SOLO para ver el nombre del veterinario en el Estudio
    }
    
    public int getMatricula() {
        return matricula;
    }

    public void setMatricula(int matricula) {
        this.matricula = matricula;
    } 
    
}
