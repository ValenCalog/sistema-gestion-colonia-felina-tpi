
package com.prog.tpi_colonia_felina_paii.modelo;

import com.prog.tpi_colonia_felina_paii.enums.TipoAdopcion;
import jakarta.persistence.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

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
    
    @OneToMany(mappedBy = "adopcion",
           cascade = { CascadeType.PERSIST, CascadeType.MERGE },
           orphanRemoval = false,
           fetch = FetchType.LAZY)
    @OrderBy("fechaHora DESC")
    private List<Seguimiento> seguimientos = new ArrayList<>();

    public Adopcion() {
    }

    public Adopcion(TipoAdopcion tipo, String estado, Gato gato) {
        this.tipo = tipo;
        this.fecha = LocalDate.now();
        this.estado = estado;
        this.gato = gato;
    }
    
    public void agregarSeguimiento(Seguimiento s) {
        seguimientos.add(s);
        s.setAdopcion(this);
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

    public List<Seguimiento> getSeguimientos() {
        return seguimientos;
    }

    public void setSeguimientos(List<Seguimiento> seguimientos) {
        this.seguimientos = seguimientos;
    }

    

}
