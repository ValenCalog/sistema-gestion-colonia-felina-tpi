<%@page import="java.util.List"%>
<%@page import="com.prog.tpi_colonia_felina_paii.modelo.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Gestión de Usuarios - Misión Michi</title>
    
    <jsp:include page="/WEB-INF/fragmentos/cabecera-estilos.jsp" />
    
    <style>
        ::-webkit-scrollbar { width: 8px; height: 8px; }
        ::-webkit-scrollbar-track { background: transparent; }
        ::-webkit-scrollbar-thumb { background: #cbd5e1; border-radius: 4px; }
        ::-webkit-scrollbar-thumb:hover { background: #94a3b8; }
    </style>
</head>
<body class="font-sans bg-surface-light dark:bg-surface-dark text-ink dark:text-white overflow-hidden">
    
    <div class="flex h-screen w-full">
        
        <aside class="flex w-72 flex-col border-r border-border-light dark:border-border-dark bg-surface-card dark:bg-surface-cardDark transition-all duration-300 hidden lg:flex">
            <div class="flex flex-col h-full p-4">
                <div class="mb-8 px-2 flex items-center gap-3">
                    <div class="flex items-center justify-center w-10 h-10 rounded-xl bg-primary/10 text-primary">
                        <span class="material-symbols-outlined text-2xl">pets</span>
                    </div>
                    <div class="flex flex-col">
                        <h1 class="text-lg font-bold leading-none">Misión Michi</h1>
                        <p class="text-xs text-ink-light font-medium mt-1">Panel Admin</p>
                    </div>
                </div>

                <nav class="flex flex-col gap-2 flex-1">
                    <a class="sidebar-link" href="AdminServlet?accion=evaluar">
                        <span class="material-symbols-outlined">how_to_reg</span>
                        <span class="text-sm">Evaluar Solicitudes</span>
                        </a>
                    
                    <a class="sidebar-link-active" href="#">
                        <span class="material-symbols-outlined">group</span>
                        <span class="text-sm">Usuarios</span>
                    </a>
                    <a class="sidebar-link" href="ZonaServlet">
                        <span class="material-symbols-outlined">map</span>
                        <span class="text-sm font-medium">Zonas</span>
                    </a>
                    <a class="sidebar-link" href="#">
                        <span class="material-symbols-outlined">file_present</span>
                        <span class="text-sm font-medium">Reportes</span>
                    </a>
                </nav>

                <div class="mt-auto border-t border-border-light dark:border-border-dark pt-4 px-2">
                    <div class="flex items-center gap-3">
                        <div class="w-10 h-10 rounded-full bg-gray-200 overflow-hidden">
                            <img alt="Admin Avatar" class="w-full h-full object-cover" src="https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?q=80&w=100&auto=format&fit=crop"/>
                        </div>
                        <div class="flex flex-col">
                            <p class="text-sm font-bold">Admin User</p>
                            <a href="LoginServlet?logout=true" class="text-xs text-red-500 hover:underline">Cerrar Sesión</a>
                        </div>
                    </div>
                </div>
            </div>
        </aside>

        <main class="flex-1 flex flex-col h-full overflow-hidden relative">
            
            <header class="lg:hidden flex items-center justify-between px-4 py-3 bg-surface-card dark:bg-surface-cardDark border-b border-border-light dark:border-border-dark">
                <div class="flex items-center gap-2">
                    <span class="material-symbols-outlined">menu</span>
                    <span class="font-bold text-lg">Misión Michi</span>
                </div>
                <div class="w-8 h-8 rounded-full bg-gray-200 overflow-hidden">
                    <img alt="User" class="w-full h-full object-cover" src="https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?q=80&w=100&auto=format&fit=crop"/>
                </div>
            </header>

            <div class="flex-1 overflow-y-auto p-4 md:p-8">
                <div class="max-w-[1200px] mx-auto flex flex-col gap-6">
                    
                    <div class="flex items-center gap-2 text-sm text-ink-light">
                        <span class="text-ink dark:text-white font-medium">Gestión de Usuarios</span>
                    </div>

                    <div class="flex flex-col md:flex-row md:items-end justify-between gap-4">
                        <div class="flex flex-col gap-2">
                            <h1 class="heading-xl !text-3xl md:!text-4xl">Gestión de Usuarios</h1>
                            <p class="text-body max-w-2xl">Administra el acceso y permisos de la plataforma.</p>
                        </div>

                        <a href="AdminServlet?accion=crear" class="btn btn-primary shadow-lg shadow-primary/30">
                            <span class="material-symbols-outlined mr-2">add</span>
                            Nuevo Usuario
                        </a>
                    </div>

                    <form action="AdminServlet" method="GET" class="card flex flex-col md:flex-row gap-4 p-4 items-center">
                        <input type="hidden" name="accion" value="listar">

                        <div class="relative grow w-full">
                            <span class="material-symbols-outlined input-icon">search</span>
                            <input class="input-field" 
                                   type="text" 
                                   name="busqueda" 
                                   placeholder="Buscar por nombre, apellido o email..." 
                                   value="<%= request.getAttribute("busquedaActual") != null ? request.getAttribute("busquedaActual") : "" %>"
                            />
                        </div>

                        <div class="flex gap-3 w-full md:w-auto">
                            <select name="filtroRol" class="input-field w-full md:w-48 h-11 py-0 cursor-pointer" onchange="this.form.submit()">
                                <option value="">Todos los Roles</option>
                                <% 
                                   String rolActual = (String) request.getAttribute("rolActual");
                                   for(com.prog.tpi_colonia_felina_paii.enums.Rol r : com.prog.tpi_colonia_felina_paii.enums.Rol.values()) { 
                                       String selected = (rolActual != null && rolActual.equals(r.toString())) ? "selected" : "";
                                %>
                                    <option value="<%= r %>" <%= selected %>><%= r %></option>
                                <% } %>
                            </select>

                            <button type="submit" class="btn btn-secondary px-3" title="Buscar">
                                <span class="material-symbols-outlined">filter_list</span>
                            </button>

                            <% if (request.getAttribute("busquedaActual") != null || request.getAttribute("rolActual") != null) { %>
                                <a href="AdminServlet?accion=listar" class="btn btn-outline !text-ink-light border-border-light hover:bg-gray-100" title="Limpiar filtros">
                                    <span class="material-symbols-outlined">close</span>
                                </a>
                            <% } %>
                        </div>
                    </form>

                    <div class="bg-surface-card dark:bg-surface-cardDark rounded-xl shadow-sm border border-border-light dark:border-border-dark overflow-hidden">
                        <div class="overflow-x-auto">
                            <table class="w-full text-left border-collapse">
                                <thead class="bg-gray-50 dark:bg-gray-900 border-b border-border-light dark:border-border-dark">
                                    <tr>
                                        <th class="table-header text-xs uppercase tracking-wider text-ink-light">Usuario</th>
                                        <th class="table-header text-xs uppercase tracking-wider text-ink-light">Rol</th>
                                        <th class="table-header text-xs uppercase tracking-wider text-ink-light">Estado</th>
                                        <th class="table-header text-right"></th> </tr>
                                </thead>
                                <tbody class="divide-y divide-border-light dark:divide-border-dark">
                                    <%
                                        List<Usuario> lista = (List<Usuario>) request.getAttribute("usuarios");

                                        if (lista != null && !lista.isEmpty()) {
                                            for (Usuario u : lista) {
                                    %>
                                    <tr class="hover:bg-gray-50 dark:hover:bg-gray-900/50 transition-colors">

                                        <td class="table-cell whitespace-nowrap">
                                            <div class="flex items-center gap-3">
                                                <div class="w-10 h-10 rounded-full bg-primary/10 flex items-center justify-center text-primary font-bold">
                                                    <%= (u.getNombre() != null ? u.getNombre().charAt(0) : '-') %><%= (u.getApellido() != null ? u.getApellido().charAt(0) : '-') %>
                                                </div>
                                                <div class="flex flex-col">
                                                    <p class="text-sm font-bold"><%= u.getNombre() %> <%= u.getApellido() %></p>
                                                    <p class="text-xs text-ink-light"><%= u.getCorreo() %></p>
                                                </div>
                                            </div>
                                        </td>

                                        <td class="table-cell whitespace-nowrap">
                                            <% 
                                               String rolNombre = (u.getRol() != null) ? u.getRol().toString() : "SIN ROL";
                                               String rolClase = "badge-adopter"; 

                                               if("ADMIN".equals(rolNombre)) rolClase = "badge-admin";
                                               else if("VOLUNTARIO".equals(rolNombre)) rolClase = "badge-volunteer";
                                               else if("VETERINARIO".equals(rolNombre)) rolClase = "badge-vet";
                                            %>
                                            <span class="badge <%= rolClase %>">
                                                <span class="material-symbols-outlined text-[14px]">pets</span>
                                                <%= rolNombre %>
                                            </span>
                                        </td>

                                        <td class="table-cell whitespace-nowrap">
                                            <div class="flex items-center gap-2 text-sm font-medium">
                                                <% 
                                                   String estadoStr = (u.getEstado() != null) ? u.getEstado().toString() : "DESCONOCIDO";
                                                   boolean isActivo = "ACTIVO".equals(estadoStr);
                                                   String colorPunto = isActivo ? "bg-emerald-500" : "bg-gray-400";
                                                   if("BLOQUEADO".equals(estadoStr)) colorPunto = "bg-red-500";
                                                   if("PENDIENTE".equals(estadoStr)) colorPunto = "bg-yellow-500";
                                                %>
                                                <span class="h-2 w-2 rounded-full <%= colorPunto %>"></span> 
                                                <%= estadoStr %>
                                            </div>
                                        </td>

                                        <td class="table-cell text-right">
                                            <a href="AdminServlet?accion=editar&id=<%= u.getIdUsuario() %>" class="text-ink-light hover:text-primary transition-colors">
                                                <span class="material-symbols-outlined">edit</span>
                                            </a>
                                        </td>
                                    </tr>
                                    <% 
                                            } 
                                        } else { 
                                    %>
                                    <tr>
                                        <td colspan="4" class="p-8 text-center text-ink-light">
                                            No se encontraron usuarios.
                                        </td>
                                    </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    
                </div>
            </div>
        </main>
    </div>
</body>
</html>