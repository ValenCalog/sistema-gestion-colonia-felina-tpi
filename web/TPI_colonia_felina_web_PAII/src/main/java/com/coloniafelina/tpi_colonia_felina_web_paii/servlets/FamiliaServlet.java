package com.coloniafelina.tpi_colonia_felina_web_paii.servlets;

import com.prog.tpi_colonia_felina_paii.dao.FamiliaDAOImpl; 
import com.prog.tpi_colonia_felina_paii.dao.GatoDAOJPAImpl;
import com.prog.tpi_colonia_felina_paii.dao.IFamiliaDAO;
import com.prog.tpi_colonia_felina_paii.enums.EstadoUsuario;
import com.prog.tpi_colonia_felina_paii.enums.Rol;
import com.prog.tpi_colonia_felina_paii.modelo.*;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "FamiliaServlet", urlPatterns = {"/FamiliaServlet"})
public class FamiliaServlet extends HttpServlet {

    private final GatoDAOJPAImpl gatoDAO = new GatoDAOJPAImpl();
    private final IFamiliaDAO familiaDAO = new FamiliaDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. SEGURIDAD: Verificar Usuario y Rol
        HttpSession session = request.getSession(false);
        Usuario u = (session != null) ? (Usuario) session.getAttribute("usuarioLogueado") : null;

        if (u == null || !u.getRol().equals(Rol.MIEMBRO_FAMILIA) || !u.getEstado().equals(EstadoUsuario.ACTIVO)) {
            response.sendRedirect("login.jsp");
            return;
        }

        // 2. RECUPERAR DATOS DE LA FAMILIA
        // Es importante buscar la familia fresca de la BD para tener las listas actualizadas
        Familia familia = null;
        if (u.getFamilia() != null) {
            familia = familiaDAO.buscarPorId(u.getFamilia().getIdFamilia());
        }

        // 3. RECUPERAR GATOS RECOMENDADOS (Solo Disponibles y Sanos)
        // Puedes crear un método en tu DAO: buscarDisponibles(limit)
        List<Gato> recomendados = gatoDAO.buscarTodos().stream()
                .filter(g -> g.getDisponibilidad() != null && g.getDisponibilidad().toString().equals("DISPONIBLE"))
                .limit(3)
                .toList();

        // 4. ENVIAR A LA VISTA
        request.setAttribute("familia", familia);
        request.setAttribute("recomendados", recomendados);
        
        request.getRequestDispatcher("inicioFamilia.jsp").forward(request, response);
    }
}