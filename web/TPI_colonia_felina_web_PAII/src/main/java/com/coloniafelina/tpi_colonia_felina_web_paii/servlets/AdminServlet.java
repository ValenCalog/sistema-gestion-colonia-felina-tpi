package com.coloniafelina.tpi_colonia_felina_web_paii.servlets;

import com.prog.tpi_colonia_felina_paii.util.PasswordHasher;
import com.prog.tpi_colonia_felina_paii.dao.UsuarioDAOJPAImpl;
import com.prog.tpi_colonia_felina_paii.modelo.Usuario;
import com.prog.tpi_colonia_felina_paii.enums.Rol;
import com.prog.tpi_colonia_felina_paii.enums.EstadoUsuario;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "AdminServlet", urlPatterns = {"/AdminServlet"})
public class AdminServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        UsuarioDAOJPAImpl usuarioDAO = new UsuarioDAOJPAImpl();

        String accion = request.getParameter("accion");
        if (accion == null) accion = "listar";

        switch (accion) {
            case "editar":
                mostrarFormularioEditar(request, response, usuarioDAO);
                break;
            case "crear":
                mostrarFormularioCrear(request, response);
                break;

            case "evaluar":
                listarPendientes(request, response, usuarioDAO);
                break;

            case "listar":
            default:
                listarUsuarios(request, response, usuarioDAO);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        UsuarioDAOJPAImpl usuarioDAO = new UsuarioDAOJPAImpl();
        
        String accion = request.getParameter("accion");
        
        if ("activar".equals(accion) || "bloquear".equals(accion)) {
            procesarEvaluacion(request, response, usuarioDAO, accion);
            return;
        }

        String idStr = request.getParameter("idUsuario");

        if(idStr != null && !idStr.isEmpty()) {
            actualizarUsuario(request, response, usuarioDAO);
        } else {
            crearUsuario(request, response, usuarioDAO);
        }
    }

    private void listarPendientes(HttpServletRequest request, HttpServletResponse response, UsuarioDAOJPAImpl dao) 
            throws ServletException, IOException {
        
        List<Usuario> pendientes = dao.buscarPorEstado(EstadoUsuario.PENDIENTE);
        request.setAttribute("usuariosPendientes", pendientes);
        request.getRequestDispatcher("evaluarUsuarios.jsp").forward(request, response);
    }

    private void procesarEvaluacion(HttpServletRequest request, HttpServletResponse response, UsuarioDAOJPAImpl dao, String accion) 
            throws IOException {
        
        try {
            Long id = Long.parseLong(request.getParameter("idUsuario"));
            Usuario u = dao.buscarPorId(id);
            
            if (u != null) {
                if ("activar".equals(accion)) {
                    u.setEstado(EstadoUsuario.ACTIVO);
                } else if ("bloquear".equals(accion)) {
                    u.setEstado(EstadoUsuario.BLOQUEADO);
                }
                dao.editar(u); // Guardar cambios
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        response.sendRedirect("AdminServlet?accion=evaluar");
    }

    private void listarUsuarios(HttpServletRequest request, HttpServletResponse response, UsuarioDAOJPAImpl dao) 
        throws ServletException, IOException {
    
        String busqueda = request.getParameter("busqueda");
        String rolStr = request.getParameter("filtroRol");

        com.prog.tpi_colonia_felina_paii.enums.Rol rolFiltro = null;
        if (rolStr != null && !rolStr.isEmpty()) {
            rolFiltro = com.prog.tpi_colonia_felina_paii.enums.Rol.valueOf(rolStr);
        }

        List<Usuario> lista = dao.buscarConFiltros(busqueda, rolFiltro);

        request.setAttribute("usuarios", lista);
        request.setAttribute("busquedaActual", busqueda);
        request.setAttribute("rolActual", rolStr);
        request.setAttribute("listaRoles", com.prog.tpi_colonia_felina_paii.enums.Rol.values());

        request.getRequestDispatcher("gestionUsuarios.jsp").forward(request, response);
    }

    private void mostrarFormularioEditar(HttpServletRequest request, HttpServletResponse response, UsuarioDAOJPAImpl dao) 
            throws ServletException, IOException {
        
        try {
            Long id = Long.parseLong(request.getParameter("id"));
            Usuario u = dao.buscarPorId(id);
            
            request.setAttribute("usuarioEditar", u);
            request.setAttribute("listaRoles", Rol.values());
            request.setAttribute("listaEstados", EstadoUsuario.values());
            
            request.getRequestDispatcher("formUsuario.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect("AdminServlet"); 
        }
    }

    private void mostrarFormularioCrear(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setAttribute("listaRoles", Rol.values());
        request.setAttribute("listaEstados", EstadoUsuario.values());
        request.getRequestDispatcher("formUsuario.jsp").forward(request, response);
    }

    private void actualizarUsuario(HttpServletRequest request, HttpServletResponse response, UsuarioDAOJPAImpl dao) 
        throws IOException {

        Long id = Long.parseLong(request.getParameter("idUsuario"));
        Usuario u = dao.buscarPorId(id);

        u.setNombre(request.getParameter("nombre"));
        u.setApellido(request.getParameter("apellido"));
        u.setCorreo(request.getParameter("correo"));
        u.setTelefono(request.getParameter("telefono"));

        String nuevaPass = request.getParameter("contrasenia");
        if (nuevaPass != null && !nuevaPass.isBlank()) {
            String passHash = PasswordHasher.hash(nuevaPass);
            u.setContrasenia(passHash);
        }

        u.setRol(Rol.valueOf(request.getParameter("rol")));
        u.setEstado(EstadoUsuario.valueOf(request.getParameter("estado")));

        dao.editar(u);

        response.sendRedirect("AdminServlet"); 
    }
    
    private void crearUsuario(HttpServletRequest request, HttpServletResponse response, UsuarioDAOJPAImpl dao) 
        throws IOException {

        Usuario u = new Usuario();

        u.setNombre(request.getParameter("nombre"));
        u.setApellido(request.getParameter("apellido"));
        u.setDNI(request.getParameter("dni")); 
        u.setCorreo(request.getParameter("correo"));
        u.setTelefono(request.getParameter("telefono"));

        String passRaw = request.getParameter("contrasenia");
        if(passRaw != null && !passRaw.isBlank()) {
            String passHash = PasswordHasher.hash(passRaw); // Encriptamos con BCrypt
            u.setContrasenia(passHash);
        } else {
            // Por defecto en caso de que algo falle
            u.setContrasenia(PasswordHasher.hash("123456")); 
        }

        u.setRol(Rol.valueOf(request.getParameter("rol")));
        u.setEstado(EstadoUsuario.valueOf(request.getParameter("estado")));

        dao.crear(u);

        response.sendRedirect("AdminServlet");
    }
}