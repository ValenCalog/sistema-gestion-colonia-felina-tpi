package com.coloniafelina.tpi_colonia_felina_web_paii.servlets;

import com.prog.tpi_colonia_felina_paii.controlador.ControladorLogin;
import com.prog.tpi_colonia_felina_paii.enums.EstadoUsuario;
import com.prog.tpi_colonia_felina_paii.modelo.Usuario;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

    private final ControladorLogin controlador = new ControladorLogin();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            Usuario usuario = controlador.login(email, password);

            if (!(usuario.getEstado() == EstadoUsuario.ACTIVO)) {
                
                throw new IllegalArgumentException("Tu cuenta está desactivada. Contacta al administrador.");
            }

            HttpSession session = request.getSession();
            session.setAttribute("usuarioLogueado", usuario);

            String rolUsuario = usuario.getRol().toString(); 

            if ("VOLUNTARIO".equals(rolUsuario)) {
                response.sendRedirect("VoluntarioServlet"); 
                
            } else if ("MIEMBRO_FAMILIA".equals(rolUsuario)) {
                response.sendRedirect("FamiliaServlet"); 
            }else if ("VETERINARIO".equals(rolUsuario)){
                response.sendRedirect("VeterinarioServlet?accion=inicio");
            } else {
                response.sendRedirect("AdminServlet");
            }

        } catch (IllegalArgumentException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("login.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace(); 
            request.setAttribute("error", "Error del sistema: " + e.getMessage());
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}