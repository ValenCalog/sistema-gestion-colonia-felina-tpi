
package com.prog.tpi_colonia_felina_paii.modelo;

import com.prog.tpi_colonia_felina_paii.enums.Disponibilidad;
import com.prog.tpi_colonia_felina_paii.enums.EstadoPostulacion;
import com.prog.tpi_colonia_felina_paii.enums.TipoAdopcion;
import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
public class Postulacion {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idPostulacion;
    
    private LocalDate fecha;
    
    @Enumerated(EnumType.STRING)
    private TipoAdopcion tipoAdopcion;
    
    private String observacion;
    
    @Enumerated(EnumType.STRING)
    private EstadoPostulacion estado;
    
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "gato_id", nullable = false)
    private Gato gato;
    
    @ManyToOne
    @JoinColumn(name = "id_familia", nullable = false) 
    private Familia familiaPostulante;
    
    @ManyToOne
    @JoinColumn(name = "id_usuario_postulante", nullable = false) 
    private Usuario miembroPostulante; //  Usuario específico (miembro de la familia) que la realizó

    public Postulacion() {
    }

    public Postulacion(TipoAdopcion tipoAdopcion, String observacion, Gato gato, Familia familiaPostulante, Usuario miembroPostulante) {
        this.fecha = LocalDate.now();
        this.tipoAdopcion = tipoAdopcion;
        this.observacion = observacion;
        this.estado = EstadoPostulacion.PENDIENTE;
        this.gato = gato;
        this.familiaPostulante = familiaPostulante;
        this.miembroPostulante = miembroPostulante;
    }
    
    public Gato getGato() {
        return gato;
    }

    public void setGato(Gato gato) {
        this.gato = gato;
    }

    public Familia getFamiliaPostulante() {
        return familiaPostulante;
    }

    public void setFamiliaPostulante(Familia familiaPostulante) {
        this.familiaPostulante = familiaPostulante;
    }
    
    public void aceptarPostulacion(){
        this.estado = EstadoPostulacion.ACEPTADA;
        gato.setDisponibilidad(Disponibilidad.ADOPTADO);
    }
    
    public void rechazarPostulacion(){
        this.estado = EstadoPostulacion.RECHAZADA;
    }

    public Long getIdPostulacion() {
        return idPostulacion;
    }

    public void setIdPostulacion(Long idPostulacion) {
        this.idPostulacion = idPostulacion;
    }

    public LocalDate getFecha() {
        return fecha;
    }

    public void setFecha(LocalDate fecha) {
        this.fecha = fecha;
    }

    public TipoAdopcion getTipoAdopcion() {
        return tipoAdopcion;
    }

    public void setTipoAdopcion(TipoAdopcion tipoAdopcion) {
        this.tipoAdopcion = tipoAdopcion;
    }

    public String getObservacion() {
        return observacion;
    }

    public void setObservacion(String observacion) {
        this.observacion = observacion;
    }

    public EstadoPostulacion getEstado() {
        return estado;
    }

    public void setEstado(EstadoPostulacion estado) {
        this.estado = estado;
    }

    public Usuario getMiembroPostulante() {
        return miembroPostulante;
    }

    public void setMiembroPostulante(Usuario miembroPostulante) {
        this.miembroPostulante = miembroPostulante;
    }
    
    
}
