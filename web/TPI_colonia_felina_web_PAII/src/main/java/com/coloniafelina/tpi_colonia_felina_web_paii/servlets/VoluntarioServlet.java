package com.coloniafelina.tpi_colonia_felina_web_paii.servlets;

import com.prog.tpi_colonia_felina_paii.dao.IPostulacionDAO;
import com.prog.tpi_colonia_felina_paii.dao.ITareaDAO;
import com.prog.tpi_colonia_felina_paii.dao.PostulacionDAOJPAImpl;
import com.prog.tpi_colonia_felina_paii.dao.TareaDAOJPAImpl;
import com.prog.tpi_colonia_felina_paii.enums.EstadoPostulacion;
import com.prog.tpi_colonia_felina_paii.modelo.Postulacion;
import com.prog.tpi_colonia_felina_paii.modelo.Tarea;
import com.prog.tpi_colonia_felina_paii.modelo.Usuario;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "VoluntarioServlet", urlPatterns = {"/VoluntarioServlet"})
public class VoluntarioServlet extends HttpServlet {

    private final IPostulacionDAO postulacionDAO = new PostulacionDAOJPAImpl();
    private final ITareaDAO tareaDAO = new TareaDAOJPAImpl(); 

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Usuario usuario = (Usuario) session.getAttribute("usuarioLogueado");

        if (usuario == null || !"VOLUNTARIO".equals(usuario.getRol().toString())) {
            response.sendRedirect("login.jsp");
            return;
        }

        //recuperamos los datos para el dashboard/inicii
        List<Postulacion> todasPostulaciones = postulacionDAO.buscarTodas();
        List<Postulacion> pendientes = todasPostulaciones.stream()
                .filter(p -> p.getEstado() == EstadoPostulacion.PENDIENTE)
                .collect(Collectors.toList());
 
        List<Tarea> tareas = new ArrayList<>(); 
        tareas = tareaDAO.obtenerUltimas5();

        request.setAttribute("postulaciones", pendientes);
        request.setAttribute("tareas", tareas);

        request.getRequestDispatcher("inicioVoluntario.jsp").forward(request, response);
    }
}