<%@page import="com.prog.tpi_colonia_felina_paii.modelo.Zona"%>
<%@page import="java.util.List" %>
<%
    List<Zona> zonas = (List<Zona>) request.getAttribute("listaZonas");
    Zona zonaEditar = (Zona) request.getAttribute("zonaSeleccionada");

    String idVal = (zonaEditar != null) ? String.valueOf(zonaEditar.getIdZona()) : "";
    String nomVal = (zonaEditar != null) ? zonaEditar.getNombre() : "";
    String descVal = (zonaEditar != null && zonaEditar.getDescripcion() != null) ? zonaEditar.getDescripcion() : "";
    String coordVal = (zonaEditar != null && zonaEditar.getCoordenadas() != null) ? zonaEditar.getCoordenadas() : "";
    
    boolean esEdicion = (zonaEditar != null);
    String tituloForm = esEdicion ? "Editar Zona" : "Nueva Zona";
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Gestión de Zonas</title>
    
    <jsp:include page="/WEB-INF/fragmentos/cabecera-estilos.jsp" />
    
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/leaflet.draw/1.0.4/leaflet.draw.css"/>

    <style>
        /* Ajustes de Mapa y Scroll */
        #map { height: 100%; width: 100%; z-index: 1; }
        .leaflet-draw-toolbar a { color: #ee8c2b !important; }
        
        /* Scrollbars finas */
        ::-webkit-scrollbar { width: 6px; height: 6px; }
        ::-webkit-scrollbar-track { background: transparent; }
        ::-webkit-scrollbar-thumb { background: #cbd5e1; border-radius: 3px; }
        ::-webkit-scrollbar-thumb:hover { background: #94a3b8; }
    </style>
</head>
<body class="font-sans bg-surface-light dark:bg-surface-dark text-ink dark:text-white overflow-hidden">
    
    <div class="flex h-screen w-full">
        
        <aside class="flex w-72 flex-col border-r border-border-light dark:border-border-dark bg-surface-card dark:bg-surface-cardDark transition-all duration-300 shrink-0 z-50">
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
                    <a class="sidebar-link" href="DashboardServlet">
                        <span class="material-symbols-outlined">dashboard</span>
                        <span class="text-sm">Dashboard</span>
                    </a>
                    <a class="sidebar-link" href="AdminServlet">
                        <span class="material-symbols-outlined">group</span>
                        <span class="text-sm font-medium">Usuarios</span>
                    </a>
                    <a class="sidebar-link-active" href="ZonaServlet">
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
                            <img alt="Admin" class="w-full h-full object-cover" src="https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?q=80&w=100&auto=format&fit=crop"/>
                        </div>
                        <div class="flex flex-col">
                            <p class="text-sm font-bold">Admin User</p>
                            <p class="text-xs text-ink-light">admin@misionmichi.com</p>
                        </div>
                    </div>
                </div>
            </div>
        </aside>

        <main class="flex-1 flex flex-col h-full overflow-hidden relative">
            
            <header class="flex-none px-6 py-4 bg-surface-card dark:bg-surface-cardDark border-b border-border-light dark:border-border-dark flex items-center justify-between z-20">
                <div>
                    <h2 class="text-xl font-black leading-tight">Gestión de Zonas</h2>
                    <p class="text-sm text-ink-light font-medium">Administra las colonias y territorios</p>
                </div>
                
                <div class="flex items-center gap-4">
                    <% if (request.getParameter("error") != null) { %>
                        <span class="badge bg-red-50 text-red-600 border-red-200"><%= request.getParameter("error") %></span>
                    <% } %>
                    <% if (request.getParameter("mensaje") != null) { %>
                        <span class="badge bg-green-50 text-green-600 border-green-200"><%= request.getParameter("mensaje") %></span>
                    <% } %>
                </div>
            </header>

            <div class="flex-1 flex overflow-hidden">
                
                <div class="w-72 bg-surface-light dark:bg-[#151b23] border-r border-border-light dark:border-border-dark flex flex-col shrink-0 z-10">
                    <div class="p-4 border-b border-border-light dark:border-border-dark bg-surface-card dark:bg-surface-cardDark">
                        <a href="ZonaServlet" class="btn btn-primary w-full gap-2 shadow-sm">
                            <span class="material-symbols-outlined">add</span> Nueva Zona
                        </a>
                    </div>
                    
                    <div class="flex-1 overflow-y-auto p-2 space-y-1">
                        <% if (zonas != null && !zonas.isEmpty()) {
                            for (Zona z : zonas) {
                                int cantGatos = (z.getGatos() != null) ? z.getGatos().size() : 0;
                                boolean isActive = (zonaEditar != null && zonaEditar.getIdZona().equals(z.getIdZona()));
                                String activeClass = isActive ? "bg-primary/10 border-primary ring-1 ring-primary/20" : "bg-surface-card dark:bg-surface-cardDark hover:bg-white border-transparent shadow-sm";
                        %>
                        <a href="ZonaServlet?idEditar=<%= z.getIdZona() %>" class="block">
                            <div class="flex items-center gap-3 p-3 rounded-xl border <%= activeClass %> transition-all cursor-pointer group">
                                <div class="h-8 w-8 rounded-full bg-surface-light dark:bg-border-dark flex items-center justify-center text-ink-light group-hover:text-primary transition-colors">
                                    <span class="material-symbols-outlined text-[18px]">location_on</span>
                                </div>
                                <div class="flex-1 min-w-0">
                                    <h3 class="font-bold truncate text-sm"><%= z.getNombre() %></h3>
                                    <span class="text-xs font-medium text-ink-light"><%= cantGatos %> Gatos</span>
                                </div>
                            </div>
                        </a>
                        <% }} else { %>
                        <div class="p-8 text-center opacity-50 text-sm">Sin zonas.</div>
                        <% } %>
                    </div>
                </div>

                <div class="flex-1 relative bg-gray-100 dark:bg-[#0d1117]">
                    <div id="map"></div>
                </div>

                <div class="w-80 bg-surface-card dark:bg-surface-cardDark border-l border-border-light dark:border-border-dark flex flex-col shrink-0 shadow-xl z-20">
                    
                    <div class="p-5 border-b border-border-light dark:border-border-dark flex items-center justify-between">
                        <h3 class="font-bold text-lg"><%= tituloForm %></h3>
                        <span class="badge <%= esEdicion ? "badge-admin" : "bg-gray-100 text-gray-500" %>">
                            <%= esEdicion ? "EDITANDO" : "CREANDO" %>
                        </span>
                    </div>

                    <div class="flex-1 overflow-y-auto p-5 custom-scrollbar">
                        <form action="ZonaServlet" method="POST">
                            <input type="hidden" name="idZona" value="<%= idVal %>">
                            <input type="hidden" id="coordenadas" name="coordenadas" value='<%= coordVal %>'>

                            <div class="space-y-5">
                                
                                <div class="space-y-1.5">
                                    <label class="text-sm font-bold ml-1 text-ink">Nombre de Zona</label>
                                    <div class="relative group">
                                        <span class="material-symbols-outlined input-icon">label</span>
                                        <input name="nombre" value="<%= nomVal %>" type="text" 
                                               class="input-field" placeholder="Ej. Plaza 9 de Julio" required/>
                                    </div>
                                </div>
                                
                                <div class="space-y-1.5">
                                    <label class="text-sm font-bold ml-1 text-ink">Descripción</label>
                                    <div class="relative group">
                                        <span class="material-symbols-outlined input-icon top-4 translate-y-0">description</span>
                                        <textarea name="descripcion" rows="4" 
                                                  class="input-field pl-11 resize-none" placeholder="Detalles de la ubicación..."><%= descVal %></textarea>
                                    </div>
                                </div>

                                <div class="bg-primary/5 p-4 rounded-xl border border-primary/20 flex gap-3">
                                    <span class="material-symbols-outlined text-primary">info</span>
                                    <p class="text-sm text-ink-light dark:text-gray-300">
                                        <span class="font-bold text-primary">Tip:</span> Dibuja en el mapa para definir el perímetro.
                                    </p>
                                </div>
                            </div>

                            <div class="mt-6 pt-6 border-t border-border-light dark:border-border-dark">
                                <button type="submit" class="btn btn-primary w-full shadow-lg shadow-primary/20">
                                    Guardar Cambios
                                </button>
                            </div>
                        </form>

                        <% if (esEdicion) { %>
                        <form action="EliminarZonaServlet" method="POST" class="mt-4" onsubmit="return confirm('¿Estás seguro? Esta accion no puede revertirse.');">
                            <input type="hidden" name="idZona" value="<%= idVal %>">
                            <button type="submit" class="btn btn-outline w-full !text-red-500 !border-red-200 hover:!bg-red-50">
                                Eliminar Zona
                            </button>
                        </form>
                        <% } %>
                        
                        <div class="h-10"></div>
                    </div>
                </div>

            </div>
        </main>
    </div>

    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/leaflet.draw/1.0.4/leaflet.draw.js"></script>

    <script>
        var map = L.map('map').setView([-27.3671, -55.8961], 13);
        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', { attribution: '&copy; OSM' }).addTo(map);

        var drawnItems = new L.FeatureGroup();
        map.addLayer(drawnItems);

        var drawControl = new L.Control.Draw({
            edit: { featureGroup: drawnItems },
            draw: { 
                polygon: { shapeOptions: { color: '#ee8c2b' } }, 
                rectangle: { shapeOptions: { color: '#ee8c2b' } },
                circle: false, marker: false, circlemarker: false, polyline: false 
            }
        });
        map.addControl(drawControl);

        // Eventos
        map.on(L.Draw.Event.CREATED, function (e) {
            drawnItems.clearLayers();
            drawnItems.addLayer(e.layer);
            document.getElementById('coordenadas').value = JSON.stringify(e.layer.toGeoJSON());
        });
        map.on('draw:edited', function (e) {
            e.layers.eachLayer(function (l) {
                 document.getElementById('coordenadas').value = JSON.stringify(l.toGeoJSON());
            });
        });
        map.on('draw:deleted', function () {
            document.getElementById('coordenadas').value = "";
        });

        // Cargar
        var coordsInput = document.getElementById('coordenadas').value;
        if (coordsInput && coordsInput.trim() !== "") {
            try {
                var geoJson = JSON.parse(coordsInput);
                var layer = L.geoJSON(geoJson, {
                    style: { color: "#ee8c2b", fillColor: "#ee8c2b", fillOpacity: 0.2 },
                    onEachFeature: function (f, l) { drawnItems.addLayer(l); }
                });
                map.fitBounds(layer.getBounds());
            } catch(e) {}
        }
    </script>
</body>
</html>