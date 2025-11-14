
package com.prog.tpi_colonia_felina_paii.modelo;

import com.prog.tpi_colonia_felina_paii.enums.TipoDeTarea;
import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
public class Tarea {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idTarea;
    
    private LocalDate fecha;
    
    @Enumerated(EnumType.STRING)
    private TipoDeTarea tipoDeTarea;
    
    private String observaciones;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_gato", nullable = false)
    private Gato gato;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_usuario", nullable = false)
    private Usuario usuario; //el voluntario que realizo la tarea
    
    private String ubicacion;

    public Tarea() {
    }

    public Tarea(LocalDate fecha, TipoDeTarea tipoDeTarea, String observaciones, Gato gato, Usuario usuario, String ubicacion) {
        this.fecha = fecha;
        this.tipoDeTarea = tipoDeTarea;
        this.observaciones = observaciones;
        this.gato = gato;
        this.usuario = usuario;
        this.ubicacion = ubicacion;
    }

    public Long getIdTarea() {
        return idTarea;
    }

    public void setIdTarea(Long idTarea) {
        this.idTarea = idTarea;
    }

    public LocalDate getFecha() {
        return fecha;
    }

    public void setFecha(LocalDate fecha) {
        this.fecha = fecha;
    }

    public TipoDeTarea getTipoDeTarea() {
        return tipoDeTarea;
    }

    public void setTipoDeTarea(TipoDeTarea tipoDeTarea) {
        this.tipoDeTarea = tipoDeTarea;
    }

    public String getObservaciones() {
        return observaciones;
    }

    public void setObservaciones(String observaciones) {
        this.observaciones = observaciones;
    }

    public Gato getGato() {
        return gato;
    }

    public void setGato(Gato gato) {
        this.gato = gato;
    }

    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }

    public String getUbicacion() {
        return ubicacion;
    }

    public void setUbicacion(String ubicacion) {
        this.ubicacion = ubicacion;
    }
    
    
}
