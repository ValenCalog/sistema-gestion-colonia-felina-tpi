package com.coloniafelina.tpi_colonia_felina_web_paii.servlets;

import com.prog.tpi_colonia_felina_paii.dao.GatoDAOJPAImpl;
import com.prog.tpi_colonia_felina_paii.dao.ZonaDAOJPAImpl; 
import com.prog.tpi_colonia_felina_paii.modelo.Gato;
import com.prog.tpi_colonia_felina_paii.modelo.Zona;
import com.prog.tpi_colonia_felina_paii.enums.Disponibilidad; // <--- Importamos Disponibilidad
import com.prog.tpi_colonia_felina_paii.enums.EstadoSalud;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "GatoServlet", urlPatterns = {"/GatoServlet"})
@MultipartConfig
public class GatoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        GatoDAOJPAImpl gatoDAO = new GatoDAOJPAImpl();
        ZonaDAOJPAImpl zonaDAO = new ZonaDAOJPAImpl();

        String accion = request.getParameter("accion");
        if (accion == null) accion = "listar";

        switch (accion) {
            case "crear":
                cargarFormulario(request, response, zonaDAO, null);
                break;
                
            case "editar":
                try {
                    Long id = Long.parseLong(request.getParameter("id"));
                    Gato gato = gatoDAO.buscarPorId(id); 
                    cargarFormulario(request, response, zonaDAO, gato);
                } catch (NumberFormatException e) {
                    response.sendRedirect("GatoServlet?accion=listar");
                }
                break;
                
            case "listar":
            default:
                List<Gato> listaGatos = gatoDAO.buscarTodos();
                request.setAttribute("gatos", listaGatos);
                // Si aún no tienes 'listarGatos.jsp', te manda al formulario
                cargarFormulario(request, response, zonaDAO, null); 
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        GatoDAOJPAImpl gatoDAO = new GatoDAOJPAImpl();
        ZonaDAOJPAImpl zonaDAO = new ZonaDAOJPAImpl();
        
        String idStr = request.getParameter("idGato");
        
        Gato gato;
        boolean esNuevo = (idStr == null || idStr.isEmpty());

        if (esNuevo) {
            gato = new Gato(); 
        } else {
            gato = gatoDAO.buscarPorId(Long.parseLong(idStr)); 
        }

        // Llenar datos (Nombre y Características son opcionales en el JSP, manejamos nulos)
        gato.setNombre(request.getParameter("nombre"));
        gato.setColor(request.getParameter("color"));
        gato.setCaracteristicas(request.getParameter("caracteristicas"));
        
        // Enums: Disponibilidad y Salud
        try {
            gato.setDisponibilidad(Disponibilidad.valueOf(request.getParameter("disponibilidad")));
            gato.setEstadoSalud(EstadoSalud.valueOf(request.getParameter("estadoSalud")));
        } catch (IllegalArgumentException | NullPointerException e) {
            e.printStackTrace(); 
        }

        // Asignar Zona (Opcional, puede venir vacía)
        String idZonaStr = request.getParameter("idZona");
        if (idZonaStr != null && !idZonaStr.isEmpty()) {
            Zona zona = zonaDAO.buscarPorId(Long.parseLong(idZonaStr));
            gato.setZona(zona);
        } else {
            gato.setZona(null); // Si eligen "Sin zona", limpiamos la relación
        }

        // Guardar
        try {
            if (esNuevo) {
                gatoDAO.guardarGato(gato);
            } else {
                gatoDAO.actualizar(gato);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("GatoServlet?accion=listar");
    }

    private void cargarFormulario(HttpServletRequest request, HttpServletResponse response, 
                                  ZonaDAOJPAImpl zonaDAO, Gato gatoEditar) 
            throws ServletException, IOException {
        
        List<Zona> zonas = zonaDAO.buscarTodas(); 
        request.setAttribute("listaZonas", zonas);
        
        if (gatoEditar != null) {
            request.setAttribute("gatoEditar", gatoEditar);
        }
        
        request.getRequestDispatcher("formGato.jsp").forward(request, response);
    }
}