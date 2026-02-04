package com.coloniafelina.tpi_colonia_felina_web_paii.servlets;

import com.prog.tpi_colonia_felina_paii.dao.GatoDAOJPAImpl;
import com.prog.tpi_colonia_felina_paii.dao.TareaDAOJPAImpl;
import com.prog.tpi_colonia_felina_paii.modelo.Gato;
import com.prog.tpi_colonia_felina_paii.modelo.Tarea;
import com.prog.tpi_colonia_felina_paii.modelo.Usuario;
import com.prog.tpi_colonia_felina_paii.enums.TipoDeTarea;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "TareaServlet", urlPatterns = {"/TareaServlet"})
public class TareaServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        TareaDAOJPAImpl tareaDAO = new TareaDAOJPAImpl();
        GatoDAOJPAImpl gatoDAO = new GatoDAOJPAImpl();

        String accion = request.getParameter("accion");
        if (accion == null) accion = "listar";

        switch (accion) {
            case "crear":
            case "nueva":
                
                String idGatoPre = request.getParameter("idGato");
                Gato gatoPreseleccionado = null;
                
                if (idGatoPre != null && !idGatoPre.isEmpty()) {
                    try {
                        gatoPreseleccionado = gatoDAO.buscarPorId(Long.parseLong(idGatoPre));
                    } catch (NumberFormatException e) {
                        e.printStackTrace();
                    }
                }
                
                request.setAttribute("gatoPreseleccionado", gatoPreseleccionado);
                
                cargarFormulario(request, response, gatoDAO, null);
                break;
                
            case "editar":
                try {
                    Long id = Long.parseLong(request.getParameter("id"));
                    Tarea tarea = tareaDAO.buscarPorId(id);
                    cargarFormulario(request, response, gatoDAO, tarea);
                } catch (NumberFormatException e) {
                    response.sendRedirect("TareaServlet?accion=listar");
                }
                break;
                
            case "listar":
            default:
                
                HttpSession session = request.getSession();
                Usuario u = (Usuario) session.getAttribute("usuarioLogueado");
                
                if (u != null) {
                    List<Tarea> misTareas = tareaDAO.buscarPorUsuario(u.getIdUsuario());
                    request.setAttribute("misTareas", misTareas);
                    request.getRequestDispatcher("misTareas.jsp").forward(request, response);
                } else {
                    response.sendRedirect("login.jsp");
                }
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Verificar Sesión (Usuario Voluntario)
        HttpSession session = request.getSession();
        Usuario usuarioLogueado = (Usuario) session.getAttribute("usuarioLogueado");

        // Si no hay usuario logueado, no podemos guardar la tarea (es obligatorio en BD)
        if (usuarioLogueado == null) {
            response.sendRedirect("login.jsp"); // O a tu página de error
            return;
        }

        TareaDAOJPAImpl tareaDAO = new TareaDAOJPAImpl();
        GatoDAOJPAImpl gatoDAO = new GatoDAOJPAImpl();
        
        String idStr = request.getParameter("idTarea");
        boolean esNueva = (idStr == null || idStr.isEmpty());
        
        Tarea tarea;

        // 2. Instanciar o Buscar
        if (esNueva) {
            tarea = new Tarea();
            tarea.setUsuario(usuarioLogueado); // Asignamos el usuario de la sesión
        } else {
            tarea = tareaDAO.buscarPorId(Long.parseLong(idStr));
            // Nota: En edición solemos mantener el usuario original o cambiarlo al actual
            // dependiendo de tus reglas de negocio. Aquí mantenemos el original si ya existe.
        }

        // 3. Llenar Datos
        
        // Fecha (Parsing de String a LocalDate)
        String fechaStr = request.getParameter("fecha");
        if (fechaStr != null && !fechaStr.isEmpty()) {
            tarea.setFecha(LocalDate.parse(fechaStr));
        }

        // Tipo de Tarea (Enum)
        try {
            tarea.setTipoDeTarea(TipoDeTarea.valueOf(request.getParameter("tipoDeTarea")));
        } catch (Exception e) {
            e.printStackTrace();
        }

        tarea.setUbicacion(request.getParameter("ubicacion"));
        tarea.setObservaciones(request.getParameter("observaciones"));

        // 4. Asignar Gato
        String idGatoStr = request.getParameter("idGato");
        if (idGatoStr != null && !idGatoStr.isEmpty()) {
            Gato gato = gatoDAO.buscarPorId(Long.parseLong(idGatoStr));
            tarea.setGato(gato);
        }

        // 5. Guardar en BD
        try {
            if (esNueva) {
                tareaDAO.guardarTarea(tarea);
            } else {
                // OJO: Necesitas agregar el método 'actualizar' en TareaDAOJPAImpl
                // tareaDAO.actualizar(tarea); 
                
                // Si no lo tienes aún, esto fallará en edición:
                 tareaDAO.guardarTarea(tarea); 
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("TareaServlet?accion=listar");
    }

    private void cargarFormulario(HttpServletRequest request, HttpServletResponse response, 
                                  GatoDAOJPAImpl gatoDAO, Tarea tareaEditar) 
            throws ServletException, IOException {
        
        List<Gato> listaGatos = gatoDAO.buscarTodos();
        request.setAttribute("listaGatos", listaGatos);
        
        if (tareaEditar != null) {
            request.setAttribute("tareaEditar", tareaEditar);
        }
        
        request.getRequestDispatcher("formTarea.jsp").forward(request, response);
    }
}