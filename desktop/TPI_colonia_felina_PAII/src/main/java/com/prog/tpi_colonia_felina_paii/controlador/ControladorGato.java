
package com.prog.tpi_colonia_felina_paii.controlador;
import com.prog.tpi_colonia_felina_paii.dao.DBService;
import com.prog.tpi_colonia_felina_paii.dao.GatoDAOJPAImpl;
import com.prog.tpi_colonia_felina_paii.dao.IGatoDAO;
import com.prog.tpi_colonia_felina_paii.enums.Disponibilidad;
import com.prog.tpi_colonia_felina_paii.enums.EstadoSalud;
import com.prog.tpi_colonia_felina_paii.modelo.Gato;
import com.prog.tpi_colonia_felina_paii.modelo.HistorialMedico;
import com.prog.tpi_colonia_felina_paii.modelo.PuntoDeAvistamiento;
import com.prog.tpi_colonia_felina_paii.modelo.Zona;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import java.util.List;
// import ui.GatosFrame;  
public class ControladorGato {

    private final IGatoDAO gatoDAO;
    // private final GatosFrame vista; // s

    public ControladorGato() {
        gatoDAO = new GatoDAOJPAImpl();
        // this.vista = vista;
    }


    /**
     * Registrar un nuevo gato.
     */
    public void registrarGato(String nombre,
                              String color,
                              String caracteristicas,
                              String fotografia,
                              EstadoSalud estadoSalud,
                              Disponibilidad disponibilidad,
                              Zona zona,
                              PuntoDeAvistamiento puntoAvistamiento) {

        try {

            if (estadoSalud == null) {
                throw new IllegalArgumentException("El estado de salud es obligatorio");
            }
            if (disponibilidad == null) {
                throw new IllegalArgumentException("La disponibilidad es obligatoria");
            }

            // Crear el gato
            Gato gato = new Gato(
                    nombre,
                    color,
                    caracteristicas,
                    fotografia,
                    estadoSalud,
                    disponibilidad,
                    zona,
                    puntoAvistamiento
            );

            gatoDAO.guardarGato(gato);

            // if (vista != null) {
            //     vista.actualizarListaGatos();
            // }

        } catch (RuntimeException e) {
            throw e;
        }
    }

    /**
     * Editar datos básicos del gato (no toca historial ni adopciones).
     */
    public void editarGato(Long idGato,
                           String nombre,
                           String color,
                           String caracteristicas,
                           String fotografia,
                           EstadoSalud estadoSalud,
                           Disponibilidad disponibilidad,
                           Zona zona,
                           PuntoDeAvistamiento puntoAvistamiento) {

        try {

            Gato gato = gatoDAO.buscarPorId(idGato);
            if (gato == null) {
                throw new IllegalArgumentException("No existe un gato con id=" + idGato);
            }

            gato.setNombre(nombre);
            gato.setColor(color);
            gato.setCaracteristicas(caracteristicas);
            gato.setFotografia(fotografia);
            gato.setEstadoSalud(estadoSalud);
            gato.setDisponibilidad(disponibilidad);
            gato.setZona(zona);
            gato.setPuntoAvistamiento(puntoAvistamiento);

            gatoDAO.actualizar(gato);

            // if (vista != null) vista.actualizarListaGatos();

        } catch (RuntimeException e) {
            throw e;
        }
    }

    
    public void eliminarGato(Long idGato) {

        try {

            Gato gato = gatoDAO.buscarPorId(idGato);
            if (gato != null) {
                gatoDAO.eliminar(gato);
            }

            // if (vista != null) vista.actualizarListaGatos();

        } catch (RuntimeException e) {
            throw e;
        }
    }

    /**
     * Obtener todos los gatos (para mostrar en tabla/lista).
     */
    public List<Gato> obtenerTodosLosGatos() {
        return gatoDAO.buscarTodos();
    }

    /**
     * Cambiar solo disponibilidad (ej: pasa a "DISPONIBLE_PARA_ADOPCION" etc.).
     */
    public void actualizarDisponibilidad(Long idGato, Disponibilidad nuevaDisponibilidad) {
        if (nuevaDisponibilidad == null) {
            throw new IllegalArgumentException("La disponibilidad no puede ser nula");
        }

        try {
            Gato gato = gatoDAO.buscarPorId(idGato);
            if (gato == null) {
                throw new IllegalArgumentException("No existe un gato con id=" + idGato);
            }
            gato.setDisponibilidad(nuevaDisponibilidad);
            gatoDAO.actualizar(gato);
        } catch (RuntimeException e) {
            throw e;
        }
    }

    /**
     * Cambiar solo estado de salud (ej: ENFERMO → EN_TRATAMIENTO → SANO).
     */
    public void actualizarEstadoSalud(Long idGato, EstadoSalud nuevoEstado) {
        if (nuevoEstado == null) {
            throw new IllegalArgumentException("El estado de salud no puede ser nulo");
        }

        try {

            Gato gato = gatoDAO.buscarPorId(idGato);
            if (gato == null) {
                throw new IllegalArgumentException("No existe un gato con id=" + idGato);
            }

            gato.setEstadoSalud(nuevoEstado);
            gatoDAO.actualizar(gato);

        } catch (RuntimeException e) {
            throw e;
        }
    }
}

