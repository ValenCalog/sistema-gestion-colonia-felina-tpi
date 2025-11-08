
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
        mappedBy = "historial",
        cascade = CascadeType.ALL,     
        orphanRemoval = true,          
        fetch = FetchType.LAZY
    )
    @OrderBy("fecha DESC")
    private List<Tratamiento> tratamientos = new ArrayList<>();
    
}
