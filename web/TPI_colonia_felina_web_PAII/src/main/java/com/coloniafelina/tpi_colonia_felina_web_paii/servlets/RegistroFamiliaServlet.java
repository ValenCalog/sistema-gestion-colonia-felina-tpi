package com.coloniafelina.tpi_colonia_felina_web_paii.servlets;

import com.prog.tpi_colonia_felina_paii.controlador.ControladorRegistroUsuarios;
import com.prog.tpi_colonia_felina_paii.dao.FamiliaDAOImpl;
import com.prog.tpi_colonia_felina_paii.dao.UsuarioDAOJPAImpl;
import com.prog.tpi_colonia_felina_paii.dao.VeterinarioDAOJPAImpl;
import com.prog.tpi_colonia_felina_paii.enums.DisponibilidadFamilia;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet(name = "RegistroFamiliaServlet", urlPatterns = {"/RegistroFamiliaServlet"})
public class RegistroFamiliaServlet extends HttpServlet {

    private final ControladorRegistroUsuarios controlador = new ControladorRegistroUsuarios(new UsuarioDAOJPAImpl(), new VeterinarioDAOJPAImpl(), new FamiliaDAOImpl());
   
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String dni = request.getParameter("dni");
        String telefono = request.getParameter("telefono");
        String email = request.getParameter("correo");
        String password = request.getParameter("contrasenia");
        String direccion = request.getParameter("direccion");
        String obs = request.getParameter("observaciones");
        String disponibilidadStr = request.getParameter("disponibilidad");
        
        try {
            DisponibilidadFamilia disponibilidadEnum = DisponibilidadFamilia.valueOf(disponibilidadStr); // como viene en string lo convertimos a enum
            controlador.registrarFamiliaNuevaConMiembro(
                    nombre, 
                    apellido, 
                    dni, 
                    email, 
                    password, 
                    telefono, 
                    disponibilidadEnum, 
                    obs, 
                    direccion
            );
            
            response.sendRedirect("login.jsp?registro=exito");
        } catch (IllegalArgumentException e) {
            // Error de datos (ej. email repetido, enum inválido)
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("registroFamilia.jsp").forward(request, response);
            
        } catch (Exception e) {
            // Error general
            e.printStackTrace(); // para ver en la consola qué pasó
            request.setAttribute("error", "Ocurrió un error al registrar: " + e.getMessage());
            request.getRequestDispatcher("registroFamilia.jsp").forward(request, response);
        }
    }


}
