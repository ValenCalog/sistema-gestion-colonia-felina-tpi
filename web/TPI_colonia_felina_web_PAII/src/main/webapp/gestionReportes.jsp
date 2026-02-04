<%@page import="com.prog.tpi_colonia_felina_paii.modelo.Usuario"%>
<%@page import="com.prog.tpi_colonia_felina_paii.modelo.Adopcion"%>
<%@page import="com.prog.tpi_colonia_felina_paii.modelo.Gato"%>
<%@page import="java.util.List"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    Usuario uLogueado = (Usuario) session.getAttribute("usuarioLogueado");
    String inicialAdmin = "A"; 
    String nombreCompleto = "Administrador"; 
    
    if (uLogueado != null && uLogueado.getNombre() != null && !uLogueado.getNombre().isEmpty()) {
        inicialAdmin = uLogueado.getNombre().substring(0, 1).toUpperCase();
        nombreCompleto = uLogueado.getNombre() + " " + (uLogueado.getApellido() != null ? uLogueado.getApellido() : "");
    }

    DateTimeFormatter fmt = DateTimeFormatter.ofPattern("dd/MM/yyyy");
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Reportes - Misión Michi</title>
    <jsp:include page="/WEB-INF/fragmentos/cabecera-estilos.jsp" />
    
    <style>
        ::-webkit-scrollbar { width: 8px; height: 8px; }
        ::-webkit-scrollbar-thumb { background: #cbd5e1; border-radius: 4px; }
        @media print {
            aside, .no-print { display: none !important; }
            main { margin: 0; padding: 0; width: 100%; }
            .shadow-sm, .shadow-lg { box-shadow: none !important; border: 1px solid #ccc; }
        }
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
                    <a class="sidebar-link hover:bg-gray-100 dark:hover:bg-white/5 p-2 rounded-lg flex items-center gap-3 transition-colors text-ink-light" href="AdminServlet?accion=evaluar">
                        <span class="material-symbols-outlined">how_to_reg</span>
                        <span class="text-sm font-medium">Evaluar Solicitudes</span>
                    </a>
                    <a class="sidebar-link hover:bg-gray-100 dark:hover:bg-white/5 p-2 rounded-lg flex items-center gap-3 transition-colors text-ink-light" href="AdminServlet">
                        <span class="material-symbols-outlined">group</span>
                        <span class="text-sm font-medium">Usuarios</span>
                    </a>
                    <a class="sidebar-link hover:bg-gray-100 dark:hover:bg-white/5 p-2 rounded-lg flex items-center gap-3 transition-colors text-ink-light" href="ZonaServlet">
                        <span class="material-symbols-outlined">map</span>
                        <span class="text-sm font-medium">Zonas</span>
                    </a>
                    <a class="sidebar-link-active bg-primary/10 text-primary p-2 rounded-lg flex items-center gap-3 font-bold" href="ReporteServlet">
                        <span class="material-symbols-outlined">file_present</span>
                        <span class="text-sm">Reportes</span>
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
            
            <header class="flex-none px-8 py-6 bg-surface-card dark:bg-surface-cardDark border-b border-border-light dark:border-border-dark flex justify-between items-center">
                
                <div class="lg:hidden flex items-center gap-3 mr-4">
                    <div class="w-8 h-8 rounded-full bg-primary/10 flex items-center justify-center text-primary font-bold text-xs border border-primary/20">
                        <%= inicialAdmin %>
                    </div>
                </div>

                <div>
                    <h2 class="text-2xl font-black text-ink dark:text-white"><%= request.getAttribute("titulo") != null ? request.getAttribute("titulo") : "Centro de Reportes" %></h2>
                    <p class="text-ink-light text-sm mt-1">Generación y visualización de datos históricos de la colonia.</p>
                </div>
                
                <button onclick="window.print()" class="no-print btn btn-outline gap-2 text-sm border-gray-300 text-gray-700 hover:bg-gray-50">
                    <span class="material-symbols-outlined text-base">print</span> Imprimir
                </button>
            </header>

            <div class="flex-1 overflow-y-auto p-8 bg-surface-light dark:bg-background-dark">
                
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-8 no-print">
                    <a href="ReporteServlet?tipo=esterilizados" class="group relative bg-white dark:bg-surface-cardDark p-6 rounded-2xl border border-border-light dark:border-border-dark hover:border-purple-400 hover:shadow-lg hover:shadow-purple-500/10 transition-all cursor-pointer flex items-center gap-4">
                        <div class="size-14 rounded-full bg-purple-50 text-purple-600 flex items-center justify-center group-hover:scale-110 transition-transform border border-purple-100">
                            <span class="material-symbols-outlined text-3xl">medical_services</span>
                        </div>
                        <div>
                            <h3 class="font-bold text-lg text-ink dark:text-white group-hover:text-purple-600 transition-colors">Gatos Esterilizados</h3>
                            <p class="text-sm text-ink-light">Listado de intervenciones y estado.</p>
                        </div>
                        <span class="absolute right-6 material-symbols-outlined text-gray-300 group-hover:text-purple-400 transition-colors">chevron_right</span>
                    </a>

                    <a href="ReporteServlet?tipo=adoptados" class="group relative bg-white dark:bg-surface-cardDark p-6 rounded-2xl border border-border-light dark:border-border-dark hover:border-green-500 hover:shadow-lg hover:shadow-green-500/10 transition-all cursor-pointer flex items-center gap-4">
                        <div class="size-14 rounded-full bg-green-50 text-green-600 flex items-center justify-center group-hover:scale-110 transition-transform border border-green-100">
                            <span class="material-symbols-outlined text-3xl">volunteer_activism</span>
                        </div>
                        <div>
                            <h3 class="font-bold text-lg text-ink dark:text-white group-hover:text-green-600 transition-colors">Adopciones Exitosas</h3>
                            <p class="text-sm text-ink-light">Historial de familias y adopciones.</p>
                        </div>
                        <span class="absolute right-6 material-symbols-outlined text-gray-300 group-hover:text-green-500 transition-colors">chevron_right</span>
                    </a>
                </div>

                <% 
                    String tipo = (String) request.getAttribute("tipoReporte");
                    if (tipo != null) {
                %>
                
                    <div class="bg-white dark:bg-surface-cardDark rounded-2xl border border-border-light dark:border-border-dark overflow-hidden shadow-sm">
                        
                        <% if (tipo.equals("esterilizados")) { 
                             List<Gato> gatos = (List<Gato>) request.getAttribute("datos");
                        %>
                            <div class="overflow-x-auto">
                                <table class="w-full text-left border-collapse">
                                    <thead class="bg-gray-50 dark:bg-gray-800 border-b border-gray-200 dark:border-gray-700">
                                        <tr>
                                            <th class="p-4 text-xs font-bold uppercase text-gray-500 tracking-wide w-1/4">Perfil del Gato</th>
                                            <th class="p-4 text-xs font-bold uppercase text-gray-500 tracking-wide">Zona / Ubicación</th>
                                            <th class="p-4 text-xs font-bold uppercase text-gray-500 tracking-wide">Fecha Ingreso</th>
                                            <th class="p-4 text-xs font-bold uppercase text-gray-500 tracking-wide">Sexo</th>
                                            <th class="p-4 text-xs font-bold uppercase text-gray-500 tracking-wide text-center">Estado</th>
                                        </tr>
                                    </thead>
                                    <tbody class="divide-y divide-gray-100 dark:divide-gray-800">
                                        <% for(Gato g : gatos) { %>
                                        <tr class="hover:bg-gray-50 dark:hover:bg-white/5 transition-colors">
                                            <td class="p-4">
                                                <div class="flex items-center gap-3">
                                                    <div class="size-10 rounded-full bg-gray-100 border border-gray-200 overflow-hidden shrink-0">
                                                        <% if(g.getFotografia() != null) { %>
                                                            <img src="<%= g.getFotografia() %>" class="w-full h-full object-cover">
                                                        <% } else { %>
                                                            <div class="w-full h-full flex items-center justify-center text-gray-400">
                                                                <span class="material-symbols-outlined text-lg">pets</span>
                                                            </div>
                                                        <% } %>
                                                    </div>
                                                    <div>
                                                        <p class="font-bold text-sm text-ink dark:text-white"><%= g.getNombre() %></p>
                                                        <p class="text-xs font-mono text-ink-light bg-gray-100 dark:bg-white/10 px-1 rounded inline-block">ID: <%= g.getIdGato() %></p>
                                                    </div>
                                                </div>
                                            </td>
                                            <td class="p-4">
                                                <div class="flex items-center gap-1 text-sm text-ink-light">
                                                    <span class="material-symbols-outlined text-base text-gray-400">location_on</span>
                                                    <%= g.getZona() != null ? g.getZona().getNombre() : "Sin zona asignada" %>
                                                </div>
                                            </td>
                                            <td class="p-4 text-sm font-mono text-ink-light">
                                                <%= g.getFechaAlta() != null ? g.getFechaAlta().format(fmt) : "N/A" %>
                                            </td>
                                            <td class="p-4">
                                                <div class="flex items-center gap-1.5 text-sm text-ink-light">
                                                    <% if("MACHO".equals(g.getSexo().toString())) { %>
                                                        <span class="material-symbols-outlined text-blue-500 text-lg">male</span> Macho
                                                    <% } else { %>
                                                        <span class="material-symbols-outlined text-pink-500 text-lg">female</span> Hembra
                                                    <% } %>
                                                </div>
                                            </td>
                                            <td class="p-4 text-center">
                                                <span class="px-2.5 py-1 rounded-full text-[10px] font-bold uppercase tracking-wide border 
                                                    <%= g.getDisponibilidad().toString().equals("ADOPTADO") ? "bg-green-100 text-green-700 border-green-200" : "bg-blue-100 text-blue-700 border-blue-200" %>">
                                                    <%= g.getDisponibilidad() %>
                                                </span>
                                            </td>
                                        </tr>
                                        <% } %>
                                        <% if(gatos.isEmpty()) { %>
                                            <tr><td colspan="5" class="p-10 text-center text-gray-400">No se encontraron gatos esterilizados.</td></tr>
                                        <% } %>
                                    </tbody>
                                </table>
                            </div>

                        <% } else if (tipo.equals("adoptados")) { 
                             List<Adopcion> adops = (List<Adopcion>) request.getAttribute("datos");
                        %>
                            <div class="overflow-x-auto">
                                <table class="w-full text-left border-collapse">
                                    <thead class="bg-gray-50 dark:bg-gray-800 border-b border-gray-200 dark:border-gray-700">
                                        <tr>
                                            <th class="p-4 text-xs font-bold uppercase text-gray-500 tracking-wide w-1/4">Gato Adoptado</th>
                                            <th class="p-4 text-xs font-bold uppercase text-gray-500 tracking-wide">Zona Origen</th>
                                            <th class="p-4 text-xs font-bold uppercase text-gray-500 tracking-wide">Fecha Adopción</th>
                                            <th class="p-4 text-xs font-bold uppercase text-gray-500 tracking-wide">Familia Adoptante</th>
                                            <th class="p-4 text-xs font-bold uppercase text-gray-500 tracking-wide text-center">Estado</th>
                                        </tr>
                                    </thead>
                                    <tbody class="divide-y divide-gray-100 dark:divide-gray-800">
                                        <% for(Adopcion a : adops) { %>
                                        <tr class="hover:bg-gray-50 dark:hover:bg-white/5 transition-colors">
                                            <td class="p-4">
                                                <div class="flex items-center gap-3">
                                                    <div class="size-10 rounded-full bg-orange-50 border border-orange-100 overflow-hidden shrink-0">
                                                        <% if(a.getGato().getFotografia() != null) { %>
                                                            <img src="<%= a.getGato().getFotografia() %>" class="w-full h-full object-cover">
                                                        <% } else { %>
                                                            <div class="w-full h-full flex items-center justify-center text-orange-300">
                                                                <span class="material-symbols-outlined text-lg">pets</span>
                                                            </div>
                                                        <% } %>
                                                    </div>
                                                    <div>
                                                        <span class="font-bold text-sm text-ink dark:text-white block"><%= a.getGato().getNombre() %></span>
                                                        <span class="text-xs font-mono text-ink-light bg-gray-100 dark:bg-white/10 px-1 rounded inline-block">ID: <%= a.getGato().getIdGato() %></span>
                                                    </div>
                                                </div>
                                            </td>
                                            <td class="p-4">
                                                <div class="text-sm text-ink-light flex items-center gap-1">
                                                    <span class="material-symbols-outlined text-base text-gray-400">location_on</span>
                                                    <%= a.getGato().getZona() != null ? a.getGato().getZona().getNombre() : "Sin zona" %>
                                                </div>
                                            </td>
                                            <td class="p-4 font-mono text-sm text-ink-light">
                                                <%= a.getFecha() != null ? a.getFecha().format(fmt) : "-" %>
                                            </td>
                                            <td class="p-4">
                                                <div>
                                                    <span class="text-sm font-semibold text-ink dark:text-white">Fam. <%= a.getFamiliaAdoptante().getCodigoFamilia() %></span>
                                                    <span class="text-xs text-ink-light block mt-0.5 max-w-[200px] truncate">
                                                        <span class="material-symbols-outlined text-[10px] align-middle">place</span>
                                                        <%= a.getFamiliaAdoptante().getDireccion() != null ? a.getFamiliaAdoptante().getDireccion() : "Sin dirección" %>
                                                    </span>
                                                </div>
                                            </td>
                                            <td class="p-4 text-center">
                                                <span class="px-2.5 py-1 rounded-full text-[10px] font-bold uppercase tracking-wide border bg-green-100 text-green-700 border-green-200">
                                                    <%= a.getEstado() %>
                                                </span>
                                            </td>
                                        </tr>
                                        <% } %>
                                        <% if(adops.isEmpty()) { %>
                                            <tr><td colspan="5" class="p-10 text-center text-gray-400">No hay historial de adopciones.</td></tr>
                                        <% } %>
                                    </tbody>
                                </table>
                            </div>
                        <% } %>

                        <div class="bg-gray-50 dark:bg-gray-800 p-4 border-t border-gray-200 dark:border-gray-700 flex justify-end items-center gap-2">
                            <span class="text-xs font-bold text-gray-500 uppercase">Total Registros:</span>
                            <span class="text-lg font-black text-ink dark:text-white">
                                <%= ((List)request.getAttribute("datos")).size() %>
                            </span>
                        </div>
                    </div>

                <% } else { %>
                    <div class="flex flex-col items-center justify-center py-20 text-center opacity-60">
                        <div class="bg-surface-card dark:bg-surface-cardDark p-6 rounded-full mb-4 shadow-sm">
                            <span class="material-symbols-outlined text-5xl text-gray-300">analytics</span>
                        </div>
                        <h3 class="text-xl font-bold text-ink dark:text-white">Selecciona un reporte</h3>
                        <p class="text-sm text-ink-light mt-1 max-w-sm">Haz clic en una de las tarjetas superiores para cargar los datos correspondientes.</p>
                    </div>
                <% } %>

            </div>
        </main>
    </div>
</body>
</html>