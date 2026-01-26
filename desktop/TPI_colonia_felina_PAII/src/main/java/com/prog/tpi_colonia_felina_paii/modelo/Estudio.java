
package com.prog.tpi_colonia_felina_paii.modelo;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
public class Estudio {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idEstudio;
    
    private LocalDate fecha;
    
    private String tipoDeEstudio;
    
    private String observaciones;
    
    private String rutaArchivo;
    
    @ManyToOne(optional = false, fetch = FetchType.LAZY)
    @JoinColumn(name = "id_veterinario", nullable = false,
                foreignKey = @ForeignKey(name = "fk_estudio_veterinario"))
    private Veterinario veterinario;
    
    @ManyToOne(optional = false, fetch = FetchType.LAZY)
    @JoinColumn(name = "id_historial", nullable = false,
                foreignKey = @ForeignKey(name = "fk_estudio_historial"))
    private HistorialMedico historial;

    public Estudio() {
    }

    public Estudio(LocalDate fecha, String tipoDeEstudio, String observaciones, String rutaArchivo, Veterinario veterinario) {
        this.fecha = fecha;
        this.tipoDeEstudio = tipoDeEstudio;
        this.observaciones = observaciones;
        this.rutaArchivo = rutaArchivo;
        this.veterinario = veterinario;
    }

    public Long getIdEstudio() {
        return idEstudio;
    }

    public void setIdEstudio(Long idEstudio) {
        this.idEstudio = idEstudio;
    }

    public LocalDate getFecha() {
        return fecha;
    }

    public void setFecha(LocalDate fecha) {
        this.fecha = fecha;
    }

    public String getTipoDeEstudio() {
        return tipoDeEstudio;
    }

    public void setTipoDeEstudio(String tipoDeEstudio) {
        this.tipoDeEstudio = tipoDeEstudio;
    }

    public String getObservaciones() {
        return observaciones;
    }

    public void setObservaciones(String observaciones) {
        this.observaciones = observaciones;
    }

    public String getRutaArchivo() {
        return rutaArchivo;
    }

    public void setRutaArchivo(String rutaArchivo) {
        this.rutaArchivo = rutaArchivo;
    }

    public Veterinario getVeterinario() {
        return veterinario;
    }

    public void setVeterinario(Veterinario veterinario) {
        this.veterinario = veterinario;
    }

    public HistorialMedico getHistorial() {
        return historial;
    }

    public void setHistorial(HistorialMedico historial) {
        this.historial = historial;
    }
    
    

}
