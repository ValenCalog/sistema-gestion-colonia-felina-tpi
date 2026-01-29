<%@page import="com.prog.tpi_colonia_felina_paii.modelo.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Gestión Usuario - GatoGestion</title>
    <jsp:include page="/WEB-INF/fragmentos/cabecera-estilos.jsp" />
</head>
<body class="bg-surface-light dark:bg-surface-dark min-h-screen flex items-center justify-center p-4">

    <div class="card w-full max-w-2xl bg-white dark:bg-[#1a2632]">
        
        <% 
            // 1. Recuperamos el usuario (puede ser NULL si es crear)
            Usuario u = (Usuario) request.getAttribute("usuarioEditar");
            boolean esEdicion = (u != null);
        %>

        <div class="flex items-center justify-between border-b border-border-light pb-4 mb-4">
            <h1 class="text-2xl font-bold text-ink dark:text-white">
                <%= esEdicion ? "Editar Usuario" : "Nuevo Usuario" %>
            </h1>
            <a href="AdminServlet" class="btn btn-secondary text-xs">Cancelar</a>
        </div>

        <form action="AdminServlet" method="POST" class="flex flex-col gap-6">
            
            <input type="hidden" name="idUsuario" value="<%= esEdicion ? u.getIdUsuario() : "" %>">

            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                
                <div class="flex flex-col gap-2">
                    <label class="text-sm font-bold text-ink">Nombre</label>
                    <input class="input-field" type="text" name="nombre" 
                           value="<%= esEdicion ? u.getNombre() : "" %>" required>
                </div>
                
                <div class="flex flex-col gap-2">
                    <label class="text-sm font-bold text-ink">Apellido</label>
                    <input class="input-field" type="text" name="apellido" 
                           value="<%= esEdicion ? u.getApellido() : "" %>" required>
                </div>
                
                <div class="flex flex-col gap-2">
                    <label class="text-sm font-bold text-ink">DNI</label>
                    <input class="input-field" type="text" name="dni" 
                           value="<%= esEdicion ? u.getDNI() : "" %>" required>
                </div>
                
                <div class="flex flex-col gap-2">
                    <label class="text-sm font-bold text-ink">Correo</label>
                    <input class="input-field" type="email" name="correo" 
                           value="<%= esEdicion ? u.getCorreo() : "" %>" required>
                </div>
                
                 <div class="flex flex-col gap-2">
                    <label class="text-sm font-bold text-ink">Teléfono</label>
                    <input class="input-field" type="text" name="telefono" 
                           value="<%= esEdicion ? u.getTelefono() : "" %>">
                </div>

                <div class="flex flex-col gap-2">
                    <label class="text-sm font-bold text-ink">Rol</label>
                    <select name="rol" class="input-field h-12 cursor-pointer">
                        <% for(com.prog.tpi_colonia_felina_paii.enums.Rol r : com.prog.tpi_colonia_felina_paii.enums.Rol.values()) { 
                            // Solo marcamos "selected" si estamos editando Y coincide el rol
                            String selected = (esEdicion && u.getRol() == r) ? "selected" : "";
                        %>
                            <option value="<%= r %>" <%= selected %>>
                                <%= r %>
                            </option>
                        <% } %>
                    </select>
                </div>

                <div class="flex flex-col gap-2">
                    <label class="text-sm font-bold text-ink">Estado</label>
                    <select name="estado" class="input-field h-12 cursor-pointer bg-orange-50 border-orange-200">
                        <% for(com.prog.tpi_colonia_felina_paii.enums.EstadoUsuario e : com.prog.tpi_colonia_felina_paii.enums.EstadoUsuario.values()) { 
                            // Solo marcamos "selected" si estamos editando Y coincide el estado
                            String selected = (esEdicion && u.getEstado() == e) ? "selected" : "";
                        %>
                            <option value="<%= e %>" <%= selected %>>
                                <%= e %>
                            </option>
                        <% } %>
                    </select>
                </div>
            </div>

            <div class="flex justify-end gap-3 mt-4 pt-4 border-t border-border-light">
                <button type="submit" class="btn btn-primary w-full md:w-auto shadow-lg shadow-primary/20">
                    <%= esEdicion ? "Guardar Cambios" : "Crear Usuario" %>
                </button>
            </div>
            
        </form>
    </div>

</body>
</html>