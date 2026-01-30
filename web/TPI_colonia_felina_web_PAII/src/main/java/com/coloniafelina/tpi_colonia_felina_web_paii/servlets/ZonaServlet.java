package com.coloniafelina.tpi_colonia_felina_web_paii.servlets;

import com.prog.tpi_colonia_felina_paii.dao.IZonaDAO;
import com.prog.tpi_colonia_felina_paii.dao.ZonaDAOJPAImpl;
import com.prog.tpi_colonia_felina_paii.modelo.Zona;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "ZonaServlet", urlPatterns = {"/ZonaServlet"})
public class ZonaServlet extends HttpServlet {

    private final IZonaDAO zonaDAO = new ZonaDAOJPAImpl();

    // GET: Muestra la lista y prepara el formulario si es edición
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        //cargamos la lista para la barra lateral
        List<Zona> listaZonas = zonaDAO.buscarTodas();
        request.setAttribute("listaZonas", listaZonas);

        // comprobamos si es que nos piden editar una zona especifica(ZonaServlet?idEditar=5)
        String idEditar = request.getParameter("idEditar");
        
        if (idEditar != null && !idEditar.isEmpty()) {
            try {
                long id = Long.parseLong(idEditar);
                Zona zona = zonaDAO.buscarPorId(id);
                // mandamos la zona al JSP para que rellene los inputs
                request.setAttribute("zonaSeleccionada", zona);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        request.getRequestDispatcher("gestionZonas.jsp").forward(request, response);
    }

    // POST: Guarda o Actualiza 
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");

        try {
            String idStr = request.getParameter("idZona");
            String nombre = request.getParameter("nombre");
            String descripcion = request.getParameter("descripcion");
            String jsonCoordenadas = request.getParameter("coordenadas");

            Zona zona;
            // si hay ID, buscamos la existente (Editar)
            // si no creamos una nueva.
            if (idStr != null && !idStr.isEmpty()) {
                zona = zonaDAO.buscarPorId(Long.parseLong(idStr));
            } else {
                zona = new Zona();
            }

            zona.setNombre(nombre);
            zona.setDescripcion(descripcion);
            zona.setCoordenadas(jsonCoordenadas);
            
            if (zona.getIdZona() == null) {
                zonaDAO.guardarZona(zona);
            } else {
                zonaDAO.actualizar(zona);
            }

            
            response.sendRedirect("ZonaServlet");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("ZonaServlet?error=Error+al+guardar");
        }
    }
}