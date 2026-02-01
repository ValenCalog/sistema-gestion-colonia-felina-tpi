package com.coloniafelina.tpi_colonia_felina_web_paii.servlets;

import com.prog.tpi_colonia_felina_paii.dao.AdopcionDAOJPAImpl;
import com.prog.tpi_colonia_felina_paii.dao.GatoDAOJPAImpl;
import com.prog.tpi_colonia_felina_paii.modelo.Adopcion;
import com.prog.tpi_colonia_felina_paii.modelo.Gato;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "ReporteServlet", urlPatterns = {"/ReporteServlet"})
public class ReporteServlet extends HttpServlet {

    private final GatoDAOJPAImpl gatoDAO = new GatoDAOJPAImpl();
    private final AdopcionDAOJPAImpl adopcionDAO = new AdopcionDAOJPAImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String tipo = request.getParameter("tipo");
        
        if (tipo == null) tipo = "dashboard";

        switch (tipo) {
            case "esterilizados":
                List<Gato> listaEsterilizados = gatoDAO.buscarEsterilizados();
                request.setAttribute("datos", listaEsterilizados);
                request.setAttribute("titulo", "Reporte de Esterilizaciones");
                request.setAttribute("tipoReporte", "esterilizados");
                break;

            case "adoptados":
                List<Adopcion> listaAdopciones = adopcionDAO.buscarTodas();
                request.setAttribute("datos", listaAdopciones);
                request.setAttribute("titulo", "Reporte de Adopciones");
                request.setAttribute("tipoReporte", "adoptados");
                break;
                
            default:
                request.setAttribute("titulo", "Centro de Reportes");
                break;
        }

        request.getRequestDispatcher("gestionReportes.jsp").forward(request, response);
    }
}