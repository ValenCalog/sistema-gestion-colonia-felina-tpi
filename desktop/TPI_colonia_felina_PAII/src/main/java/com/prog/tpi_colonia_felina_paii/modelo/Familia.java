
package com.prog.tpi_colonia_felina_paii.modelo;

import com.prog.tpi_colonia_felina_paii.enums.DisponibilidadFamilia;
import jakarta.persistence.*;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Entity
public class Familia {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idFamilia;
    
    @Enumerated(EnumType.STRING)
    private DisponibilidadFamilia disponibilidad;
    private String observaciones;
    private String direccion;
    
    @Column(unique = true)
    private String codigoFamilia; //este codigo pueden compartirse a los usuarios miembros de la familia para unirse a ella

    @OneToMany(mappedBy = "familia", orphanRemoval = false)
    private List<Usuario> miembrosFamilia = new ArrayList<>();
    
    @OneToMany(mappedBy = "familiaAdoptante", orphanRemoval = false)
    private List<Adopcion> adopciones = new ArrayList<>();
    
    @OneToMany(mappedBy = "familiaPostulante", orphanRemoval = false)
    private List<Postulacion> postulaciones = new ArrayList<>();

    public Familia() {
    }

    public Familia(DisponibilidadFamilia disponibilidad, String observaciones, String direccion) {
        this.disponibilidad = disponibilidad;
        this.observaciones = observaciones;
        this.direccion = direccion;
    }
    
    @PrePersist
    private void generarCodigoFamilia(){
        if(codigoFamilia == null || codigoFamilia.isBlank()){
            //genera un codigo de 8 caracteres random
            codigoFamilia = UUID.randomUUID().toString().replace("-", "").substring(0, 8).toUpperCase();
        }
    }
    
    public void agregarPostulacion(Postulacion p){
        postulaciones.add(p);
        p.setFamiliaPostulante(this);
    }
    
    public void agregarAdopcion(Adopcion a){
        adopciones.add(a);
        a.setFamiliaAdoptante(this);
    }

    public Long getIdFamilia() {
        return idFamilia;
    }

    public DisponibilidadFamilia getDisponibilidad() {
        return disponibilidad;
    }

    public String getObservaciones() {
        return observaciones;
    }

    public String getDireccion() {
        return direccion;
    }

    public String getCodigoFamilia() {
        return codigoFamilia;
    }

    public List<Usuario> getMiembrosFamilia() {
        return miembrosFamilia;
    }

    public List<Adopcion> getAdopciones() {
        return adopciones;
    }

    public List<Postulacion> getPostulaciones() {
        return postulaciones;
    }

    public void setIdFamilia(Long idFamilia) {
        this.idFamilia = idFamilia;
    }

    public void setDisponibilidad(DisponibilidadFamilia disponibilidad) {
        this.disponibilidad = disponibilidad;
    }

    public void setObservaciones(String observaciones) {
        this.observaciones = observaciones;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public void setCodigoFamilia(String codigoFamilia) {
        this.codigoFamilia = codigoFamilia;
    }

    public void setMiembrosFamilia(List<Usuario> miembrosFamilia) {
        this.miembrosFamilia = miembrosFamilia;
    }

    public void setAdopciones(List<Adopcion> adopciones) {
        this.adopciones = adopciones;
    }

    public void setPostulaciones(List<Postulacion> postulaciones) {
        this.postulaciones = postulaciones;
    }
    
    public void agregarMiembroFamilia(Usuario miembro){
        miembrosFamilia.add(miembro);
        miembro.setFamilia(this);
    }
    
}