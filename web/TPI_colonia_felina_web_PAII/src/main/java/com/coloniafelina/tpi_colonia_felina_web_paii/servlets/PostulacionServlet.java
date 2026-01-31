package com.coloniafelina.tpi_colonia_felina_web_paii.servlets;

import com.prog.tpi_colonia_felina_paii.dao.AdopcionDAOJPAImpl;
import com.prog.tpi_colonia_felina_paii.dao.GatoDAOJPAImpl;
import com.prog.tpi_colonia_felina_paii.dao.PostulacionDAOJPAImpl;
import com.prog.tpi_colonia_felina_paii.enums.EstadoPostulacion;
import com.prog.tpi_colonia_felina_paii.enums.TipoAdopcion;
import com.prog.tpi_colonia_felina_paii.modelo.Adopcion;
import com.prog.tpi_colonia_felina_paii.modelo.Familia;
import com.prog.tpi_colonia_felina_paii.modelo.Gato;
import com.prog.tpi_colonia_felina_paii.modelo.Postulacion;
import com.prog.tpi_colonia_felina_paii.modelo.Usuario;
import java.io.IOException;
import java.net.URLEncoder;
import java.time.LocalDate;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "PostulacionServlet", urlPatterns = {"/PostulacionServlet"})
public class PostulacionServlet extends HttpServlet {

    private final GatoDAOJPAImpl gatoDAO = new GatoDAOJPAImpl();
    private final PostulacionDAOJPAImpl postulacionDAO = new PostulacionDAOJPAImpl();
    private final AdopcionDAOJPAImpl adopcionDAO = new AdopcionDAOJPAImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Usuario usuario = (Usuario) session.getAttribute("usuarioLogueado");
        
        if (usuario == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String accion = request.getParameter("accion");
        if (accion == null) accion = "listar";

        switch (accion) {
            case "formulario":
                mostrarFormulario(request, response);
                break;
                
            case "listar":
                listarPostulaciones(request, response);
                break;
                
            default:
                response.sendRedirect("index.jsp");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Usuario usuario = (Usuario) session.getAttribute("usuarioLogueado");
        if (usuario == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String accion = request.getParameter("accion");
        
        if ("guardar".equals(accion)) {
            procesarNuevaPostulacion(request, response, usuario);
        } else if ("aceptar".equals(accion) || "rechazar".equals(accion)) {
            procesarGestionPostulacion(request, response, accion);
        } else {
            response.sendRedirect("index.jsp");
        }
    }


    private void mostrarFormulario(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String idGatoStr = request.getParameter("idGato");
        
        if (idGatoStr != null && !idGatoStr.isEmpty()) {
            try {
                Long idGato = Long.parseLong(idGatoStr);
                Gato g = gatoDAO.buscarPorId(idGato); 
                
                HttpSession session = request.getSession();
                Usuario usuario = (Usuario) session.getAttribute("usuarioLogueado");

                if (usuario == null) {
                    response.sendRedirect("login.jsp");
                    return;
                }

                Familia familia = usuario.getFamilia();
                
                if (familia != null) {
                    Postulacion postExistente = postulacionDAO.buscarPorGatoYFamilia(idGato, familia.getIdFamilia());

                    if (postExistente != null) {
                        String nombreGato = postExistente.getGato().getNombre();
                        String fechaOriginal = postExistente.getFecha().toString();
                        String nombreEncoded = URLEncoder.encode(nombreGato, "UTF-8");

                        response.sendRedirect("exitoPostulacion.jsp?nombreGato=" + nombreEncoded + "&repetido=true&fecha=" + fechaOriginal);
                        return; 
                    }
                }
                
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

    private void procesarNuevaPostulacion(HttpServletRequest request, HttpServletResponse response, Usuario usuario) 
            throws IOException, ServletException {
        try {
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
            
            postulacionDAO.guardar(postulacion);
            
            String nombreGatoEncoded = URLEncoder.encode(gato.getNombre(), "UTF-8");
            String tipoEncoded = URLEncoder.encode(tipoAdopcionStr, "UTF-8");
            
            response.sendRedirect("exitoPostulacion.jsp?nombreGato=" + nombreGatoEncoded + "&tipo=" + tipoEncoded);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("GatoServlet?accion=listar&error=ErrorAlProcesar");
        }
    }

    private void listarPostulaciones(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        List<Postulacion> lista = postulacionDAO.buscarTodas();
        request.setAttribute("postulaciones", lista);
        request.getRequestDispatcher("gestionPostulaciones.jsp").forward(request, response);
    }

    private void procesarGestionPostulacion(HttpServletRequest request, HttpServletResponse response, String accion) 
            throws IOException {
        
        String idStr = request.getParameter("idPostulacion");
        
        if(idStr != null) {
            try {
                Long id = Long.parseLong(idStr);
                Postulacion post = postulacionDAO.buscarPorId(id);
                
                if(post != null) {
                    if("aceptar".equals(accion)) {
                        
                        post.aceptarPostulacion(); 
                        
                        Adopcion nuevaAdopcion = new Adopcion();
                        nuevaAdopcion.setFecha(LocalDate.now());
                        nuevaAdopcion.setTipo(post.getTipoAdopcion());
                        nuevaAdopcion.setEstado("ACTIVA");
                        nuevaAdopcion.setGato(post.getGato());
                        nuevaAdopcion.setFamiliaAdoptante(post.getFamiliaPostulante());
                        
                        adopcionDAO.guardar(nuevaAdopcion);

                        gatoDAO.actualizar(post.getGato()); 

                    } else if ("rechazar".equals(accion)) {
                        post.rechazarPostulacion(); 
                    }
                    
                    postulacionDAO.actualizar(post);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        response.sendRedirect("PostulacionServlet?accion=listar");
    }
}