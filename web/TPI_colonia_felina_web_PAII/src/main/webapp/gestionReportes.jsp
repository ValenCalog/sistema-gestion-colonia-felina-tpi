<%@page import="com.prog.tpi_colonia_felina_paii.modelo.Adopcion"%>
<%@page import="com.prog.tpi_colonia_felina_paii.modelo.Gato"%>
<%@page import="java.util.List"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
    </style>
</head>
<body class="font-sans bg-surface-light dark:bg-surface-dark text-ink dark:text-white overflow-hidden">
    
    <%
        // Formateador de fechas
        DateTimeFormatter fmt = DateTimeFormatter.ofPattern("dd/MM/yyyy");
    %>

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
                    <a class="sidebar-link" href="AdminServlet">
                        <span class="material-symbols-outlined">group</span>
                        <span class="text-sm font-medium">Usuarios</span>
                    </a>
                    <a class="sidebar-link" href="ZonaServlet">
                        <span class="material-symbols-outlined">map</span>
                        <span class="text-sm font-medium">Zonas</span>
                    </a>
                    <a class="sidebar-link-active" href="ReporteServlet">
                        <span class="material-symbols-outlined">file_present</span>
                        <span class="text-sm font-medium">Reportes</span>
                    </a>
                </nav>

                <div class="mt-auto border-t border-border-light dark:border-border-dark pt-4 px-2">
                    <div class="flex items-center gap-3">
                        <div class="w-10 h-10 rounded-full bg-gray-200 overflow-hidden">
                            <img alt="Admin" class="w-full h-full object-cover" src="https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?q=80&w=100&auto=format&fit=crop"/>
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
            
            <header class="flex-none px-8 py-6 bg-surface-card dark:bg-surface-cardDark border-b border-border-light dark:border-border-dark flex justify-between items-center">
                <div>
                    <h2 class="text-2xl font-black"><%= request.getAttribute("titulo") != null ? request.getAttribute("titulo") : "Centro de Reportes" %></h2>
                    <p class="text-ink-light">Generación y visualización de datos históricos.</p>
                </div>
                
                <button onclick="window.print()" class="btn btn-outline gap-2 text-sm">
                    <span class="material-symbols-outlined text-base">print</span> Imprimir
                </button>
            </header>

            <div class="flex-1 overflow-y-auto p-8">
                
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-8">
                    <a href="ReporteServlet?tipo=esterilizados" class="group relative bg-white dark:bg-[#151b23] p-6 rounded-2xl border border-border-light dark:border-border-dark hover:border-primary hover:shadow-lg hover:shadow-primary/10 transition-all cursor-pointer flex items-center gap-4">
                        <div class="size-14 rounded-full bg-purple-100 text-purple-600 flex items-center justify-center group-hover:scale-110 transition-transform">
                            <span class="material-symbols-outlined text-3xl">medical_services</span>
                        </div>
                        <div>
                            <h3 class="font-bold text-lg">Gatos Esterilizados</h3>
                            <p class="text-sm text-ink-light">Listado de intervenciones realizadas.</p>
                        </div>
                    </a>

                    <a href="ReporteServlet?tipo=adoptados" class="group relative bg-white dark:bg-[#151b23] p-6 rounded-2xl border border-border-light dark:border-border-dark hover:border-green-500 hover:shadow-lg hover:shadow-green-500/10 transition-all cursor-pointer flex items-center gap-4">
                        <div class="size-14 rounded-full bg-green-100 text-green-600 flex items-center justify-center group-hover:scale-110 transition-transform">
                            <span class="material-symbols-outlined text-3xl">volunteer_activism</span>
                        </div>
                        <div>
                            <h3 class="font-bold text-lg">Adopciones Exitosas</h3>
                            <p class="text-sm text-ink-light">Historial de gatos con familia.</p>
                        </div>
                    </a>
                </div>

                <% 
                    String tipo = (String) request.getAttribute("tipoReporte");
                    if (tipo != null) {
                %>
                
                    <div class="bg-white dark:bg-[#151b23] rounded-2xl border border-border-light dark:border-border-dark overflow-hidden shadow-sm">
                        
                        <% if (tipo.equals("esterilizados")) { 
                             List<Gato> gatos = (List<Gato>) request.getAttribute("datos");
                        %>
                            <div class="overflow-x-auto">
                                <table class="w-full text-left">
                                    <thead class="bg-gray-50 dark:bg-gray-800 border-b border-gray-200 dark:border-gray-700">
                                        <tr>
                                            <th class="p-4 text-xs font-bold uppercase text-gray-500">Nombre</th>
                                            <th class="p-4 text-xs font-bold uppercase text-gray-500">Sexo</th>
                                            <th class="p-4 text-xs font-bold uppercase text-gray-500">Color</th>
                                            <th class="p-4 text-xs font-bold uppercase text-gray-500">Fecha Ingreso</th>
                                            <th class="p-4 text-xs font-bold uppercase text-gray-500">Estado</th>
                                        </tr>
                                    </thead>
                                    <tbody class="divide-y divide-gray-100 dark:divide-gray-800">
                                        <% for(Gato g : gatos) { %>
                                        <tr class="hover:bg-gray-50 dark:hover:bg-gray-900/50">
                                            <td class="p-4 font-bold"><%= g.getNombre() %></td>
                                            <td class="p-4"><%= g.getSexo() %></td>
                                            
                                            <td class="p-4"><%= g.getColor() != null ? g.getColor() : "-" %></td>
                                            
                                            <td class="p-4 text-sm font-mono text-gray-500">
                                                <%= g.getFechaAlta() != null ? g.getFechaAlta().format(fmt) : "N/A" %>
                                            </td>
                                            
                                            <td class="p-4">
                                                <span class="px-2 py-1 rounded-md bg-gray-100 text-xs font-bold text-gray-600 border border-gray-200">
                                                    <%= g.getDisponibilidad() %>
                                                </span>
                                            </td>
                                        </tr>
                                        <% } %>
                                        <% if(gatos.isEmpty()) { %>
                                            <tr><td colspan="5" class="p-8 text-center text-gray-400">No hay registros aún.</td></tr>
                                        <% } %>
                                    </tbody>
                                </table>
                            </div>

                        <% } else if (tipo.equals("adoptados")) { 
                             List<Adopcion> adops = (List<Adopcion>) request.getAttribute("datos");
                        %>
                            <div class="overflow-x-auto">
                                <table class="w-full text-left">
                                    <thead class="bg-gray-50 dark:bg-gray-800 border-b border-gray-200 dark:border-gray-700">
                                        <tr>
                                            <th class="p-4 text-xs font-bold uppercase text-gray-500">Fecha</th>
                                            <th class="p-4 text-xs font-bold uppercase text-gray-500">Gato</th>
                                            <th class="p-4 text-xs font-bold uppercase text-gray-500">Familia Adoptante</th>
                                            <th class="p-4 text-xs font-bold uppercase text-gray-500">Estado Adopción</th>
                                        </tr>
                                    </thead>
                                    <tbody class="divide-y divide-gray-100 dark:divide-gray-800">
                                        <% for(Adopcion a : adops) { %>
                                        <tr class="hover:bg-gray-50 dark:hover:bg-gray-900/50">
                                            <td class="p-4 font-mono text-sm text-gray-500">
                                                <%= a.getFecha() != null ? a.getFecha().format(fmt) : "-" %>
                                            </td>
                                            <td class="p-4 font-bold text-primary"><%= a.getGato().getNombre() %></td>
                                            <td class="p-4">
                                                <%= a.getFamiliaAdoptante().getCodigoFamilia() %>
                                                <span class="text-xs text-gray-400 block">
                                                    <%= a.getFamiliaAdoptante().getDireccion() != null ? a.getFamiliaAdoptante().getDireccion() : "" %>
                                                </span>
                                            </td>
                                            <td class="p-4">
                                                <span class="px-2 py-1 rounded-md bg-green-100 text-xs font-bold text-green-600 border border-green-200">
                                                    <%= a.getEstado() %>
                                                </span>
                                            </td>
                                        </tr>
                                        <% } %>
                                        <% if(adops.isEmpty()) { %>
                                            <tr><td colspan="4" class="p-8 text-center text-gray-400">No hay adopciones registradas.</td></tr>
                                        <% } %>
                                    </tbody>
                                </table>
                            </div>
                        <% } %>

                        <div class="bg-gray-50 dark:bg-gray-800 p-4 border-t border-gray-200 dark:border-gray-700 text-right">
                            <span class="text-sm font-bold text-gray-500 uppercase mr-2">Total Registros:</span>
                            <span class="text-xl font-black text-ink dark:text-white">
                                <%= ((List)request.getAttribute("datos")).size() %>
                            </span>
                        </div>
                    </div>

                <% } else { %>
                    <div class="flex flex-col items-center justify-center py-12 text-center opacity-50">
                        <span class="material-symbols-outlined text-6xl mb-4 text-gray-300">analytics</span>
                        <p class="text-lg font-medium">Selecciona un tipo de reporte arriba para visualizar los datos.</p>
                    </div>
                <% } %>

            </div>
        </main>
    </div>
</body>
</html>