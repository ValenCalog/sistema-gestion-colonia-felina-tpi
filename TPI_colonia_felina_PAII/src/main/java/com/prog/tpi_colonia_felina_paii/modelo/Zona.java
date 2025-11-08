
package com.prog.tpi_colonia_felina_paii.modelo;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import java.util.ArrayList;
import java.util.List;

@Entity
public class Zona {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idZona;
    
    private String nombre;
    private String descripcion;

    private Double latitud;
    private Double longitud;
    
    @OneToMany(mappedBy = "zona", cascade = CascadeType.ALL)
    private List<PuntoDeAvistamiento> puntosDeAvistamiento = new ArrayList<>();
    
    @OneToMany(mappedBy = "zona")
    private List<Gato> gatos = new ArrayList<>();

    public Zona() {
    }

    public Zona(String nombre, String descripcion, Double latitud, Double longitud) {
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.latitud = latitud;
        this.longitud = longitud;
    }
    
    public void agregarPunto(PuntoDeAvistamiento p) {
        puntosDeAvistamiento.add(p);
        p.setZona(this);
    }

    public void eliminarPunto(PuntoDeAvistamiento p) {
        puntosDeAvistamiento.remove(p);
        p.setZona(null);
    }

    public Long getIdZona() {
        return idZona;
    }

    public void setIdZona(Long idZona) {
        this.idZona = idZona;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
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

    public List<PuntoDeAvistamiento> getPuntosDeAvistamiento() {
        return puntosDeAvistamiento;
    }

    public void setPuntosDeAvistamiento(List<PuntoDeAvistamiento> puntosDeAvistamiento) {
        this.puntosDeAvistamiento = puntosDeAvistamiento;
    }

    public List<Gato> getGatos() {
        return gatos;
    }

    public void setGatos(List<Gato> gatos) {
        this.gatos = gatos;
    }
    
    

}
