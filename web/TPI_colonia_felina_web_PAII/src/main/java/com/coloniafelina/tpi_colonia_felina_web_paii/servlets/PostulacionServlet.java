/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.coloniafelina.tpi_colonia_felina_web_paii.servlets;

import com.prog.tpi_colonia_felina_paii.dao.GatoDAOJPAImpl;
import com.prog.tpi_colonia_felina_paii.modelo.Gato;
import com.prog.tpi_colonia_felina_paii.modelo.Usuario;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "PostulacionServlet", urlPatterns = {"/PostulacionServlet"})
public class PostulacionServlet extends HttpServlet {

    private GatoDAOJPAImpl gatoDAO = new GatoDAOJPAImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String accion = request.getParameter("accion");
        if (accion == null) accion = "listar"; // O lo que prefieras por defecto

        switch (accion) {
            case "formulario":
                mostrarFormulario(request, response);
                break;
            // ... otros casos ...
        }
    }

    private void mostrarFormulario(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Validar Sesión (Solo usuarios logueados pueden adoptar)
        HttpSession session = request.getSession();
        Usuario usuario = (Usuario) session.getAttribute("usuarioLogueado");
        
        if (usuario == null) {
            // Si no está logueado, lo mandamos al login
            // Guardamos la URL intentada para volver después (Opcional pero pro)
            request.setAttribute("mensaje", "Debes iniciar sesión para postularte.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        // 2. Obtener ID del Gato
        String idGatoStr = request.getParameter("idGato");
        
        if (idGatoStr != null && !idGatoStr.isEmpty()) {
            try {
                Long idGato = Long.parseLong(idGatoStr);
                Gato g = gatoDAO.buscarPorId(idGato);
                
                if (g != null) {
                    // 3. Enviar objeto Gato al JSP
                    request.setAttribute("gato", g);
                    request.getRequestDispatcher("formPostulacion.jsp").forward(request, response);
                } else {
                    // Gato no encontrado
                    response.sendRedirect("GatoServlet?accion=listar&error=GatoNoEncontrado");
                }
            } catch (NumberFormatException e) {
                response.sendRedirect("GatoServlet?accion=listar");
            }
        } else {
            response.sendRedirect("GatoServlet?accion=listar");
        }
    }
    
}