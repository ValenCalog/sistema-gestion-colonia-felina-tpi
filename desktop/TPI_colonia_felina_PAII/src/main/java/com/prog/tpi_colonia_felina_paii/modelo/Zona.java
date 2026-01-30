
package com.prog.tpi_colonia_felina_paii.modelo;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
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
    
    @Column(columnDefinition = "TEXT") 
    private String coordenadas; // el JSON gigante que genera Leaflet:
    
    @OneToMany(mappedBy = "zona", cascade = CascadeType.ALL)
    private List<PuntoDeAvistamiento> puntosDeAvistamiento = new ArrayList<>();
    
    @OneToMany(mappedBy = "zona")
    private List<Gato> gatos = new ArrayList<>();

    public Zona() {
    }

    public Zona(String nombre, String descripcion, String coordenadas) {
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.coordenadas = coordenadas;
        
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

    public String getCoordenadas() {
        return coordenadas;
    }

    public void setCoordenadas(String coordenadas) {
        this.coordenadas = coordenadas;
    }
    
}
