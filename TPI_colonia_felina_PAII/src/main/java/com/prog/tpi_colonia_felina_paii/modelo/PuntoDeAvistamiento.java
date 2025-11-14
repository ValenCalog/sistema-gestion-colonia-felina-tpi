
package com.prog.tpi_colonia_felina_paii.modelo;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;

@Entity
public class PuntoDeAvistamiento {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private String id;
    private String nombre;
    
    private Double latitud;
    private Double longitud;
    
    @ManyToOne
    @JoinColumn(name = "id_zona", nullable = false)
    private Zona zona;

    public PuntoDeAvistamiento() {
    }

    public PuntoDeAvistamiento(String nombre, Double latitud, Double longitud, Zona zona) {
        this.nombre = nombre;
        this.latitud = latitud;
        this.longitud = longitud;
        this.zona = zona;
    }
    
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public Double getLatitud() {
        return latitud;
    }

    public void setLatitud(Double latitud) {
        this.latitud = latitud;
    }

    public Double getLongitud() {
        return longitud;
    }

    public void setLongitud(Double longitud) {
        this.longitud = longitud;
    }

    public Zona getZona() {
        return zona;
    }

    public void setZona(Zona zona) {
        this.zona = zona;
    }
    
}
