<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.prog.tpi_colonia_felina_paii.modelo.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Usuario u = (Usuario) session.getAttribute("usuarioLogueado");
    String nombreDr = (u != null) ? u.getNombre() : "Doctor";
    
    List<Gato> criticos = (List<Gato>) request.getAttribute("listaCriticos");
    if (criticos == null) criticos = new ArrayList<>();
    
    List<Gato> enTratamiento = (List<Gato>) request.getAttribute("listaTratamiento");
    if (enTratamiento == null) enTratamiento = new ArrayList<>();
    
    Integer totalPacientes = (Integer) request.getAttribute("totalPacientes");
    if (totalPacientes == null) totalPacientes = 0;
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Guardia Médica - Misión Michi</title>
    <jsp:include page="/WEB-INF/fragmentos/cabecera-estilos.jsp" />
</head>

<body class="bg-surface-light dark:bg-surface-dark font-sans text-ink dark:text-white antialiased flex flex-col min-h-screen">
        
        <jsp:include page="/WEB-INF/fragmentos/navbar-veterinario.jsp" />

        <main class="flex-1 h-screen overflow-y-auto p-8">
            <div class="max-w-6xl mx-auto space-y-8">
                
                <header class="flex justify-between items-center mb-6">
                    <div>
                        <h1 class="text-2xl font-black text-ink dark:text-white">Guardia Veterinaria</h1>
                        <p class="text-ink-light text-sm">Resumen de pacientes críticos y tratamientos activos.</p>
                    </div>
                </header>

                <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                    <div class="bg-white dark:bg-surface-cardDark p-6 rounded-2xl shadow-sm border border-red-100 dark:border-red-900/30 relative overflow-hidden">
                        <div class="relative z-10">
                            <div class="flex justify-between items-start mb-2">
                                <p class="text-xs font-bold text-red-500 uppercase tracking-wider">Urgencias</p>
                                <span class="material-symbols-outlined text-red-500">e911_emergency</span>
                            </div>
                            <div class="flex items-baseline gap-2">
                                <span class="text-4xl font-black text-ink dark:text-white"><%= criticos.size() %></span>
                                <span class="text-sm text-ink-light">pacientes graves</span>
                            </div>
                        </div>
                        <div class="absolute right-0 top-0 h-full w-1 bg-red-500"></div>
                    </div>

                    <div class="bg-white dark:bg-surface-cardDark p-6 rounded-2xl shadow-sm border border-border-light dark:border-border-dark relative overflow-hidden">
                        <div class="relative z-10">
                            <div class="flex justify-between items-start mb-2">
                                <p class="text-xs font-bold text-amber-500 uppercase tracking-wider">Seguimiento</p>
                                <span class="material-symbols-outlined text-amber-500">pill</span>
                            </div>
                            <div class="flex items-baseline gap-2">
                                <span class="text-4xl font-black text-ink dark:text-white"><%= enTratamiento.size() %></span>
                                <span class="text-sm text-ink-light">tratamientos activos</span>
                            </div>
                        </div>
                        <div class="absolute right-0 top-0 h-full w-1 bg-amber-500"></div>
                    </div>

                    <div class="bg-white dark:bg-surface-cardDark p-6 rounded-2xl shadow-sm border border-border-light dark:border-border-dark relative overflow-hidden">
                        <div class="relative z-10">
                            <div class="flex justify-between items-start mb-2">
                                <p class="text-xs font-bold text-blue-500 uppercase tracking-wider">Base de Datos</p>
                                <span class="material-symbols-outlined text-blue-500">folder_shared</span>
                            </div>
                            <div class="flex items-baseline gap-2">
                                <span class="text-4xl font-black text-ink dark:text-white"><%= totalPacientes %></span>
                                <span class="text-sm text-ink-light">historias clínicas</span>
                            </div>
                        </div>
                        <div class="absolute right-0 top-0 h-full w-1 bg-blue-500"></div>
                    </div>
                </div>

                <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
                    
                    <div class="lg:col-span-2 space-y-6">
                        <div class="bg-white dark:bg-surface-cardDark rounded-2xl border border-border-light dark:border-border-dark shadow-sm overflow-hidden">
                            <div class="p-5 border-b border-border-light dark:border-gray-800 bg-red-50 dark:bg-red-900/10 flex justify-between items-center">
                                <h3 class="font-bold text-red-700 dark:text-red-300 flex items-center gap-2">
                                    <span class="material-symbols-outlined">clinical_notes</span>
                                    Pacientes Requiriendo Atención (Enfermos)
                                </h3>
                            </div>
                            
                            <% if (!criticos.isEmpty()) { %>
                                <div class="divide-y divide-border-light dark:divide-gray-800">
                                    <% for (Gato g : criticos) { %>
                                    <div class="p-4 hover:bg-gray-50 dark:hover:bg-white/5 transition-colors flex items-center gap-4 group">
                                        <div class="size-12 rounded-lg bg-gray-200 bg-center bg-cover shrink-0"
                                             style='background-image: url("<%= request.getContextPath() + (g.getFotografia() != null ? g.getFotografia() : "/img/placeholder.png") %>");'>
                                        </div>
                                        <div class="flex-1 min-w-0">
                                            <div class="flex justify-between">
                                                <h4 class="font-bold text-ink dark:text-white"><%= g.getNombre() %></h4>
                                                <span class="text-xs font-mono text-ink-light">HC: #<%= g.getIdGato() %></span>
                                            </div>
                                            <p class="text-xs text-red-500 font-bold mt-1">Diagnóstico Pendiente / Revisión</p>
                                        </div>
                                        <a href="VeterinarioServlet?accion=consultorio&idGato=<%= g.getIdGato() %>" class="btn bg-white border border-gray-200 text-xs font-bold px-4 py-2 rounded-lg hover:border-primary hover:text-primary transition-colors">
                                            Ver Historia
                                        </a>
                                    </div>
                                    <% } %>
                                </div>
                            <% } else { %>
                                <div class="p-8 text-center text-ink-light">
                                    <span class="material-symbols-outlined text-4xl mb-2 text-green-500 opacity-50">check_circle</span>
                                    <p>No hay pacientes marcados como "ENFERMO".</p>
                                </div>
                            <% } %>
                        </div>
                    </div>

                    <div class="space-y-6">
                        
                        <div class="bg-primary text-white rounded-2xl p-6 shadow-lg shadow-primary/20 relative overflow-hidden">
                            <div class="relative z-10">
                                <h3 class="font-bold text-lg mb-2">Consultar Historia</h3>
                                <p class="text-blue-100 text-sm mb-4">Ingrese ID o Nombre para acceder a la ficha médica, cargar estudios o emitir certificados.</p>
                                
                                <form action="VeterinarioServlet" method="GET" class="flex gap-2">
                                    <input type="hidden" name="accion" value="buscar"> 
                                    <input type="text" name="q" class="w-full rounded-lg border-0 py-2 px-3 text-ink text-sm focus:ring-2 focus:ring-white/50 shadow-sm" placeholder="Ej: Mochi o ID..." required>
                                    <button type="submit" class="bg-white text-primary p-2 rounded-lg font-bold hover:bg-blue-50 transition-colors shadow-sm" title="Buscar">
                                        <span class="material-symbols-outlined">search</span>
                                    </button>
                                </form>
                            </div>
                            <span class="material-symbols-outlined absolute -right-4 -bottom-4 text-9xl text-white/10 rotate-12">folder_shared</span>
                        </div>
                        
                    </div>
                </div>
            </div>
        </main>

</body>
</html>