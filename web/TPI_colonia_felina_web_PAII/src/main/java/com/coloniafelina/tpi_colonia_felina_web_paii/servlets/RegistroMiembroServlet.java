package com.coloniafelina.tpi_colonia_felina_web_paii.servlets;

import com.prog.tpi_colonia_felina_paii.controlador.ControladorRegistroUsuarios;
import com.prog.tpi_colonia_felina_paii.dao.FamiliaDAOImpl;
import com.prog.tpi_colonia_felina_paii.dao.UsuarioDAOJPAImpl;
import com.prog.tpi_colonia_felina_paii.dao.VeterinarioDAOJPAImpl;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "RegistroMiembroServlet", urlPatterns = {"/RegistroMiembroServlet"})
public class RegistroMiembroServlet extends HttpServlet {

    private final ControladorRegistroUsuarios controlador = new ControladorRegistroUsuarios(new UsuarioDAOJPAImpl(), new VeterinarioDAOJPAImpl(), new FamiliaDAOImpl());

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            
            String nombre = request.getParameter("nombre");
            String apellido = request.getParameter("apellido");
            String dni = request.getParameter("dni");
            String telefono = request.getParameter("telefono");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            
            String idFamiliaStr = request.getParameter("idFamilia");
            long idFamilia = Long.parseLong(idFamiliaStr);

            controlador.registrarUsuarioEnFamiliaExistente(
                nombre, apellido, dni, email, password, telefono, idFamilia
            );

            response.sendRedirect("login.jsp?registro=unido");

        } catch (Exception e) {
            e.printStackTrace();
           
            response.sendRedirect("unirseFamilia.jsp?error=Error+al+registrar.+Intente+nuevamente.");
        }
    }
}