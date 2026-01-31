<%@page import="com.prog.tpi_colonia_felina_paii.modelo.*"%>
<%
    Gato g = (Gato) request.getAttribute("gato");
    String estadoSalud = g.getEstadoSalud().toString();
%>

<div class="space-y-6 animate-fade-in">
    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
        <div class="bg-white dark:bg-surface-cardDark rounded-2xl p-6 border border-border-light dark:border-border-dark shadow-sm">
            <div class="flex items-center gap-2 mb-4 text-primary">
                <span class="material-symbols-outlined">palette</span>
                <h3 class="text-base font-bold text-ink dark:text-white">Atributos Físicos</h3>
            </div>

            <div class="grid grid-cols-2 gap-4">
                <div>
                    <p class="text-xs text-ink-light mb-1 uppercase font-bold">Color / Pelaje</p>
                    <p class="text-sm font-medium"><%= g.getColor()%></p>
                </div>
                <div>
                    <p class="text-xs text-ink-light mb-1 uppercase font-bold">Estado</p>

                    <%
                        // Lógica visual simple para el texto
                        String claseTexto = "text-red-600";
                        if (estadoSalud.equals("SANO")) {
                            claseTexto = "text-green-600";
                        }
                        if (estadoSalud.equals("EN_TRATAMIENTO"))
                            claseTexto = "text-amber-600";
                    %>

                    <p class="text-sm font-bold <%= claseTexto%>">
                        <%= estadoSalud.replace("_", " ")%> </p>
                </div>
                <div>
                    <p class="text-xs text-ink-light mb-1 uppercase font-bold">Disponibilidad</p>
                    <p class="text-sm font-medium text-blue-600">
                        <%= (g.getDisponibilidad() != null) ? g.getDisponibilidad() : "N/A"%>
                    </p>
                </div>
            </div>

            <div class="pt-4 mt-4 border-t border-border-light dark:border-border-dark">
                <p class="text-xs text-ink-light mb-1 uppercase font-bold">Características y Señas</p>
                <p class="text-sm text-ink leading-relaxed">
                    <%= (g.getCaracteristicas() != null) ? g.getCaracteristicas() : "Sin descripción detallada."%>
                </p>
            </div>
        </div>

        <div class="bg-white dark:bg-surface-cardDark rounded-2xl p-6 border border-border-light dark:border-border-dark shadow-sm">
            <div class="flex items-center justify-between mb-4">
                <div class="flex items-center gap-2 text-primary">
                    <span class="material-symbols-outlined">pin_drop</span>
                    <h3 class="text-base font-bold text-ink dark:text-white">Ubicación y Territorio</h3>
                </div>
            </div>

            <div class="flex flex-col gap-4">
                <div class="p-3 bg-gray-50 dark:bg-white/5 rounded-lg border border-border-light dark:border-border-dark">
                    <p class="text-xs text-ink-light mb-1 uppercase font-bold">Zona Asignada</p>
                    <p class="text-lg font-bold flex items-center gap-2">
                        <%= (g.getZona() != null) ? g.getZona().getNombre() : "Sin Zona Asignada"%>
                    </p>
                </div>

                <%
                    if (g.getPuntoAvistamiento() != null && g.getPuntoAvistamiento().getLatitud() != 0) {
                        double lat = g.getPuntoAvistamiento().getLatitud();
                        double lon = g.getPuntoAvistamiento().getLongitud();
                %>
                <div id="map-gato" class="w-full h-64 rounded-xl z-0 border border-border-light dark:border-border-dark shadow-inner"></div>
                <div class="flex items-center justify-between mt-3 px-1">
                    <div class="flex flex-col">
                        <span class="text-[10px] uppercase font-bold text-ink-light">Coordenadas GPS</span>
                        <p class="text-xs text-ink font-mono"><%= lat%>, <%= lon%></p>
                    </div>
                    <span class="text-[10px] text-green-600 font-bold bg-green-50 px-2 py-1 rounded-full border border-green-100 flex items-center gap-1">
                        <span class="material-symbols-outlined text-[12px]">my_location</span>
                        Geolocalizado
                    </span>
                </div>

                <a href="https://www.google.com/maps?q=<%= lat%>,<%= lon%>" 
                   target="_blank"
                   class="mt-3 w-full flex items-center justify-center gap-2 bg-white dark:bg-surface-light border border-gray-200 dark:border-gray-700 hover:bg-gray-50 dark:hover:bg-white/5 text-ink dark:text-white font-bold py-2.5 rounded-lg transition-colors shadow-sm text-sm">
                    <img src="https://upload.wikimedia.org/wikipedia/commons/a/aa/Google_Maps_icon_%282020%29.svg" class="w-5 h-5" alt="GMaps">
                    Ver en Google Maps
                </a>

                <script>
                    document.addEventListener("DOMContentLoaded", function() {
                        // inicializamos el mapa
                        var map = L.map('map-gato').setView([<%= lat%>, <%= lon%>], 16);

                        // capa OpenStreetMap
                        L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
                            maxZoom: 19,
                            attribution: '&copy; OpenStreetMap'
                        }).addTo(map);

                        // marcador
                        var marker = L.marker([<%= lat%>, <%= lon%>]).addTo(map);
                        marker.bindPopup("<b><%= g.getNombre()%></b> <br> Visto por ultima vez aquí.").openPopup();
                    });
                </script>

                <% } else {%>

                <div class="h-48 bg-gray-100 dark:bg-white/5 rounded-xl flex flex-col items-center justify-center text-ink-light border-2 border-dashed border-border-light dark:border-gray-700">
                    <span class="material-symbols-outlined text-4xl mb-2 opacity-50">wrong_location</span>
                    <p class="text-sm font-medium">Ubicación no registrada</p>
                    <a href="GatoServlet?accion=editar&id=<%= g.getIdGato()%>" class="text-xs text-primary font-bold hover:underline mt-1">
                        Agregar coordenadas
                    </a>
                </div>

                <% }%>

            </div>
        </div>
    </div>
</div>                            