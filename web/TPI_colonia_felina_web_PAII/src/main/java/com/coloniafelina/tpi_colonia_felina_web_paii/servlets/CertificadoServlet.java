package com.coloniafelina.tpi_colonia_felina_web_paii.servlets;

import com.prog.tpi_colonia_felina_paii.dao.CertificadoDAOJPAImpl;
import com.prog.tpi_colonia_felina_paii.dao.GatoDAOJPAImpl;
import com.prog.tpi_colonia_felina_paii.enums.EstadoUsuario;
import com.prog.tpi_colonia_felina_paii.modelo.CertificadoAptitud;
import com.prog.tpi_colonia_felina_paii.modelo.Gato;
import com.prog.tpi_colonia_felina_paii.modelo.Usuario;
import com.prog.tpi_colonia_felina_paii.modelo.Veterinario;
import java.io.IOException;
import java.time.LocalDate;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "CertificadoServlet", urlPatterns = {"/CertificadoServlet"})
public class CertificadoServlet extends HttpServlet {

    private final GatoDAOJPAImpl gatoDAO = new GatoDAOJPAImpl();
    private final CertificadoDAOJPAImpl certificadoDAO = new CertificadoDAOJPAImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Usuario usuario = (Usuario) session.getAttribute("usuarioLogueado");

        if (usuario == null || !(usuario instanceof Veterinario) || !(usuario.getEstado() == EstadoUsuario.ACTIVO)) {
            response.sendRedirect("login.jsp");
            return;
        }
        Veterinario veterinario = (Veterinario) usuario;

        String accion = request.getParameter("accion");

        if ("guardar".equals(accion)) { 
            try {
                Long idGato = Long.parseLong(request.getParameter("idGato"));
                String obs = request.getParameter("observaciones"); 
                if (obs == null) obs = "";

                Gato gato = gatoDAO.buscarPorId(idGato);

                if (!"SANO".equals(gato.getEstadoSalud().toString())) {
                    throw new Exception("El paciente no cumple con la condición de SANO.");
                }

                CertificadoAptitud existente = certificadoDAO.buscarPorIdGato(idGato);
                if (existente != null) {
                    response.sendRedirect("VeterinarioServlet?accion=consultorio&idGato=" + idGato);
                    return;
                }

                CertificadoAptitud certificado = new CertificadoAptitud();
                certificado.setFechaEmision(LocalDate.now());
                certificado.setEstado("VIGENTE");
                certificado.setObservaciones(obs);
                
                certificado.setGato(gato);
                certificado.setVeterinario(veterinario);

                certificadoDAO.crear(certificado);

                response.sendRedirect("VeterinarioServlet?accion=consultorio&idGato=" + idGato);

            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("VeterinarioServlet?accion=inicio");
            }
        } else {
            response.sendRedirect("VeterinarioServlet?accion=inicio");
        }
    }
}