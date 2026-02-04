package com.coloniafelina.tpi_colonia_felina_web_paii.servlets;

import com.prog.tpi_colonia_felina_paii.dao.FamiliaDAOImpl; 
import com.prog.tpi_colonia_felina_paii.dao.GatoDAOJPAImpl;
import com.prog.tpi_colonia_felina_paii.dao.IFamiliaDAO;
import com.prog.tpi_colonia_felina_paii.dao.IPostulacionDAO;
import com.prog.tpi_colonia_felina_paii.dao.PostulacionDAOJPAImpl;
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
    private final IPostulacionDAO postulacionDAO = new PostulacionDAOJPAImpl();
            
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        Usuario u = (session != null) ? (Usuario) session.getAttribute("usuarioLogueado") : null;

        if (u == null || !u.getRol().equals(Rol.MIEMBRO_FAMILIA) || !u.getEstado().equals(EstadoUsuario.ACTIVO)) {
            response.sendRedirect("login.jsp");
            return;
        }

        Familia familia = null;
        if (u.getFamilia() != null) {
            familia = familiaDAO.buscarPorId(u.getFamilia().getIdFamilia());
        }
        
        List<Postulacion> postulacionesVisibles = postulacionDAO.buscarActivasPorFamilia(familia.getIdFamilia());
        
        Long cantidadPendientes = postulacionDAO.contarPendientesPorFamilia(familia.getIdFamilia());

        List<Gato> recomendados = gatoDAO.buscarDisponibles().stream()
                .limit(3)
                .toList();

        request.setAttribute("familia", familia);
        request.setAttribute("postulacionesVisibles", postulacionesVisibles);
        request.setAttribute("cantidadPendientes", cantidadPendientes);
        request.setAttribute("recomendados", recomendados);
        
        request.getRequestDispatcher("inicioFamilia.jsp").forward(request, response);
    }
}