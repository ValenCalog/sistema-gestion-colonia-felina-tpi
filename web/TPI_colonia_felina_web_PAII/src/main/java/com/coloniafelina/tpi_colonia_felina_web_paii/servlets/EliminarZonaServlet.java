package com.coloniafelina.tpi_colonia_felina_web_paii.servlets;

import com.prog.tpi_colonia_felina_paii.dao.IZonaDAO;
import com.prog.tpi_colonia_felina_paii.dao.ZonaDAOJPAImpl;
import com.prog.tpi_colonia_felina_paii.modelo.Zona;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "EliminarZonaServlet", urlPatterns = {"/EliminarZonaServlet"})
public class EliminarZonaServlet extends HttpServlet {

    private final IZonaDAO zonaDAO = new ZonaDAOJPAImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            String idStr = request.getParameter("idZona");
            
            if (idStr != null && !idStr.isEmpty()) {
                long id = Long.parseLong(idStr);

                // Validación: No borrar si tiene gatos
                Zona zona = zonaDAO.buscarPorId(id);
                if (zona != null && !zona.getGatos().isEmpty()) {
                    response.sendRedirect("ZonaServlet?error=No+se+puede+borrar+zona+con+gatos");
                    return;
                }

                zonaDAO.eliminar(id);
                response.sendRedirect("ZonaServlet?mensaje=Zona+eliminada");
            } else {
                response.sendRedirect("ZonaServlet?error=ID+invalido");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("ZonaServlet?error=Error+en+servidor");
        }
    }
}