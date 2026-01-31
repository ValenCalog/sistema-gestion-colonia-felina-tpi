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
            // 1. Validar credenciales con tu controlador
            Usuario usuario = controlador.login(email, password);

            // 2. VERIFICACIÓN DE ESTADO (¿Está activo?)
            if (!(usuario.getEstado() == EstadoUsuario.ACTIVO)) {
                // Si entra aquí, la contraseña era correcta pero está dado de baja/bloqueado.
                // Lanzamos error para que lo atrape el catch de abajo
                throw new IllegalArgumentException("Tu cuenta está desactivada. Contacta al administrador.");
            }

            // 3. Crear Sesión
            HttpSession session = request.getSession();
            session.setAttribute("usuarioLogueado", usuario);

            // 4. REDIRECCIÓN SEGÚN ROL (La magia ocurre aquí) 🎩✨
            // Asumimos que tu Enum se llama 'Rol' y tiene 'VOLUNTARIO' y 'FAMILIA'
            
            // Usamos .toString() o comparamos directamente el Enum si tienes el import
            String rolUsuario = usuario.getRol().toString(); 

            if ("VOLUNTARIO".equals(rolUsuario)) {
                // -> Al Dashboard de Voluntarios
                response.sendRedirect("VoluntarioServlet"); 
                
            } else if ("MIEMBRO_FAMILIA".equals(rolUsuario)) {
                // -> Al Inicio (donde ven gatos, etc.)
                response.sendRedirect("FamiliaServlet"); 
                
            } else {
                // -> Admin u otro rol por defecto
                response.sendRedirect("AdminServlet");
            }

        } catch (IllegalArgumentException e) {
            // Errores de lógica (Usuario no encontrado, pass incorrecta, usuario inactivo)
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("login.jsp").forward(request, response);
            
        } catch (Exception e) {
            // Errores técnicos inesperados
            e.printStackTrace(); // Bueno para ver en consola qué pasó
            request.setAttribute("error", "Error del sistema: " + e.getMessage());
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}