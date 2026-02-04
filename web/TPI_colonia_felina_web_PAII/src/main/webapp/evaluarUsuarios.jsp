<%@page import="com.prog.tpi_colonia_felina_paii.modelo.Veterinario"%>
<%@page import="java.util.List"%>
<%@page import="com.prog.tpi_colonia_felina_paii.modelo.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    Usuario uLogueado = (Usuario) session.getAttribute("usuarioLogueado");
    String inicialAdmin = "A"; 
    String nombreCompleto = "Administrador"; 
    
    if (uLogueado != null && uLogueado.getNombre() != null && !uLogueado.getNombre().isEmpty()) {
        inicialAdmin = uLogueado.getNombre().substring(0, 1).toUpperCase();
        nombreCompleto = uLogueado.getNombre() + " " + (uLogueado.getApellido() != null ? uLogueado.getApellido() : "");
    }

    List<Usuario> pendientes = (List<Usuario>) request.getAttribute("usuariosPendientes");
    int cantidad = (pendientes != null) ? pendientes.size() : 0;
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Evaluar Solicitudes - Misión Michi</title>
    
    <jsp:include page="/WEB-INF/fragmentos/cabecera-estilos.jsp" />
    
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <style>
        ::-webkit-scrollbar { width: 8px; height: 8px; }
        ::-webkit-scrollbar-track { background: transparent; }
        ::-webkit-scrollbar-thumb { background: #cbd5e1; border-radius: 4px; }
        ::-webkit-scrollbar-thumb:hover { background: #94a3b8; }
    </style>

    <script>
        function confirmarEvaluacion(boton, accion) {
            let titulo, texto, colorBtn, icono;

            if (accion === 'activar') {
                titulo = '¿Habilitar Usuario?';
                texto = 'El usuario tendrá acceso inmediato al sistema.';
                colorBtn = '#22c55e';
                icono = 'success';
            } else {
                titulo = '¿Bloquear Solicitud?';
                texto = 'El usuario no podrá acceder al sistema.';
                colorBtn = '#ef4444';
                icono = 'warning';
            }

            Swal.fire({
                title: titulo,
                text: texto,
                icon: icono,
                showCancelButton: true,
                confirmButtonColor: colorBtn,
                confirmButtonText: 'Sí, confirmar',
                cancelButtonText: 'Cancelar'
            }).then((result) => {
                if (result.isConfirmed) {
                    boton.closest('form').submit();
                }
            });
        }
    </script>
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
                    <a class="sidebar-link-active" href="AdminServlet?accion=evaluar">
                        <span class="material-symbols-outlined">how_to_reg</span>
                        <span class="text-sm">Evaluar Solicitudes</span>
                        <% if(cantidad > 0) { %>
                            <span class="ml-auto bg-primary text-white text-[10px] font-bold px-2 py-0.5 rounded-full"><%= cantidad %></span>
                        <% } %>
                    </a>
                    
                    <a class="sidebar-link" href="AdminServlet?accion=listar">
                        <span class="material-symbols-outlined">group</span>
                        <span class="text-sm">Usuarios</span>
                    </a>
                    <a class="sidebar-link" href="ZonaServlet">
                        <span class="material-symbols-outlined">map</span>
                        <span class="text-sm font-medium">Zonas</span>
                    </a>
                    <a class="sidebar-link" href="ReporteServlet">
                        <span class="material-symbols-outlined">file_present</span>
                        <span class="text-sm font-medium">Reportes</span>
                    </a>
                </nav>

                <div class="mt-auto border-t border-border-light dark:border-border-dark pt-4 px-2">
                    <div class="flex items-center gap-3">
                        <div class="w-10 h-10 rounded-full bg-gradient-to-tr from-primary to-orange-400 p-[2px]">
                            <div class="w-full h-full rounded-full bg-white dark:bg-surface-cardDark flex items-center justify-center">
                                <span class="font-bold text-primary"><%= inicialAdmin %></span>
                            </div>
                        </div>
                        
                        <div class="flex flex-col">
                            <p class="text-sm font-bold truncate max-w-[140px]"><%= nombreCompleto %></p>
                            <a href="LogoutServlet" class="text-xs text-red-500 hover:underline">Cerrar Sesión</a>
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
                <div class="w-8 h-8 rounded-full bg-primary/10 flex items-center justify-center text-primary font-bold text-xs border border-primary/20">
                    <%= inicialAdmin %>
                </div>
            </header>

            <div class="flex-1 overflow-y-auto p-4 md:p-8 bg-surface-light dark:bg-surface-dark">
                <div class="max-w-[1200px] mx-auto flex flex-col gap-8">
                    
                    <div class="flex items-center gap-2 text-sm text-ink-light">
                        <span class="text-ink dark:text-white font-medium">Administración</span>
                        <span>/</span>
                        <span class="text-primary font-bold">Solicitudes Pendientes</span>
                    </div>

                    <div class="flex flex-col gap-2">
                        <h1 class="heading-xl !text-3xl md:!text-4xl">Nuevos Ingresos</h1>
                        <p class="text-body max-w-2xl">
                            Revisa las solicitudes de registro de personal (Voluntarios y Veterinarios). 
                            Confirma sus datos antes de darles acceso al sistema.
                        </p>
                    </div>

                    <% if (pendientes != null && !pendientes.isEmpty()) { %>
                        <div class="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-3 gap-6">
                            <% for (Usuario u : pendientes) { 
                                String inicial = (u.getNombre() != null && !u.getNombre().isEmpty()) ? u.getNombre().substring(0, 1) : "?";
                                String rol = u.getRol().toString();
                                String badgeColor = rol.equals("VETERINARIO") ? "bg-purple-100 text-purple-700 border-purple-200" : "bg-orange-100 text-orange-700 border-orange-200";
                                String icon = rol.equals("VETERINARIO") ? "medical_services" : "volunteer_activism";
                            %>
                            
                            <div class="bg-surface-card dark:bg-surface-cardDark border border-border-light dark:border-border-dark rounded-2xl p-6 shadow-sm hover:shadow-md transition-shadow flex flex-col gap-4">
                                
                                <div class="flex justify-between items-start">
                                    <div class="flex items-center gap-4">
                                        <div class="size-14 rounded-full bg-gray-100 dark:bg-gray-700 flex items-center justify-center text-2xl font-bold text-gray-500">
                                            <%= inicial %>
                                        </div>
                                        <div>
                                            <h3 class="font-bold text-lg leading-tight"><%= u.getNombre() %> <%= u.getApellido() %></h3>
                                            <span class="text-xs font-mono text-ink-light">DNI: <%= u.getDNI() %></span>
                                        </div>
                                    </div>
                                    <span class="<%= badgeColor %> border px-2 py-1 rounded-lg text-[10px] font-bold uppercase flex items-center gap-1 tracking-wide">
                                        <span class="material-symbols-outlined text-sm"><%= icon %></span>
                                        <%= rol %>
                                    </span>
                                </div>
                                
                                <div class="bg-surface-light dark:bg-black/20 rounded-xl p-3 flex flex-col gap-2 text-sm">
                                    
                                    <% if (u instanceof Veterinario && rol.equals("VETERINARIO")) { 
                                       Veterinario vet = (Veterinario) u;
                                       String matricula = (vet.getMatricula() != null) ? vet.getMatricula() : "No registrada";
                                    %>
                                    <div class="flex items-center gap-2 text-purple-600 dark:text-purple-400 font-bold bg-purple-50 dark:bg-purple-900/20 p-2 rounded-lg -mx-1 mb-1">
                                        <span class="material-symbols-outlined text-base">verified</span>
                                        <span class="truncate">Matricula: <%= matricula %></span>
                                    </div>
                                    <% } %>
                                    
                                    <div class="flex items-center gap-2 text-ink-light">
                                        <span class="material-symbols-outlined text-base">mail</span>
                                        <span class="truncate"><%= u.getCorreo() %></span>
                                    </div>
                                    <div class="flex items-center gap-2 text-ink-light">
                                        <span class="material-symbols-outlined text-base">call</span>
                                        <span><%= u.getTelefono() != null ? u.getTelefono() : "Sin teléfono" %></span>
                                    </div>
                                </div>

                                <div class="flex gap-3 mt-auto pt-2">
                                    <form action="AdminServlet" method="POST" class="flex-1">
                                        <input type="hidden" name="accion" value="activar">
                                        <input type="hidden" name="idUsuario" value="<%= u.getIdUsuario() %>">
                                        <button type="button" onclick="confirmarEvaluacion(this, 'activar')" 
                                                class="w-full py-2.5 rounded-xl bg-emerald-500 hover:bg-emerald-600 text-white font-bold text-sm shadow-lg shadow-emerald-500/20 transition-all flex justify-center items-center gap-2">
                                            <span class="material-symbols-outlined text-lg">check</span> Habilitar
                                        </button>
                                    </form>

                                    <form action="AdminServlet" method="POST" class="flex-1">
                                        <input type="hidden" name="accion" value="bloquear">
                                        <input type="hidden" name="idUsuario" value="<%= u.getIdUsuario() %>">
                                        <button type="button" onclick="confirmarEvaluacion(this, 'bloquear')" 
                                                class="w-full py-2.5 rounded-xl border border-gray-200 hover:border-red-200 hover:bg-red-50 text-gray-600 hover:text-red-600 font-bold text-sm transition-all flex justify-center items-center gap-2">
                                            <span class="material-symbols-outlined text-lg">block</span> Bloquear
                                        </button>
                                    </form>
                                </div>

                            </div>
                            <% } %>
                        </div>
                    <% } else { %>
                        
                        <div class="flex flex-col items-center justify-center py-20 bg-white dark:bg-surface-cardDark rounded-3xl border-2 border-dashed border-border-light dark:border-border-dark text-center">
                            <div class="bg-green-50 dark:bg-green-900/20 p-6 rounded-full mb-4">
                                <span class="material-symbols-outlined text-5xl text-green-500">task_alt</span>
                            </div>
                            <h2 class="text-xl font-bold mb-2">¡Todo al día!</h2>
                            <p class="text-ink-light max-w-md">
                                No hay solicitudes pendientes de revisión. <br>
                                Todos los usuarios han sido procesados.
                            </p>
                            <a href="AdminServlet?accion=listar" class="mt-6 text-primary font-bold hover:underline">
                                Ver usuarios activos
                            </a>
                        </div>
                        
                    <% } %>

                </div>
            </div>
        </main>
    </div>
</body>
</html>