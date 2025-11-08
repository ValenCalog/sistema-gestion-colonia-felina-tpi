
package com.prog.tpi_colonia_felina_paii.modelo;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;
import jakarta.persistence.OrderBy;
import java.util.ArrayList;
import java.util.List;

@Entity
public class HistorialMedico {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @OneToOne
    @JoinColumn(name = "gato_id", nullable = false, unique = true)
    private Gato gato;
    
    @OneToMany(
        mappedBy = "historial",
        cascade = CascadeType.ALL,     
        orphanRemoval = true,          
        fetch = FetchType.LAZY
    )
    @OrderBy("fecha DESC")
    private List<Estudio> estudios = new ArrayList<>();
    
    @OneToMany(
        mappedBy = "historial",
        cascade = CascadeType.ALL,     
        orphanRemoval = true,          
        fetch = FetchType.LAZY
    )
    @OrderBy("fecha DESC")
    private List<Diagnostico> diagnosticos = new ArrayList<>();

    public HistorialMedico() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Gato getGato() {
        return gato;
    }

    public void setGato(Gato gato) {
        this.gato = gato;
    }
    
    public void agregarEstudio(Estudio e) {
        estudios.add(e);
        e.setHistorial(this);
    }
    
}
