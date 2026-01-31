package com.coloniafelina.tpi_colonia_felina_web_paii.servlets;

import com.prog.tpi_colonia_felina_paii.dao.PostulacionDAOJPAImpl; // Asumo que crearás este DAO
import com.prog.tpi_colonia_felina_paii.modelo.Postulacion;
import com.prog.tpi_colonia_felina_paii.modelo.Usuario;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "PostulacionServlet", urlPatterns = {"/PostulacionServlet"})
public class PostulacionServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Seguridad: Verificar que sea voluntario (opcional, según tu lógica)
        HttpSession session = request.getSession();
        Usuario u = (Usuario) session.getAttribute("usuarioLogueado");
        if(u == null) { response.sendRedirect("login.jsp"); return; }

        PostulacionDAOJPAImpl postulacionDAO = new PostulacionDAOJPAImpl();
        
        // Buscar todas las postulaciones (idealmente ordenadas por fecha descendente)
        List<Postulacion> lista = postulacionDAO.buscarTodas();
        
        request.setAttribute("postulaciones", lista);
        request.getRequestDispatcher("gestionPostulaciones.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");
        String idStr = request.getParameter("idPostulacion");
        
        if(idStr != null && accion != null) {
            PostulacionDAOJPAImpl postulacionDAO = new PostulacionDAOJPAImpl();
            // Asumiendo que también tienes GatoDAO para actualizar el estado del gato
            // o que tienes CascadeType configurado.
            
            try {
                Long id = Long.parseLong(idStr);
                Postulacion post = postulacionDAO.buscarPorId(id);
                
                if(post != null) {
                    if("aceptar".equals(accion)) {
                        post.aceptarPostulacion(); // Tu método de la entidad (cambia estado y gato)
                    } else if ("rechazar".equals(accion)) {
                        post.rechazarPostulacion(); // Tu método de la entidad
                    }
                    
                    // Guardamos los cambios en la BD
                    postulacionDAO.actualizar(post);
                    
                    // IMPORTANTE: Si aceptarPostulacion cambia el gato, asegúrate
                    // de que el DAO actualice también al gato (em.merge(post) con cascade o actualizar gato aparte).
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        
        // Volvemos a la lista
        response.sendRedirect("PostulacionServlet");
    }
}