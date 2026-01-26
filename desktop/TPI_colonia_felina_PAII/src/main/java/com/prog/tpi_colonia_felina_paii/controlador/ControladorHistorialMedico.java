
package com.prog.tpi_colonia_felina_paii.controlador;

import com.prog.tpi_colonia_felina_paii.dao.DiagnosticoDAOJPAImpl;
import com.prog.tpi_colonia_felina_paii.dao.EstudioDAOJPAImpl;
import com.prog.tpi_colonia_felina_paii.dao.GatoDAOJPAImpl;
import com.prog.tpi_colonia_felina_paii.dao.IDiagnosticoDAO;
import com.prog.tpi_colonia_felina_paii.dao.IEstudioDAO;
import com.prog.tpi_colonia_felina_paii.dao.IGatoDAO;
import com.prog.tpi_colonia_felina_paii.dao.ITratamientoDAO;
import com.prog.tpi_colonia_felina_paii.dao.IVeterinarioDAO;
import com.prog.tpi_colonia_felina_paii.dao.TratamientoDAOJPAImpl;
import com.prog.tpi_colonia_felina_paii.dao.VeterinarioDAOJPAImpl;
import com.prog.tpi_colonia_felina_paii.modelo.Diagnostico;
import com.prog.tpi_colonia_felina_paii.modelo.Estudio;
import com.prog.tpi_colonia_felina_paii.modelo.Gato;
import com.prog.tpi_colonia_felina_paii.modelo.HistorialMedico;
import com.prog.tpi_colonia_felina_paii.modelo.Tratamiento;
import com.prog.tpi_colonia_felina_paii.modelo.Veterinario;
import java.time.LocalDate;
import java.util.List;


public class ControladorHistorialMedico {
    private final IGatoDAO gatoDAO = new GatoDAOJPAImpl();
    private final IDiagnosticoDAO diagnosticoDAO = new DiagnosticoDAOJPAImpl();
    private final IEstudioDAO estudioDAO = new EstudioDAOJPAImpl();
    private final ITratamientoDAO tratamientoDAO = new TratamientoDAOJPAImpl();
    private final IVeterinarioDAO veterinarioDAO = new VeterinarioDAOJPAImpl();
    
     /** Devuelve el historial médico completo del gato. */
    public HistorialMedico obtenerHistorialDeGato(Long idGato) {
        Gato gato = gatoDAO.buscarPorId(idGato);
        if (gato == null) {
            throw new IllegalArgumentException("No existe gato con id " + idGato);
        }
        return gato.getHistorialMedico();
    }

    /** Lista de diagnósticos para mostrar en una tabla. */
    public List<Diagnostico> obtenerDiagnosticosDeGato(Long idGato) {
        HistorialMedico historial = obtenerHistorialDeGato(idGato);
        // si querés forzar inicialización (por LAZY)
        historial.getDiagnosticos().size();
        return historial.getDiagnosticos();
    }

    /** Lista de estudios para mostrar en una tabla. */
    public List<Estudio> obtenerEstudiosDeGato(Long idGato) {
        HistorialMedico historial = obtenerHistorialDeGato(idGato);
        historial.getEstudios().size();
        return historial.getEstudios();
    }

    // ================== ALTAS ==================

    /** Registrar un nuevo diagnóstico para un gato. */
    public void registrarDiagnostico(Long idGato,
                                     LocalDate fecha,
                                     String descDetallada,
                                     String estadoClinico,
                                     String observaciones,
                                     Long idVeterinario) {

            Gato gato = gatoDAO.buscarPorId(idGato);
            if (gato == null) {
                throw new IllegalArgumentException("No existe gato con id " + idGato);
            }

            HistorialMedico historial = gato.getHistorialMedico();
            if (historial == null) {
                // Por seguridad, aunque en tu constructor de Gato lo creás siempre
                historial = new HistorialMedico();
                historial.setGato(gato);
                gato.setHistorialMedico(historial);
            }

            Veterinario vet = veterinarioDAO.buscarPorId(idVeterinario);
            if (vet == null) {
                throw new IllegalArgumentException("No existe veterinario con id " + idVeterinario);
            }

            Diagnostico diagnostico = new Diagnostico(
                    fecha,
                    descDetallada,
                    observaciones,
                    estadoClinico,
                    historial,
                    vet
            );

            diagnosticoDAO.guardarDiagnostico(diagnostico);
        
    }

    /** Registrar un estudio para un gato. */
    public void registrarEstudio(Long idGato,
                                 LocalDate fecha,
                                 String tipoDeEstudio,
                                 String observaciones,
                                 String rutaArchivo,
                                 Long idVeterinario) {

            Gato gato = gatoDAO.buscarPorId(idGato);
            if (gato == null) {
                throw new IllegalArgumentException("No existe gato con id " + idGato);
            }

            HistorialMedico historial = gato.getHistorialMedico();
            if (historial == null) {
                historial = new HistorialMedico();
                historial.setGato(gato);
                gato.setHistorialMedico(historial);
            }

            Veterinario vet = veterinarioDAO.buscarPorId(idVeterinario);
            if (vet == null) {
                throw new IllegalArgumentException("No existe veterinario con id " + idVeterinario);
            }

            Estudio estudio = new Estudio(
                    fecha,
                    tipoDeEstudio,
                    observaciones,
                    rutaArchivo,
                    vet
            );
            estudio.setHistorial(historial);

            estudioDAO.guardarEstudio(estudio);
           
    }

    /** Registrar tratamiento ligado a un diagnóstico concreto. */
    public void registrarTratamiento(Long idDiagnostico,
                                     LocalDate fecha,
                                     String descripcion,
                                     String medicacion,
                                     String observaciones,
                                     Long idVeterinario) {

       
            Diagnostico diagnostico = diagnosticoDAO.buscarPorId(idDiagnostico);
            if (diagnostico == null) {
                throw new IllegalArgumentException("No existe diagnóstico con id " + idDiagnostico);
            }

            Veterinario vet = veterinarioDAO.buscarPorId(idVeterinario);
            if (vet == null) {
                throw new IllegalArgumentException("No existe veterinario con id " + idVeterinario);
            }

            Tratamiento tratamiento = new Tratamiento(
                    fecha,
                    descripcion,
                    medicacion,
                    observaciones,
                    vet
            );
            tratamiento.setDiagnostico(diagnostico);

            tratamientoDAO.guardarTratamiento(tratamiento);
    }
}
