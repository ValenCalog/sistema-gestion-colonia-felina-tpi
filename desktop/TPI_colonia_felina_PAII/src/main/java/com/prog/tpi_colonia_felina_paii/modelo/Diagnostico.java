
package com.prog.tpi_colonia_felina_paii.modelo;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.ForeignKey;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OrderBy;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Entity
public class Diagnostico {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idDiagnostico;
    
    private LocalDate fecha;
    private String descDetallada;
    private String observaciones;
    private String estadoClinico;
    
    @ManyToOne(optional = false, fetch = FetchType.LAZY)
    @JoinColumn(name = "id_historial", nullable = false,
                foreignKey = @ForeignKey(name = "fk_diagnostico_historial"))
    private HistorialMedico historial;
    
    @ManyToOne(optional = false, fetch = FetchType.LAZY)
    @JoinColumn(name = "id_veterinario", nullable = false,
                foreignKey = @ForeignKey(name = "fk_diagnostico_veterinario"))
    private Veterinario veterinario;
    
    @OneToMany(
        mappedBy = "diagnostico",
        cascade = CascadeType.ALL,     
        orphanRemoval = true,          
        fetch = FetchType.EAGER
    )
    @OrderBy("fechaTratamiento DESC")
    private List<Tratamiento> tratamientos = new ArrayList<>();

    public Diagnostico() {
    }

    public Diagnostico(LocalDate fecha, String descDetallada, String observaciones, String estadoClinico, HistorialMedico historial, Veterinario veterinario) {
        this.fecha = fecha;
        this.descDetallada = descDetallada;
        this.observaciones = observaciones;
        this.estadoClinico = estadoClinico;
        this.historial = historial;
        this.veterinario = veterinario;
    }

    public Long getIdDiagnostico() {
        return idDiagnostico;
    }

    public void setIdDiagnostico(Long idDiagnostico) {
        this.idDiagnostico = idDiagnostico;
    }

    public LocalDate getFecha() {
        return fecha;
    }

    public void setFecha(LocalDate fecha) {
        this.fecha = fecha;
    }

    public String getDescDetallada() {
        return descDetallada;
    }

    public void setDescDetallada(String descDetallada) {
        this.descDetallada = descDetallada;
    }

    public String getObservaciones() {
        return observaciones;
    }

    public void setObservaciones(String observaciones) {
        this.observaciones = observaciones;
    }

    public String getEstadoClinico() {
        return estadoClinico;
    }

    public void setEstadoClinico(String estadoClinico) {
        this.estadoClinico = estadoClinico;
    }

    public HistorialMedico getHistorial() {
        return historial;
    }

    public void setHistorial(HistorialMedico historial) {
        this.historial = historial;
    }

    public Veterinario getVeterinario() {
        return veterinario;
    }

    public void setVeterinario(Veterinario veterinario) {
        this.veterinario = veterinario;
    }

    public List<Tratamiento> getTratamientos() {
        return tratamientos;
    }

    public void setTratamientos(List<Tratamiento> tratamientos) {
        this.tratamientos = tratamientos;
    }
    
    
    
}
