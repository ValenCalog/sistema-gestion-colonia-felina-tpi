package com.coloniafelina.tpi_colonia_felina_web_paii.servlets;

import com.prog.tpi_colonia_felina_paii.controlador.ControladorLogin;
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

            HttpSession session = request.getSession();
            session.setAttribute("usuarioLogueado", usuario);

            response.sendRedirect("index.jsp");

        } catch (IllegalArgumentException e) {

            request.setAttribute("error", e.getMessage());
            
            // en caso de error redirigimos a login.jsp (con forward para no perder el mensaje de error)
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } catch (Exception e) {
            
            request.setAttribute("error", "Error del sistema: " + e.getMessage());
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

}
