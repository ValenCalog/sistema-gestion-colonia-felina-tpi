package com.coloniafelina.tpi_colonia_felina_web_paii.servlets;

import com.prog.tpi_colonia_felina_paii.controlador.ControladorRegistroUsuarios;
import com.prog.tpi_colonia_felina_paii.dao.FamiliaDAOImpl;
import com.prog.tpi_colonia_felina_paii.dao.UsuarioDAOJPAImpl;
import com.prog.tpi_colonia_felina_paii.dao.VeterinarioDAOJPAImpl;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "RegistroVoluntarioServlet", urlPatterns = {"/RegistroVoluntarioServlet"})
public class RegistroVoluntarioServlet extends HttpServlet {

    private final ControladorRegistroUsuarios controlador = new ControladorRegistroUsuarios(
            new UsuarioDAOJPAImpl(), new VeterinarioDAOJPAImpl(), new FamiliaDAOImpl()
    );

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String dni = request.getParameter("dni");
        String telefono = request.getParameter("telefono");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {

            controlador.registrarVoluntario(nombre, apellido, dni, email, password, telefono);

            response.sendRedirect("login.jsp?registro=pendiente");

        } catch (IllegalArgumentException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("registroVoluntario.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error del sistema.");
            request.getRequestDispatcher("registroVoluntario.jsp").forward(request, response);
        }
    }
}