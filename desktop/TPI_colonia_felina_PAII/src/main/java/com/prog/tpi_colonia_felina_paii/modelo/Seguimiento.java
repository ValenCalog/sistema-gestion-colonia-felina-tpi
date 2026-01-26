
package com.prog.tpi_colonia_felina_paii.modelo;

import com.prog.tpi_colonia_felina_paii.enums.TipoContacto;
import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
public class Seguimiento {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idSeguimiento;
    
    private LocalDate fecha;
    
    @Enumerated(EnumType.STRING)
    private TipoContacto tipoDeContacto;
    
    private String observaciones;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_adopcion", nullable = false)
    private Adopcion adopcion;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_voluntario", nullable = false)
    private Usuario voluntario; //voluntario que realizó el seguimiento

    public Seguimiento() {
    }

    public Seguimiento(LocalDate fecha, TipoContacto tipoDeContacto, String observaciones, Adopcion adopcion, Usuario voluntario) {
        this.fecha = fecha;
        this.tipoDeContacto = tipoDeContacto;
        this.observaciones = observaciones;
        this.adopcion = adopcion;
        this.voluntario = voluntario;
    }

    public void setAdopcion(Adopcion adopcion) {
        this.adopcion = adopcion;
    }

    public Long getIdSeguimiento() {
        return idSeguimiento;
    }

    public void setIdSeguimiento(Long idSeguimiento) {
        this.idSeguimiento = idSeguimiento;
    }

    public LocalDate getFecha() {
        return fecha;
    }

    public void setFecha(LocalDate fecha) {
        this.fecha = fecha;
    }

    public TipoContacto getTipoDeContacto() {
        return tipoDeContacto;
    }

    public void setTipoDeContacto(TipoContacto tipoDeContacto) {
        this.tipoDeContacto = tipoDeContacto;
    }

    public String getObservaciones() {
        return observaciones;
    }

    public void setObservaciones(String observaciones) {
        this.observaciones = observaciones;
    }

    public Usuario getVoluntario() {
        return voluntario;
    }

    public void setVoluntario(Usuario voluntario) {
        this.voluntario = voluntario;
    }
    
    
}
