
package com.prog.tpi_colonia_felina_paii.modelo;

import com.prog.tpi_colonia_felina_paii.enums.TipoAdopcion;
import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
public class Adopcion {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idAdopcion;
    
    @Enumerated(EnumType.STRING)
    private TipoAdopcion tipo;
    
    private LocalDate fecha;
    
    private String estado;
    
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "gato_id", nullable = false)
    private Gato gato;
    
    @ManyToOne
    @JoinColumn(name = "id_familia")
    private Familia familiaAdoptante;

    public Adopcion(TipoAdopcion tipo, String estado, Gato gato) {
        this.tipo = tipo;
        this.fecha = LocalDate.now();
        this.estado = estado;
        this.gato = gato;
    }

    public Adopcion() {
    }

    public Long getIdAdopcion() {
        return idAdopcion;
    }

    public void setIdAdopcion(Long idAdopcion) {
        this.idAdopcion = idAdopcion;
    }

    public TipoAdopcion getTipo() {
        return tipo;
    }

    public void setTipo(TipoAdopcion tipo) {
        this.tipo = tipo;
    }

    public LocalDate getFecha() {
        return fecha;
    }

    public void setFecha(LocalDate fecha) {
        this.fecha = fecha;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public Gato getGato() {
        return gato;
    }

    public void setGato(Gato gato) {
        this.gato = gato;
    }

    public Familia getFamiliaAdoptante() {
        return familiaAdoptante;
    }

    public void setFamiliaAdoptante(Familia familiaAdoptante) {
        this.familiaAdoptante = familiaAdoptante;
    }

}
