
package com.prog.tpi_colonia_felina_paii.modelo;

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
    
    
    
    
}
