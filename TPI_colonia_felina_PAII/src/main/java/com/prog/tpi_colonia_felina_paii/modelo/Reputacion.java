
package com.prog.tpi_colonia_felina_paii.modelo;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToOne;

@Entity
public class Reputacion {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idReputacion;
    
    private int cantidadValoraciones;
    
    private double promedioValoracion;
    
    @OneToOne(mappedBy = "reputacion")
    private Usuario usuario;

    public Reputacion() {
    }
    
    public void agregarValoracion(int nuevaValoracion){
        double totalAnterior = promedioValoracion * cantidadValoraciones;
        cantidadValoraciones++;
        promedioValoracion = (totalAnterior + nuevaValoracion) / cantidadValoraciones;
    }

    public Long getIdReputacion() {
        return idReputacion;
    }

    public void setIdReputacion(Long idReputacion) {
        this.idReputacion = idReputacion;
    }

    public int getCantidadValoraciones() {
        return cantidadValoraciones;
    }

    public void setCantidadValoraciones(int cantidadValoraciones) {
        this.cantidadValoraciones = cantidadValoraciones;
    }

    public double getPromedioValoracion() {
        return promedioValoracion;
    }

    public void setPromedioValoracion(double promedioValoracion) {
        this.promedioValoracion = promedioValoracion;
    }

    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }
    
}
