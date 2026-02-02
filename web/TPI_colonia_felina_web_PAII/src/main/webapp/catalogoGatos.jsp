<%@page import="com.prog.tpi_colonia_felina_paii.modelo.Gato"%>
<%@page import="java.util.List"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head><title>Catálogo - Misión Michi</title>
<jsp:include page="/WEB-INF/fragmentos/cabecera-estilos.jsp" /></head>
<body class="bg-surface-light dark:bg-surface-dark font-sans text-ink dark:text-white">
    <jsp:include page="/WEB-INF/fragmentos/navbar-familia.jsp" />

    <main class="max-w-7xl mx-auto px-4 py-8 flex flex-col md:flex-row gap-8">
        
        <aside class="w-full md:w-64 shrink-0">
            <div class="bg-white dark:bg-surface-cardDark rounded-2xl p-5 border border-border-light dark:border-border-dark sticky top-24 shadow-sm">

                <h3 class="font-bold text-lg mb-4 flex items-center gap-2 text-ink dark:text-white">
                    <span class="material-symbols-outlined text-primary">filter_alt</span> Filtros
                </h3>

                <form action="GatoServlet" method="GET" class="space-y-5">
                    <input type="hidden" name="accion" value="catalogo">

                    <div>
                        <label class="block text-xs font-bold text-gray-500 uppercase mb-1">Sexo</label>
                        <select name="sexo" class="w-full rounded-xl border-gray-200 dark:border-gray-700 bg-gray-50 dark:bg-black/20 text-sm focus:ring-primary focus:border-primary">
                            <option value="">Todos</option>
                            <option value="MACHO" <%= "MACHO".equals(request.getParameter("sexo")) ? "selected" : ""%>>Macho</option>
                            <option value="HEMBRA" <%= "HEMBRA".equals(request.getParameter("sexo")) ? "selected" : ""%>>Hembra</option>
                        </select>
                    </div>

                    <div>
                        <label class="block text-xs font-bold text-gray-500 uppercase mb-1">Esterilizado</label>
                        <select name="esterilizado" class="w-full rounded-xl border-gray-200 dark:border-gray-700 bg-gray-50 dark:bg-black/20 text-sm focus:ring-primary focus:border-primary">
                            <option value="">Indiferente</option>
                            <option value="true" <%= "true".equals(request.getParameter("esterilizado")) ? "selected" : ""%>>Sí, esterilizado</option>
                            <option value="false" <%= "false".equals(request.getParameter("esterilizado")) ? "selected" : ""%>>No (Sin operar)</option>
                        </select>
                    </div>

                    <div class="pt-2 space-y-2">
                        <button type="submit" class="w-full bg-primary hover:bg-green-600 text-white font-bold py-2 rounded-xl text-sm transition-colors shadow-lg shadow-primary/20">
                            Aplicar Filtros
                        </button>

                        <% if (request.getParameter("sexo") != null || request.getParameter("esterilizado") != null) { %>
                        <a href="GatoServlet?accion=catalogo" class="w-full block text-center bg-gray-100 hover:bg-gray-200 text-gray-600 font-bold py-2 rounded-xl text-sm transition-colors">
                            Borrar Filtros
                        </a>
                        <% } %>
                    </div>
                </form>
            </div>
        </aside>

        <div class="flex-1">
            <h1 class="text-2xl font-bold mb-6">Gatos Disponibles</h1>
            
            <%@page import="com.prog.tpi_colonia_felina_paii.enums.Sexo"%>

            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">

                <% 
                List<Gato> listaGatos = (List<Gato>) request.getAttribute("gatos");
                if (listaGatos != null && !listaGatos.isEmpty()) {
                    for (Gato g : listaGatos) {

                        
                        boolean esMacho = (g.getSexo() == Sexo.MACHO);
                        String iconSexo = esMacho ? "male" : "female";
                        
                        String colorSexo = esMacho ? "text-blue-500" : "text-pink-500";

                        
                        boolean tieneFoto = (g.getFotografia() != null && !g.getFotografia().isEmpty());
                        String fotoUrl = tieneFoto ? request.getContextPath() + g.getFotografia() : "";

                        
                        String disponibilidad = (g.getDisponibilidad().toString() != null) ? g.getDisponibilidad().toString() : "NO_DISPONIBLE";
                        boolean disponible = disponibilidad.equalsIgnoreCase("DISPONIBLE");
                        String badgeColor = disponible ? "bg-primary/90" : "bg-gray-500/90";
                %>

                <div class="group bg-white dark:bg-surface-cardDark rounded-2xl overflow-hidden border border-border-light dark:border-border-dark shadow-sm hover:shadow-xl transition-all duration-300 flex flex-col h-full">

                    <div class="relative aspect-[4/5] bg-gray-200 overflow-hidden">
                        <% if (tieneFoto) { %>
                            <img src="<%= fotoUrl %>" alt="<%= g.getNombre() %>" class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500">
                        <% } else { %>
                            <div class="w-full h-full flex flex-col items-center justify-center text-gray-300 dark:text-gray-600 bg-gray-50 dark:bg-white/5">
                                <span class="material-symbols-outlined text-6xl mb-2 opacity-50">pets</span>
                                <span class="text-xs font-bold uppercase tracking-widest text-gray-400">Foto próximamente</span>
                            </div>
                        <% } %>

                        <div class="absolute bottom-4 left-4 flex gap-2">
                            <span class="<%= badgeColor %> text-white px-3 py-1 rounded-full text-[10px] font-bold uppercase tracking-wider shadow-sm">
                                <%= disponibilidad %>
                            </span>
                        </div>
                    </div>

                    <div class="p-5 flex flex-col flex-1">

                        <div class="flex justify-between items-start mb-2">
                            <div>
                                <h4 class="text-xl font-bold text-ink dark:text-white leading-tight"><%= g.getNombre() %></h4>
                                <p class="text-sm text-gray-500 font-medium mt-1">
                                    <%= (g.getZona() != null) ? g.getZona().getNombre() : "Refugio Central" %>
                                </p>
                            </div>

                            <span class="material-symbols-outlined text-2xl <%= colorSexo %> bg-gray-50 dark:bg-white/5 p-1 rounded-lg" title="<%= g.getSexo() %>">
                                <%= iconSexo %>
                            </span>
                        </div>

                        <p class="text-sm text-gray-600 dark:text-gray-400 line-clamp-2 mb-6 flex-1">
                            <%= (g.getCaracteristicas() != null && !g.getCaracteristicas().isEmpty()) 
                                ? g.getCaracteristicas() 
                                : "Un michi adorable esperando conocerte y encontrar un hogar." %>
                        </p>

                        <a href="GatoServlet?accion=verFichaPublica&id=<%= g.getIdGato() %>" 
                           class="w-full bg-primary hover:bg-green-600 text-white font-bold py-3 rounded-xl transition-colors flex items-center justify-center gap-2 shadow-lg shadow-primary/20">
                            Ver Perfil
                            <span class="material-symbols-outlined text-sm">arrow_forward</span>
                        </a>
                    </div>
                </div>

                <% 
                    } // Fin for
                } else { 
                %>
                    <div class="col-span-full text-center py-20">
                        <span class="material-symbols-outlined text-6xl text-gray-300 mb-4">pets</span>
                        <p class="text-xl font-bold text-gray-500">No hay gatitos disponibles en este momento.</p>
                    </div>
                <% } %>

            </div>
        </div>
    </main>
</body>
</html>