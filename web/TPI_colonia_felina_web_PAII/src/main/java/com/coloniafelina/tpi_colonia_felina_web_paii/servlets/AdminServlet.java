package com.coloniafelina.tpi_colonia_felina_web_paii.servlets;

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

        // 1. Instanciamos el DAO por cada petición (Más seguro)
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
        
        // Verificamos si viene un ID. 
        // Si viene ID y no está vacío -> Es EDICIÓN.
        // Si es null o vacío -> Es CREACIÓN.
        String idStr = request.getParameter("idUsuario");

        if(idStr != null && !idStr.isEmpty()) {
            actualizarUsuario(request, response, usuarioDAO);
        } else {
            crearUsuario(request, response, usuarioDAO);
        }
    }

    // ==========================================
    // MÉTODOS AUXILIARES
    // ==========================================

    private void listarUsuarios(HttpServletRequest request, HttpServletResponse response, UsuarioDAOJPAImpl dao) 
            throws ServletException, IOException {
        List<Usuario> lista = dao.listarTodos();
        request.setAttribute("usuarios", lista);
        request.getRequestDispatcher("gestionUsuarios.jsp").forward(request, response);
    }

    private void mostrarFormularioEditar(HttpServletRequest request, HttpServletResponse response, UsuarioDAOJPAImpl dao) 
            throws ServletException, IOException {
        
        // Corregido: Parsear String a Long
        try {
            Long id = Long.parseLong(request.getParameter("id"));
            Usuario u = dao.buscarPorId(id); // Usamos la instancia 'dao', NO la clase estática
            
            request.setAttribute("usuarioEditar", u);
            request.setAttribute("listaRoles", Rol.values());
            request.setAttribute("listaEstados", EstadoUsuario.values());
            
            request.getRequestDispatcher("formUsuario.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect("AdminServlet"); // Si el ID es inválido, volver a la lista
        }
    }

    private void mostrarFormularioCrear(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // No pasamos "usuarioEditar", así el formulario sabe que está vacío
        request.setAttribute("listaRoles", Rol.values());
        request.setAttribute("listaEstados", EstadoUsuario.values());
        request.getRequestDispatcher("formUsuario.jsp").forward(request, response);
    }

    private void actualizarUsuario(HttpServletRequest request, HttpServletResponse response, UsuarioDAOJPAImpl dao) 
            throws IOException {
        
        Long id = Long.parseLong(request.getParameter("idUsuario"));
        
        // Buscamos el original
        Usuario u = dao.buscarPorId(id);
        
        // Actualizamos datos
        u.setNombre(request.getParameter("nombre"));
        u.setApellido(request.getParameter("apellido"));
        u.setCorreo(request.getParameter("correo")); // Ojo: a veces el correo no se debe editar
        u.setTelefono(request.getParameter("telefono"));
        
        // Enums
        u.setRol(Rol.valueOf(request.getParameter("rol")));
        u.setEstado(EstadoUsuario.valueOf(request.getParameter("estado")));

        // Guardar
        dao.editar(u);
        
        response.sendRedirect("AdminServlet"); 
    }
    
    private void crearUsuario(HttpServletRequest request, HttpServletResponse response, UsuarioDAOJPAImpl dao) 
            throws IOException {
        
        Usuario u = new Usuario();
        
        // Llenamos datos nuevos
        u.setNombre(request.getParameter("nombre"));
        u.setApellido(request.getParameter("apellido"));
        u.setDNI(request.getParameter("dni")); // Asegúrate de tener este campo en el form si es obligatorio
        u.setCorreo(request.getParameter("correo"));
        u.setTelefono(request.getParameter("telefono"));
        
        // Contraseña por defecto (OBLIGATORIO para crear)
        // En un sistema real, aquí enviarías un email al usuario para que la cambie.
        u.setContrasenia("123456"); 
        
        u.setRol(Rol.valueOf(request.getParameter("rol")));
        u.setEstado(EstadoUsuario.valueOf(request.getParameter("estado")));
        
        // Guardar nuevo
        dao.crear(u);
        
        response.sendRedirect("AdminServlet");
    }
}