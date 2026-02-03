package com.coloniafelina.tpi_colonia_felina_web_paii.servlets;

import com.prog.tpi_colonia_felina_paii.dao.AdopcionDAOJPAImpl;
import com.prog.tpi_colonia_felina_paii.dao.SeguimientoDAOJPAImpl;
import com.prog.tpi_colonia_felina_paii.enums.TipoContacto;
import com.prog.tpi_colonia_felina_paii.modelo.Adopcion;
import com.prog.tpi_colonia_felina_paii.modelo.Seguimiento;
import com.prog.tpi_colonia_felina_paii.modelo.Usuario;
import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "SeguimientoServlet", urlPatterns = {"/SeguimientoServlet"})
public class SeguimientoServlet extends HttpServlet {

    private final SeguimientoDAOJPAImpl seguimientoDAO = new SeguimientoDAOJPAImpl();
    private final AdopcionDAOJPAImpl adopcionDAO = new AdopcionDAOJPAImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Usuario uLogueado = (Usuario) session.getAttribute("usuarioLogueado");
        
        if (uLogueado == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String accion = request.getParameter("accion");
        if (accion == null) accion = "listarAdopciones";

        switch (accion) {
            case "listarAdopciones":
                listarAdopcionesFinalizadas(request, response);
                break;

            case "historial":
                mostrarHistorial(request, response);
                break;

            case "nuevo":
                mostrarFormularioNuevo(request, response);
                break;

            default:
                listarAdopcionesFinalizadas(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Usuario uLogueado = (Usuario) session.getAttribute("usuarioLogueado");

        if (uLogueado == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String accion = request.getParameter("accion");

        if ("guardar".equals(accion)) {
            guardarSeguimiento(request, response, uLogueado);
        }
    }


    private void listarAdopcionesFinalizadas(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        List<Adopcion> todas = adopcionDAO.buscarTodas();
        List<Adopcion> finalizadas = new ArrayList<>();
        
        if (todas != null) {
            for (Adopcion a : todas) {
                String estadoActual = String.valueOf(a.getEstado());
                
                if (estadoActual != null) {
                    String estadoUpper = estadoActual.toUpperCase();
                    if (estadoUpper.contains("ACEPTADA") || estadoUpper.contains("ACTIVA")) {
                        finalizadas.add(a); 
                    }
                }
            }
        }

        request.setAttribute("listaAdopciones", finalizadas);
        request.setAttribute("historialSeguimientos", null); 
        request.getRequestDispatcher("gestionSeguimientos.jsp").forward(request, response);
    }

    private void mostrarHistorial(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String idStr = request.getParameter("idAdopcion");
        
        if (idStr != null) {
            Long idAdopcion = Long.parseLong(idStr);
            
            Adopcion adopcion = adopcionDAO.buscarPorId(idAdopcion);
            List<Seguimiento> historial = seguimientoDAO.buscarPorAdopcion(idAdopcion);
            
            listarAdopcionesParaHistorial(request, adopcion, historial);
            
            request.getRequestDispatcher("gestionSeguimientos.jsp").forward(request, response);
        } else {
            response.sendRedirect("SeguimientoServlet");
        }
    }
    
    private void listarAdopcionesParaHistorial(HttpServletRequest request, Adopcion seleccionada, List<Seguimiento> historial) {
        List<Adopcion> todas = adopcionDAO.buscarTodas();
        List<Adopcion> finalizadas = new ArrayList<>();
        
        if (todas != null) {
            for (Adopcion a : todas) {
                String estadoActual = String.valueOf(a.getEstado());
                if (estadoActual != null) {
                    String estadoUpper = estadoActual.toUpperCase();
                    if (estadoUpper.contains("ACEPTADA") || estadoUpper.contains("ACTIVA")) {
                        finalizadas.add(a);
                    }
                }
            }
        }
        request.setAttribute("listaAdopciones", finalizadas);
        request.setAttribute("adopcionSeleccionada", seleccionada);
        request.setAttribute("historialSeguimientos", historial);
    }

    private void mostrarFormularioNuevo(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String idStr = request.getParameter("idAdopcion");
        
        if (idStr != null) {
            Long idAdopcion = Long.parseLong(idStr);
            Adopcion adopcion = adopcionDAO.buscarPorId(idAdopcion);
            
            request.setAttribute("adopcionObjetivo", adopcion);
            request.setAttribute("tiposContacto", TipoContacto.values());
            
            request.getRequestDispatcher("formSeguimiento.jsp").forward(request, response);
        } else {
            response.sendRedirect("SeguimientoServlet");
        }
    }

    private void guardarSeguimiento(HttpServletRequest request, HttpServletResponse response, Usuario voluntario) 
            throws IOException {
        
        try {
            Long idAdopcion = Long.parseLong(request.getParameter("idAdopcion"));
            String fechaStr = request.getParameter("fecha");
            String tipoStr = request.getParameter("tipoContacto");
            String observaciones = request.getParameter("observaciones");

            Adopcion adopcion = adopcionDAO.buscarPorId(idAdopcion);

            Seguimiento s = new Seguimiento();
            s.setAdopcion(adopcion);
            s.setVoluntario(voluntario);
            s.setFecha(LocalDate.parse(fechaStr));
            s.setTipoDeContacto(TipoContacto.valueOf(tipoStr));
            s.setObservaciones(observaciones);

            seguimientoDAO.crear(s);

            response.sendRedirect("SeguimientoServlet?accion=historial&idAdopcion=" + idAdopcion);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("SeguimientoServlet?error=ErrorAlGuardar");
        }
    }
}