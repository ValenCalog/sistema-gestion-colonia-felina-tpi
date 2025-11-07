
package com.prog.tpi_colonia_felina_paii.modelo;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import java.util.ArrayList;
import java.util.List;

@Entity
public class Zona {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idZona;
    
    private String nombre;
    private String descripcion;

    private Double latitud;
    private Double longitud;
    
    @OneToMany(mappedBy = "zona", cascade = CascadeType.ALL)
    private List<PuntoDeAvistamiento> puntosDeAvistamiento = new ArrayList<>();
    
    @OneToMany(mappedBy = "zona")
    private List<Gato> gatos = new ArrayList<>();
    
    public void agregarPunto(PuntoDeAvistamiento p) {
        puntosDeAvistamiento.add(p);
        p.setZona(this);
    }

    public void eliminarPunto(PuntoDeAvistamiento p) {
        puntosDeAvistamiento.remove(p);
        p.setZona(null);
    }

}
