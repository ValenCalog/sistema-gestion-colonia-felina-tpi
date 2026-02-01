
package com.prog.tpi_colonia_felina_paii.modelo;

import com.prog.tpi_colonia_felina_paii.enums.Disponibilidad;
import com.prog.tpi_colonia_felina_paii.enums.EstadoSalud;
import com.prog.tpi_colonia_felina_paii.enums.Sexo;
import jakarta.persistence.CascadeType;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;
import jakarta.persistence.OrderBy;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Entity
public class Gato {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idGato;
    
    private String nombre;
    private String color;
    private String caracteristicas;
    private String fotografia; //es la url de la foto
    private EstadoSalud estadoSalud;
    private Disponibilidad disponibilidad;
    
    //-------Atributos relaciones
    
    @OneToOne(mappedBy = "gato", cascade = CascadeType.ALL, orphanRemoval = true)
    private HistorialMedico historialMedico;
    
    @OneToOne(mappedBy = "gato", cascade = CascadeType.ALL, orphanRemoval = true)
    private CertificadoAptitud certificado;
    
    @OneToMany(
        mappedBy = "gato",
        cascade = { CascadeType.PERSIST, CascadeType.MERGE }, 
        orphanRemoval = false,                                 
        fetch = FetchType.LAZY
    )
    @OrderBy("fecha DESC") // para que se ordene por fecha mas reciente
    private List<Adopcion> adopciones = new ArrayList<>();
    
    @OneToMany(
        mappedBy = "gato",
        cascade = CascadeType.ALL,
        orphanRemoval = false,
        fetch = FetchType.LAZY
        )
    @OrderBy("fecha DESC")
    private List<Postulacion> postulaciones = new ArrayList<>();
    
    //gato puede tener zona o punto de avistamiento: 
    @ManyToOne
    @JoinColumn(name = "id_zona", nullable = true)
    private Zona zona;
    
    @ManyToOne(cascade = CascadeType.ALL) // <--- ¡AGREGA ESTO!
    @JoinColumn(name = "id_punto_avistamiento", nullable = true)
    private PuntoDeAvistamiento puntoAvistamiento;
    
    @OneToMany(mappedBy = "gato")
    private List<Tarea> tareas = new ArrayList<>(); //tareas que se realizaron sobre el gato
    
    @Enumerated(EnumType.STRING)
    private Sexo sexo;

    private boolean esterilizado; // true = Si, false = No
    
    private String qrCodePath; // Ruta de la imagen del QR)

    private LocalDate fechaAlta;

    
    
    public LocalDate getFechaAlta() {
        return fechaAlta;
    }

    public void setFechaAlta(LocalDate fechaAlta) {
        this.fechaAlta = fechaAlta;
    }
    
    public Sexo getSexo() { return sexo; }
    public void setSexo(Sexo sexo) { this.sexo = sexo; }

    public boolean isEsterilizado() { return esterilizado; } // Getter de boolean suele ser "is"
    public void setEsterilizado(boolean esterilizado) { this.esterilizado = esterilizado; }

    public String getQrCodePath() { return qrCodePath; }
    public void setQrCodePath(String qrCodePath) { this.qrCodePath = qrCodePath; }
    

    public Gato(){
        this.historialMedico = new HistorialMedico();
        this.historialMedico.setGato(this);
    }

    public Gato(String nombre, String color, String caracteristicas, String fotografia, EstadoSalud estadoSalud, Disponibilidad disponibilidad, Zona zona, PuntoDeAvistamiento puntoAvistamiento) {
        this.historialMedico = new HistorialMedico();
        this.historialMedico.setGato(this);
        this.nombre = nombre;
        this.color = color;
        this.caracteristicas = caracteristicas;
        this.fotografia = fotografia;
        this.estadoSalud = estadoSalud;
        this.disponibilidad = disponibilidad;
        this.zona = zona;
        this.puntoAvistamiento = puntoAvistamiento;
    }
    
    public void asignarCertificado(CertificadoAptitud c) {
        this.certificado = c;
        c.setGato(this);
    }
     
    public void agregarAdopcion(Adopcion a) {
        adopciones.add(a);
        a.setGato(this);
    }
    public void quitarAdopcion(Adopcion a) {
        adopciones.remove(a);
        a.setGato(null);
    }
    
    public void agregarPostulacion(Postulacion p) {
        postulaciones.add(p);
        p.setGato(this);
    }

    public Long getIdGato() {
        return idGato;
    }

    public void setIdGato(Long idGato) {
        this.idGato = idGato;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public String getCaracteristicas() {
        return caracteristicas;
    }

    public void setCaracteristicas(String caracteristicas) {
        this.caracteristicas = caracteristicas;
    }

    public String getFotografia() {
        return fotografia;
    }

    public void setFotografia(String fotografia) {
        this.fotografia = fotografia;
    }

    public EstadoSalud getEstadoSalud() {
        return estadoSalud;
    }

    public void setEstadoSalud(EstadoSalud estadoSalud) {
        this.estadoSalud = estadoSalud;
    }

    public Disponibilidad getDisponibilidad() {
        return disponibilidad;
    }

    public void setDisponibilidad(Disponibilidad disponibilidad) {
        this.disponibilidad = disponibilidad;
    }

    public HistorialMedico getHistorialMedico() {
        return historialMedico;
    }

    public void setHistorialMedico(HistorialMedico historialMedico) {
        this.historialMedico = historialMedico;
    }

    public CertificadoAptitud getCertificado() {
        return certificado;
    }

    public void setCertificado(CertificadoAptitud certificado) {
        this.certificado = certificado;
    }

    public List<Adopcion> getAdopciones() {
        return adopciones;
    }

    public void setAdopciones(List<Adopcion> adopciones) {
        this.adopciones = adopciones;
    }

    public List<Postulacion> getPostulaciones() {
        return postulaciones;
    }

    public void setPostulaciones(List<Postulacion> postulaciones) {
        this.postulaciones = postulaciones;
    }

    public Zona getZona() {
        return zona;
    }

    public void setZona(Zona zona) {
        this.zona = zona;
    }

    public PuntoDeAvistamiento getPuntoAvistamiento() {
        return puntoAvistamiento;
    }

    public void setPuntoAvistamiento(PuntoDeAvistamiento puntoAvistamiento) {
        this.puntoAvistamiento = puntoAvistamiento;
    }

    public List<Tarea> getTareas() {
        return tareas;
    }

    public void setTareas(List<Tarea> tareas) {
        this.tareas = tareas;
    }
    
    
}
