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
            <div class="card p-5 sticky top-24">
                <h3 class="font-bold text-lg mb-4 flex items-center gap-2">
                    <span class="material-symbols-outlined text-primary">filter_list</span> Filtros
                </h3>
                <form action="GatoServlet" method="GET" class="space-y-4">
                    <input type="hidden" name="accion" value="catalogo">

                    <div class="flex items-center gap-2 mt-2">
                        <input type="checkbox" name="esterilizado" value="true" class="rounded text-primary focus:ring-primary">
                        <span class="text-sm">Solo Esterilizados</span>
                    </div>

                    <button type="submit" class="btn btn-primary w-full mt-2 text-sm">Aplicar Filtros</button>
                    <a href="GatoServlet?accion=catalogo" class="btn btn-secondary w-full text-sm text-center block">Limpiar</a>
                </form>
            </div>
        </aside>

        <div class="flex-1">
            <h1 class="text-2xl font-bold mb-6">Gatos Disponibles</h1>
            
            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
                <% 
                List<Gato> gatos = (List<Gato>) request.getAttribute("gatos");
                if (gatos != null && !gatos.isEmpty()) {
                    for (Gato g : gatos) {
                        String fotoUrl = (g.getFotografia() != null) ? request.getContextPath() + g.getFotografia() : "https://via.placeholder.com/300";
                %>
                <div class="card p-0 overflow-hidden group hover:shadow-lg transition-all">
                    <div class="h-56 relative overflow-hidden">
                        <img src="<%= fotoUrl %>" class="w-full h-full object-cover group-hover:scale-105 transition-transform">
                        <div class="absolute bottom-0 inset-x-0 bg-gradient-to-t from-black/70 to-transparent p-4 text-white">
                            <h3 class="font-bold text-xl"><%= g.getNombre() %></h3>
                        </div>
                    </div>
                    <div class="p-4">
                        <p class="text-sm text-ink-light line-clamp-2 mb-4"><%= g.getCaracteristicas() %></p>
                        <a href="GatoServlet?accion=verDetallePublico&id=<%= g.getIdGato() %>" class="btn btn-primary w-full">
                            Ver Perfil y Adoptar
                        </a>
                    </div>
                </div>
                <% } } else { %>
                    <div class="col-span-full py-12 text-center border-2 border-dashed border-gray-300 rounded-xl">
                        <span class="material-symbols-outlined text-4xl text-gray-400">pets</span>
                        <p class="mt-2 text-gray-500">¡Lo lamentamos! No hay gatos disponibles con estos filtros.</p>
                        <a href="GatoServlet?accion=catalogo" class="text-primary font-bold hover:underline">Ver todos</a>
                    </div>
                <% } %>
            </div>
        </div>
    </main>
</body>
</html>