
package com.coloniafelina.tpi_colonia_felina_web_paii.servlets;

import com.prog.tpi_colonia_felina_paii.dao.DiagnosticoDAOJPAImpl;
import com.prog.tpi_colonia_felina_paii.dao.GatoDAOJPAImpl;
import com.prog.tpi_colonia_felina_paii.dao.HistorialMedicoDAOJPAImpl;
import com.prog.tpi_colonia_felina_paii.dao.IDiagnosticoDAO;
import com.prog.tpi_colonia_felina_paii.dao.IGatoDAO;
import com.prog.tpi_colonia_felina_paii.dao.IHistorialMedicoDAO;
import com.prog.tpi_colonia_felina_paii.enums.EstadoSalud;
import com.prog.tpi_colonia_felina_paii.modelo.Diagnostico;
import com.prog.tpi_colonia_felina_paii.modelo.Gato;
import com.prog.tpi_colonia_felina_paii.modelo.HistorialMedico;
import com.prog.tpi_colonia_felina_paii.modelo.Tratamiento;
import com.prog.tpi_colonia_felina_paii.modelo.Usuario;
import com.prog.tpi_colonia_felina_paii.modelo.Veterinario;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "HistoriaClinicaServlet", urlPatterns = {"/HistoriaClinicaServlet"})
public class HistoriaClinicaServlet extends HttpServlet {

    private final IGatoDAO gatoDAO = new GatoDAOJPAImpl();
    private final IDiagnosticoDAO diagnosticoDAO = new DiagnosticoDAOJPAImpl();
    private final IHistorialMedicoDAO historialDAO = new HistorialMedicoDAOJPAImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");
        HttpSession session = request.getSession();
        Usuario usuarioLogueado = (Usuario) session.getAttribute("usuarioLogueado");

        // validar que sea veterinario
        if (usuarioLogueado == null || !(usuarioLogueado instanceof Veterinario)) {
            response.sendRedirect("login.jsp");
            return;
        }
        Veterinario veterinario = (Veterinario) usuarioLogueado;

        if ("guardarEvolucionCompleta".equals(accion)) {
            try {

                Long idGato = Long.parseLong(request.getParameter("idGato"));
                Gato gato = gatoDAO.buscarPorId(idGato);
                
                HistorialMedico historial = historialDAO.buscarPorIdGato(idGato);
                
                if(historial == null){
                    historial = new HistorialMedico();
                    historial.setGato(gato);
                    historialDAO.crear(historial);
                }

                Diagnostico diag = new Diagnostico();
                diag.setFecha(LocalDate.parse(request.getParameter("fechaDiagnostico")));
                diag.setDescDetallada(request.getParameter("descDetallada"));
                diag.setObservaciones(request.getParameter("observacionesDiagnostico"));
                diag.setEstadoClinico(request.getParameter("estadoClinico"));
                
                diag.setHistorial(historial);
                diag.setVeterinario(veterinario);

                String[] descripciones = request.getParameterValues("tratamientoDescripcion[]");
                String[] medicaciones = request.getParameterValues("tratamientoMedicacion[]");
                String[] observacionesTrat = request.getParameterValues("tratamientoObservaciones[]");

                List<Tratamiento> listaTratamientos = new ArrayList<>();

                if (descripciones != null) {
                    for (int i = 0; i < descripciones.length; i++) {
                      
                        if (descripciones[i] != null && !descripciones[i].trim().isEmpty()) {
                            
                            Tratamiento t = new Tratamiento();
                            t.setFechaTratamiento(diag.getFecha()); // Usamos misma fecha del diagnóstico
                            t.setDescripcion(descripciones[i]);
                            t.setMedicacion(medicaciones[i]);
                            t.setObservaciones(observacionesTrat[i]);
                            
                         
                            t.setVeterinario(veterinario);
                            t.setDiagnostico(diag); // Bidireccional: Hijo apunta a Padre
                            
                            listaTratamientos.add(t);
                        }
                    }
                }

                diag.setTratamientos(listaTratamientos);

                diagnosticoDAO.guardarDiagnostico(diag);

                try {
                    EstadoSalud nuevoEstado = EstadoSalud.valueOf(diag.getEstadoClinico());
                    gato.setEstadoSalud(nuevoEstado);
                    gatoDAO.actualizar(gato);
                } catch (Exception e) {
                    System.out.println("Error actualizando enum estado salud: " + e.getMessage());
                }

                response.sendRedirect("VeterinarioServlet?accion=consultorio&idGato=" + idGato);

            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("error.jsp");
            }
        }
    }
}