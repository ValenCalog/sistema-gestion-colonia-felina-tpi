/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.coloniafelina.tpi_colonia_felina_web_paii.servlets;

import com.prog.tpi_colonia_felina_paii.dao.GatoDAOJPAImpl;
import com.prog.tpi_colonia_felina_paii.dao.HistorialMedicoDAOJPAImpl;
import com.prog.tpi_colonia_felina_paii.dao.IGatoDAO;
import com.prog.tpi_colonia_felina_paii.dao.IHistorialMedicoDAO;
import com.prog.tpi_colonia_felina_paii.modelo.Gato;
import com.prog.tpi_colonia_felina_paii.modelo.HistorialMedico;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.stream.Collectors;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author mvale
 */
@WebServlet(name = "VeterinarioServlet", urlPatterns = {"/VeterinarioServlet"})
public class VeterinarioServlet extends HttpServlet {

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        IGatoDAO gatoDAO = new GatoDAOJPAImpl();
        List<Gato> listaPacientes = gatoDAO.buscarTodos(); // o buscarEnfermosYEnTratamiento()
        IHistorialMedicoDAO historialDAO = new HistorialMedicoDAOJPAImpl();
        request.setAttribute("listaPacientes", listaPacientes);
     
        String accion = request.getParameter("accion");
        if (accion == null) accion = "inicio";

            switch (accion) {
                case "inicio":
                    List<Gato> todos = gatoDAO.buscarTodos();

                    List<Gato> criticos = todos.stream()
                        .filter(g -> "ENFERMO".equals(g.getEstadoSalud().toString()))
                        .collect(Collectors.toList());

                    List<Gato> enTratamiento = todos.stream()
                        .filter(g -> "EN_TRATAMIENTO".equals(g.getEstadoSalud().toString()))
                        .collect(Collectors.toList());

                    request.setAttribute("listaCriticos", criticos);
                    request.setAttribute("listaTratamiento", enTratamiento);
                    request.setAttribute("totalPacientes", todos.size());

                    request.getRequestDispatcher("inicioVeterinario.jsp").forward(request, response);
                    break;

                case "consultorio":
                    String idGatoStr = request.getParameter("idGato");
                    if (idGatoStr != null) {
                        Gato g = gatoDAO.buscarPorId(Long.parseLong(idGatoStr));
                        request.setAttribute("gatoSeleccionado", g);

                        HistorialMedico historial = historialDAO.buscarPorIdGato(g.getIdGato());
                        request.setAttribute("historial", historial);
                    }

                    request.getRequestDispatcher("consultorioVeterinario.jsp").forward(request, response);
                    break;
                case "nuevaEvolucion":
                    try {
                        Long idGato = Long.parseLong(request.getParameter("idGato"));
                        Gato g = gatoDAO.buscarPorId(idGato);

                        request.setAttribute("gato", g);

                        request.getRequestDispatcher("formNuevaEvolucion.jsp").forward(request, response);

                    } catch (Exception e) {
                        response.sendRedirect("VeterinarioServlet?accion=inicio");
                    }
                    break;
            }
        }

}
