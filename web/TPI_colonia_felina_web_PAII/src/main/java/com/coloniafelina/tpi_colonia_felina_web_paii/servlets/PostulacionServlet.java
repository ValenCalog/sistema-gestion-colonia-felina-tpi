/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.coloniafelina.tpi_colonia_felina_web_paii.servlets;

import com.prog.tpi_colonia_felina_paii.dao.GatoDAOJPAImpl;
import com.prog.tpi_colonia_felina_paii.enums.EstadoPostulacion;
import com.prog.tpi_colonia_felina_paii.enums.TipoAdopcion;
import com.prog.tpi_colonia_felina_paii.modelo.Familia;
import com.prog.tpi_colonia_felina_paii.modelo.Gato;
import com.prog.tpi_colonia_felina_paii.modelo.Postulacion;
import com.prog.tpi_colonia_felina_paii.modelo.Usuario;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
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
        if (accion == null) accion = "listar";

        switch (accion) {
            case "formulario":
                mostrarFormulario(request, response);
                break;
            default:
                break;
        }
    }

    private void mostrarFormulario(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Usuario usuario = (Usuario) session.getAttribute("usuarioLogueado");
        
        if (usuario == null) {
            request.setAttribute("mensaje", "Debes iniciar sesión para postularte.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        String idGatoStr = request.getParameter("idGato");
        
        if (idGatoStr != null && !idGatoStr.isEmpty()) {
            try {
                Long idGato = Long.parseLong(idGatoStr);
                Gato g = gatoDAO.buscarPorId(idGato);
                
                if (g != null) {
                    request.setAttribute("gato", g);
                    request.getRequestDispatcher("formPostulacion.jsp").forward(request, response);
                } else {
                    response.sendRedirect("GatoServlet?accion=listar&error=GatoNoEncontrado");
                }
            } catch (NumberFormatException e) {
                response.sendRedirect("GatoServlet?accion=listar");
            }
        } else {
            response.sendRedirect("GatoServlet?accion=listar");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            Usuario usuario = (Usuario) session.getAttribute("usuarioLogueado");
            
            if (usuario == null) {
                response.sendRedirect("login.jsp");
                return;
            }
            
            Long idGato = Long.parseLong(request.getParameter("idGato"));
            String tipoAdopcionStr = request.getParameter("tipoAdopcion"); 
            String observacion = request.getParameter("observacion");
            
            Gato gato = gatoDAO.buscarPorId(idGato);
            
            Familia familia = usuario.getFamilia(); 
            
            if (familia == null) {
                request.setAttribute("mensajeError", "Debes completar tu perfil familiar antes de adoptar.");
                request.getRequestDispatcher("perfilUsuario.jsp").forward(request, response);
                return;
            }

            Postulacion postulacion = new Postulacion();
            postulacion.setFecha(LocalDate.now());
            postulacion.setObservacion(observacion);
            postulacion.setTipoAdopcion(TipoAdopcion.valueOf(tipoAdopcionStr));
            postulacion.setEstado(EstadoPostulacion.PENDIENTE);
            
            postulacion.setGato(gato);
            postulacion.setMiembroPostulante(usuario);
            postulacion.setFamiliaPostulante(familia);
            postulacionDAO.crear(postulacion);
            
            response.sendRedirect("GatoServlet?accion=listar&mensaje=PostulacionEnviada");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("GatoServlet?accion=listar&error=ErrorAlProcesar");
        }
    }
    
}