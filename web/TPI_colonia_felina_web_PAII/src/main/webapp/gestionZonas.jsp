<%@page import="com.prog.tpi_colonia_felina_paii.modelo.Zona"%>
<%@page import="java.util.List" %>
<%
    // 1. RECUPERAMOS DATOS
    List<Zona> zonas = (List<Zona>) request.getAttribute("listaZonas");
    Zona zonaEditar = (Zona) request.getAttribute("zonaSeleccionada");

    // 2. EVITAMOS NULLS
    String idVal = (zonaEditar != null) ? String.valueOf(zonaEditar.getIdZona()) : "";
    String nomVal = (zonaEditar != null) ? zonaEditar.getNombre() : "";
    String descVal = (zonaEditar != null && zonaEditar.getDescripcion() != null) ? zonaEditar.getDescripcion() : "";
    // JSON de coordenadas
    String coordVal = (zonaEditar != null && zonaEditar.getCoordenadas() != null) ? zonaEditar.getCoordenadas() : "";
    
    // Títulos y Estados
    String tituloForm = (zonaEditar != null) ? "Editar Zona" : "Nueva Zona";
    boolean esEdicion = (zonaEditar != null);
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>Configuración de Zonas</title>
    
    <jsp:include page="/WEB-INF/fragmentos/cabecera-estilos.jsp" />

    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/leaflet.draw/1.0.4/leaflet.draw.css"/>

    <style>
        /* Ajustes para el mapa */
        #map { height: 100%; width: 100%; z-index: 1; }
        .leaflet-pane { z-index: 1 !important; }
        .leaflet-top, .leaflet-bottom { z-index: 2 !important; }
        
        /* Personalizamos Leaflet Draw para usar tu color primario (Naranja) */
        .leaflet-draw-toolbar a { color: #ee8c2b !important; }
        
        /* Scrollbar personalizada para coincidir con tu tema */
        .custom-scrollbar::-webkit-scrollbar { width: 6px; }
        .custom-scrollbar::-webkit-scrollbar-thumb { background-color: #e0e6e0; border-radius: 10px; }
        .dark .custom-scrollbar::-webkit-scrollbar-thumb { background-color: #735630; }
    </style>
</head>
<body class="bg-surface-light dark:bg-surface-dark font-sans text-ink dark:text-white h-screen overflow-hidden flex flex-col">

<header class="flex items-center justify-between px-6 py-3 bg-surface-card dark:bg-surface-cardDark border-b border-border-light dark:border-border-dark shrink-0 z-20">
    <div class="flex items-center gap-3">
        <div class="bg-primary rounded-lg p-1.5 text-ink flex items-center justify-center">
            <span class="material-symbols-outlined text-white">pets</span>
        </div>
        <h1 class="text-xl font-bold tracking-tight">Admin Zonas</h1>
    </div>
    
    <div class="flex-1 px-4 text-center">
        <% if (request.getParameter("error") != null) { %>
            <span class="badge bg-red-50 text-red-600 border-red-200"><%= request.getParameter("error") %></span>
        <% } %>
        <% if (request.getParameter("mensaje") != null) { %>
            <span class="badge bg-green-50 text-green-600 border-green-200"><%= request.getParameter("mensaje") %></span>
        <% } %>
    </div>

    <div class="flex items-center gap-2">
        <span class="text-sm font-medium text-ink-light dark:text-gray-400">Administrador</span>
        <div class="h-8 w-8 rounded-full bg-primary/20 flex items-center justify-center text-primary font-bold">A</div>
    </div>
</header>

<div class="flex flex-1 overflow-hidden">
    
    <div class="w-80 bg-surface-card dark:bg-surface-cardDark border-r border-border-light dark:border-border-dark flex flex-col shrink-0 z-10">
        <div class="p-4 border-b border-border-light dark:border-border-dark">
            <h2 class="text-lg font-bold mb-4 px-1">Zonas Registradas</h2>
            <a href="ZonaServlet" class="btn btn-primary w-full gap-2">
                <span class="material-symbols-outlined">add</span> Nueva Zona
            </a>
        </div>
        
        <div class="flex-1 overflow-y-auto custom-scrollbar p-2 space-y-1">
            <% 
            if (zonas != null && !zonas.isEmpty()) {
                for (Zona z : zonas) {
                    int cantGatos = (z.getGatos() != null) ? z.getGatos().size() : 0;
                    // Estilo activo si estamos editando esta zona
                    boolean isActive = (zonaEditar != null && zonaEditar.getIdZona().equals(z.getIdZona()));
                    String activeClass = isActive ? "bg-primary/10 border-primary" : "hover:bg-surface-light dark:hover:bg-white/5 border-transparent";
            %>
            
            <a href="ZonaServlet?idEditar=<%= z.getIdZona() %>" class="block">
                <div class="flex items-center gap-3 p-3 rounded-xl border <%= activeClass %> transition-colors cursor-pointer group">
                    <div class="h-10 w-10 rounded-full bg-surface-light dark:bg-border-dark flex items-center justify-center text-ink-light group-hover:text-primary transition-colors">
                        <span class="material-symbols-outlined">location_on</span>
                    </div>
                    <div class="flex-1 min-w-0">
                        <h3 class="font-bold truncate text-sm"><%= z.getNombre() %></h3>
                        <div class="flex items-center gap-2 mt-1">
                            <span class="text-xs font-medium text-ink-light dark:text-gray-400"><%= cantGatos %> Gatos</span>
                        </div>
                    </div>
                    <% if (isActive) { %>
                        <span class="material-symbols-outlined text-primary text-[20px]">edit</span>
                    <% } %>
                </div>
            </a>

            <% 
                } 
            } else { 
            %>
            <div class="flex flex-col items-center justify-center h-40 text-ink-light dark:text-gray-500 text-sm text-center px-4">
                <span class="material-symbols-outlined text-4xl mb-2 opacity-50">map</span>
                <p>No hay zonas registradas aún.</p>
            </div>
            <% } %>
        </div>
    </div>

    <main class="flex-1 flex flex-col h-full lg:flex-row relative">
        
        <div class="flex-1 relative min-h-[400px] lg:h-full bg-surface-light dark:bg-[#151b23]">
            <div id="map"></div>
        </div>

        <div class="w-full lg:w-96 bg-surface-card dark:bg-surface-cardDark border-l border-border-light dark:border-border-dark flex flex-col shrink-0 h-auto lg:h-full shadow-xl z-20">
            
            <div class="p-6 border-b border-border-light dark:border-border-dark flex items-center justify-between shrink-0">
                <h2 class="text-xl font-bold"><%= tituloForm %></h2>
                <% if (esEdicion) { %>
                    <span class="badge badge-admin">EDITANDO</span>
                <% } else { %>
                    <span class="badge bg-gray-100 text-gray-600 border-gray-200">CREANDO</span>
                <% } %>
            </div>

            <div class="flex-1 overflow-y-auto custom-scrollbar">
                
                <form action="ZonaServlet" method="POST">
                    <input type="hidden" name="idZona" value="<%= idVal %>">
                    <input type="hidden" id="coordenadas" name="coordenadas" value='<%= coordVal %>'>

                    <div class="p-6 space-y-5">
                        <div class="space-y-1.5">
                            <label class="text-sm font-bold ml-1">Nombre de Zona</label>
                            <div class="relative group">
                                <span class="material-symbols-outlined input-icon">label</span>
                                <input name="nombre" value="<%= nomVal %>" type="text" 
                                       class="input-field" placeholder="Ej. Plaza 9 de Julio" required/>
                            </div>
                        </div>
                        
                        <div class="space-y-1.5">
                            <label class="text-sm font-bold ml-1">Descripción</label>
                            <div class="relative group">
                                <span class="material-symbols-outlined input-icon top-4 translate-y-0">description</span>
                                <textarea name="descripcion" rows="4" 
                                          class="input-field pl-11 resize-none" placeholder="Detalles de la ubicación..."><%= descVal %></textarea>
                            </div>
                        </div>

                        <div class="bg-primary/5 p-4 rounded-xl border border-primary/20 flex gap-3">
                            <span class="material-symbols-outlined text-primary">info</span>
                            <p class="text-sm text-ink-light dark:text-gray-300">
                                <span class="font-bold text-primary">Instrucciones:</span> Usa las herramientas del mapa para dibujar el área de la colonia.
                            </p>
                        </div>
                    </div>

                    <div class="px-6 pb-6">
                        <button type="submit" class="btn btn-primary w-full shadow-lg shadow-primary/20">
                            Guardar Cambios
                        </button>
                    </div>
                </form>

                <% if (esEdicion) { %>
                <div class="px-6 pb-6 pt-2">
                    <div class="border-t border-border-light dark:border-border-dark pt-6">
                        <form action="EliminarZonaServlet" method="POST" onsubmit="return confirm('¿Estás seguro de eliminar esta zona? Esta acción no se puede deshacer.');">
                            <input type="hidden" name="idZona" value="<%= idVal %>">
                            <button type="submit" class="btn btn-outline w-full !text-red-600 !border-red-200 hover:!bg-red-50 dark:hover:!bg-red-900/20">
                                Eliminar Zona
                            </button>
                        </form>
                    </div>
                </div>
                <% } %>
                
                <div class="h-10"></div>
            </div>
        </div>
    </main>
</div>

<script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/leaflet.draw/1.0.4/leaflet.draw.js"></script>

<script>
    // Configuración del Mapa
    var map = L.map('map').setView([-27.3671, -55.8961], 13);
    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', { attribution: '&copy; OSM' }).addTo(map);

    var drawnItems = new L.FeatureGroup();
    map.addLayer(drawnItems);

    // Herramientas de Dibujo (Color Naranja #ee8c2b)
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
    map.on(L.Draw.Event.CREATED, function (event) {
        drawnItems.clearLayers();
        drawnItems.addLayer(event.layer);
        document.getElementById('coordenadas').value = JSON.stringify(event.layer.toGeoJSON());
    });
    
    map.on('draw:edited', function (e) {
        e.layers.eachLayer(function (layer) {
             document.getElementById('coordenadas').value = JSON.stringify(layer.toGeoJSON());
        });
    });
    map.on('draw:deleted', function () {
        document.getElementById('coordenadas').value = "";
    });

    // Cargar zona existente
    var coordsInput = document.getElementById('coordenadas').value;
    if (coordsInput && coordsInput.trim() !== "") {
        try {
            var geoJson = JSON.parse(coordsInput);
            var layer = L.geoJSON(geoJson, {
                style: { color: "#ee8c2b", fillColor: "#ee8c2b", fillOpacity: 0.2 },
                onEachFeature: function (f, l) { drawnItems.addLayer(l); }
            });
            map.fitBounds(layer.getBounds());
        } catch(e) { console.error("Error mapa", e); }
    }
</script>

</body>
</html>