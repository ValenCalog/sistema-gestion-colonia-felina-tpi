
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
    
    //VER TEMA UBICACION

}
