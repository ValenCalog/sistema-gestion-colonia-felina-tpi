<%@page import="com.prog.tpi_colonia_felina_paii.modelo.Usuario"%>
<%@page import="java.util.List"%>
<%@page import="com.prog.tpi_colonia_felina_paii.modelo.Gato"%>
<%@page import="com.prog.tpi_colonia_felina_paii.modelo.Zona"%>
<%@page import="com.prog.tpi_colonia_felina_paii.enums.Sexo"%>
<%@page import="com.prog.tpi_colonia_felina_paii.enums.Disponibilidad"%> 
<%@page import="com.prog.tpi_colonia_felina_paii.enums.EstadoSalud"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    // Lógica para el formulario del Gato
    Gato gato = (Gato) request.getAttribute("gatoEditar");
    boolean esEdicion = (gato != null);
    List<Zona> listaZonas = (List<Zona>) request.getAttribute("listaZonas");
%>

<!DOCTYPE html>
<html class="light" lang="es">
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title><%= esEdicion ? "Editar Gato" : "Registrar Gato" %> - Misión Michi</title>
    
    <link href="https://fonts.googleapis.com" rel="preconnect"/>
    <link crossorigin="" href="https://fonts.gstatic.com" rel="preconnect"/>
    <link href="https://fonts.googleapis.com/css2?family=Manrope:wght@200..800&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" integrity="sha256-p4NxAoJBhIIN+hmNHrzRCf9tD/miZyoHS5obTRR9BMY=" crossorigin=""/>
    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js" integrity="sha256-20nQCchB9co0qIjJZRGuk2/Z9VM+kNiyxNV1lvTlZBo=" crossorigin=""></script>
    
    <script>
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    colors: {
                        "primary": "#f97316",
                        "primary-hover": "#ea580c",
                        "ink": "#1e293b",
                        "ink-light": "#64748b",
                        "border-light": "#e2e8f0",
                        "border-dark": "#334155",
                        "surface-light": "#f8fafc",
                        "surface-dark": "#0f172a",
                        "surface-card": "#ffffff",
                        "surface-cardDark": "#1e293b",
                        "background-dark": "#1a2632",
                    },
                    fontFamily: {
                        "display": ["Manrope", "sans-serif"]
                    },
                },
            },
        }
    </script>
</head>
<body class="bg-surface-light dark:bg-background-dark font-display text-ink dark:text-white flex flex-col min-h-screen">

    <jsp:include page="/WEB-INF/fragmentos/navbar-voluntario.jsp" />

    <main class="flex-1 flex flex-col h-full w-full">
        
        <div class="px-6 sm:px-10 py-6 max-w-[1600px] w-full mx-auto">
            <div class="flex flex-wrap items-center gap-2 text-sm">
                <a class="text-gray-500 hover:text-primary transition-colors" href="GatoServlet?accion=listar">Listado de Gatos</a>
                <span class="text-gray-400">/</span>
                <span class="text-gray-900 dark:text-white font-medium"><%= esEdicion ? "Editar Gato" : "Nuevo Registro" %></span>
            </div>
        </div>

        <div class="flex flex-col xl:flex-row gap-6 px-6 sm:px-10 pb-10 max-w-[1600px] w-full mx-auto">
            
            <div class="flex-1 flex flex-col gap-6">
                <div class="flex flex-col gap-2">
                    <h1 class="text-3xl md:text-4xl font-black text-gray-900 dark:text-white tracking-tight">
                        <%= esEdicion ? "Editar Ficha del Gato" : "Registrar Nuevo Gato" %>
                    </h1>
                    <p class="text-gray-500 dark:text-gray-400">Completa la ficha técnica para ingresar un michi al sistema.</p>
                </div>

                <div class="bg-white dark:bg-[#1a2632] rounded-xl p-6 shadow-sm border border-gray-200 dark:border-gray-700">
                    
                    <form action="GatoServlet" method="POST" enctype="multipart/form-data" class="flex flex-col gap-8">
                        
                        <input type="hidden" name="idGato" value="<%= esEdicion ? gato.getIdGato() : "" %>">

                        <div>
                            <h3 class="text-lg font-bold text-gray-900 dark:text-white mb-4 flex items-center gap-2">
                                <span class="material-symbols-outlined text-primary">badge</span> Identificación
                            </h3>
                            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                <label class="flex flex-col gap-2">
                                    <span class="text-sm font-medium text-gray-700 dark:text-gray-300">Nombre (Opcional)</span>
                                    <input class="w-full rounded-lg border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-800 h-12 px-4 focus:border-primary focus:ring-primary" 
                                           name="nombre" type="text" placeholder="Ej: Bigotes"
                                           value="<%= esEdicion && gato.getNombre() != null ? gato.getNombre() : "" %>"/>
                                </label>
                                <label class="flex flex-col gap-2">
                                    <span class="text-sm font-medium text-gray-700 dark:text-gray-300">Color / Patrón *</span>
                                    <input class="w-full rounded-lg border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-800 h-12 px-4 focus:border-primary focus:ring-primary" 
                                           name="color" type="text" placeholder="Ej: Naranja atigrado" required
                                           value="<%= esEdicion ? gato.getColor() : "" %>"/>
                                </label>
                            </div>
                        </div>

                        <hr class="border-gray-100 dark:border-gray-700"/>

                        <div>
                            <h3 class="text-lg font-bold text-gray-900 dark:text-white mb-4 flex items-center gap-2">
                                <span class="material-symbols-outlined text-primary">monitor_heart</span> Estado & Ubicación
                            </h3>
                            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                
                                <label class="flex flex-col gap-2">
                                    <span class="text-sm font-medium text-gray-700 dark:text-gray-300">Estado de Salud *</span>
                                    <select name="estadoSalud" class="w-full rounded-lg border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-800 h-12 px-4 focus:border-primary focus:ring-primary">
                                        <% for(EstadoSalud es : EstadoSalud.values()) { 
                                            String selected = (esEdicion && gato.getEstadoSalud() == es) ? "selected" : "";
                                        %>
                                            <option value="<%= es %>" <%= selected %>><%= es %></option>
                                        <% } %>
                                    </select>
                                </label>

                                <label class="flex flex-col gap-2">
                                    <span class="text-sm font-medium text-gray-700 dark:text-gray-300">Disponibilidad *</span>
                                    <select name="disponibilidad" class="w-full rounded-lg border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-800 h-12 px-4 focus:border-primary focus:ring-primary">
                                        <% for(Disponibilidad d : Disponibilidad.values()) { 
                                            String selected = (esEdicion && gato.getDisponibilidad() == d) ? "selected" : "";
                                        %>
                                            <option value="<%= d %>" <%= selected %>><%= d %></option>
                                        <% } %>
                                    </select>
                                </label>

                                <label class="flex flex-col gap-2 md:col-span-2">
                                    <span class="text-sm font-medium text-gray-700 dark:text-gray-300">Zona Asignada (Opcional)</span>
                                    <select name="idZona" class="w-full rounded-lg border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-800 h-12 px-4 focus:border-primary focus:ring-primary">
                                        <option value="" selected>Sin zona asignada</option>
                                        <% if (listaZonas != null) {
                                            for(Zona z : listaZonas) { 
                                                boolean isSelected = (esEdicion && gato.getZona() != null && gato.getZona().getIdZona() != null && gato.getZona().getIdZona().equals(z.getIdZona()));
                                            %>
                                            <option value="<%= z.getIdZona() %>" <%= isSelected ? "selected" : "" %>><%= z.getNombre() %></option>
                                        <% } } %>
                                    </select>
                                    
                                    <div class="md:col-span-2 mt-4">
                                        <label class="flex flex-col gap-2">
                                            <span class="text-sm font-medium text-gray-700 dark:text-gray-300">
                                                Ubicación Exacta (Haz clic en el mapa)
                                            </span>

                                            <div id="map" class="w-full h-64 rounded-lg border border-gray-300 z-0"></div>

                                            <input type="hidden" id="latitud" name="latitud" 
                                                   value="<%= (esEdicion && gato.getPuntoAvistamiento() != null) ? gato.getPuntoAvistamiento().getLatitud() : "" %>">

                                            <input type="hidden" id="longitud" name="longitud" 
                                                   value="<%= (esEdicion && gato.getPuntoAvistamiento() != null) ? gato.getPuntoAvistamiento().getLongitud() : "" %>">

                                            <p class="text-xs text-gray-500 mt-1">Arrastra el marcador para ajustar la posición.</p>
                                        </label>
                                    </div>

                                    <script>
                                        document.addEventListener("DOMContentLoaded", function() {
                                            var defaultLat = -27.3671;
                                            var defaultLng = -55.8961;
                                            var zoomLevel = 13;

                                            var existingLat = document.getElementById('latitud').value;
                                            var existingLng = document.getElementById('longitud').value;

                                            var mapCenter = [defaultLat, defaultLng];
                                            var hasLocation = false;

                                            if (existingLat && existingLng) {
                                                mapCenter = [parseFloat(existingLat), parseFloat(existingLng)];
                                                hasLocation = true;
                                                zoomLevel = 16;
                                            }

                                            var map = L.map('map').setView(mapCenter, zoomLevel);

                                            L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
                                                attribution: '&copy; OpenStreetMap contributors'
                                            }).addTo(map);

                                            var marker;

                                            function updateInputs(lat, lng) {
                                                document.getElementById('latitud').value = lat;
                                                document.getElementById('longitud').value = lng;
                                            }

                                            if (hasLocation) {
                                                marker = L.marker(mapCenter, {draggable: true}).addTo(map);
                                                marker.on('dragend', function(event) {
                                                    var position = marker.getLatLng();
                                                    updateInputs(position.lat, position.lng);
                                                });
                                            }

                                            map.on('click', function(e) {
                                                var lat = e.latlng.lat;
                                                var lng = e.latlng.lng;

                                                if (marker) {
                                                    marker.setLatLng(e.latlng);
                                                } else {
                                                    marker = L.marker(e.latlng, {draggable: true}).addTo(map);
                                                    marker.on('dragend', function(event) {
                                                        var position = marker.getLatLng();
                                                        updateInputs(position.lat, position.lng);
                                                    });
                                                }
                                                updateInputs(lat, lng);
                                            });
                                        });
                                    </script>
                                </label>
                            </div>
                        </div>

                        <hr class="border-gray-100 dark:border-gray-700"/>
                        
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mt-6">
                            <label class="flex flex-col gap-2">
                                <span class="text-sm font-medium text-gray-700 dark:text-gray-300">Sexo *</span>
                                <select name="sexo" class="w-full rounded-lg border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-800 h-12 px-4 focus:border-primary focus:ring-primary">
                                    <% for(Sexo s : Sexo.values()) { 
                                        String selected = (esEdicion && gato.getSexo() == s) ? "selected" : "";
                                    %>
                                        <option value="<%= s %>" <%= selected %>><%= s %></option>
                                    <% } %>
                                </select>
                            </label>

                            <label class="flex flex-col gap-2">
                                <span class="text-sm font-medium text-gray-700 dark:text-gray-300">¿Está Esterilizado/Castrado? *</span>
                                <select name="esterilizado" class="w-full rounded-lg border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-800 h-12 px-4 focus:border-primary focus:ring-primary">
                                    <option value="false" <%= (esEdicion && !gato.isEsterilizado()) ? "selected" : "" %>>NO</option>
                                    <option value="true" <%= (esEdicion && gato.isEsterilizado()) ? "selected" : "" %>>SÍ</option>
                                </select>
                            </label>
                        </div>
                        
                        <div>
                            <h3 class="text-lg font-bold text-gray-900 dark:text-white mb-4 flex items-center gap-2 mt-6">
                                <span class="material-symbols-outlined text-primary">visibility</span> Visual & Foto
                            </h3>
                            <div class="flex flex-col gap-6">
                                <label class="flex flex-col gap-2">
                                    <span class="text-sm font-medium text-gray-700 dark:text-gray-300">Características Distintivas</span>
                                    <textarea name="caracteristicas" class="w-full rounded-lg border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-800 min-h-[100px] p-4 focus:border-primary focus:ring-primary" 
                                              placeholder="Cicatrices, color de ojos, cola cortada..."><%= esEdicion && gato.getCaracteristicas() != null ? gato.getCaracteristicas() : "" %></textarea>
                                </label>
                                
                                <div class="flex flex-col gap-2">
                                    <span class="text-sm font-medium text-gray-700 dark:text-gray-300">Subir Foto</span>
                                    <div class="w-full border-2 border-dashed border-gray-300 dark:border-gray-600 rounded-xl bg-gray-50 dark:bg-gray-800 hover:bg-orange-50 dark:hover:bg-gray-700 transition-colors p-8 flex flex-col items-center justify-center text-center cursor-pointer relative group">
                                        <input type="file" name="foto" class="absolute inset-0 w-full h-full opacity-0 cursor-pointer" accept="image/*">
                                        <div class="bg-white dark:bg-gray-700 p-3 rounded-full shadow-sm mb-3 group-hover:scale-110 transition-transform">
                                            <span class="material-symbols-outlined text-primary">add_a_photo</span>
                                        </div>
                                        <p class="font-medium text-gray-700 dark:text-gray-300">Click para subir foto</p>
                                        <p class="text-xs text-gray-500 mt-1">JPG, PNG (Max 2MB)</p>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="flex flex-col-reverse sm:flex-row justify-end gap-3 mt-4 pt-4 border-t border-gray-100 dark:border-gray-700">
                            <a href="GatoServlet?accion=listar" class="px-6 py-3 rounded-lg border border-gray-300 dark:border-gray-600 text-center font-bold text-gray-700 dark:text-white hover:bg-gray-50 dark:hover:bg-gray-700 transition-colors">
                                Cancelar
                            </a>
                            <button class="px-6 py-3 rounded-lg bg-primary text-white font-bold shadow-lg shadow-primary/30 hover:bg-primary-hover transition-all flex items-center justify-center gap-2" type="submit">
                                <span class="material-symbols-outlined">save</span>
                                <%= esEdicion ? "Guardar Cambios" : "Registrar Gato" %>
                            </button>
                        </div>
                    </form>
                </div>
            </div>
            
            <div class="w-full xl:w-[320px] flex flex-col gap-6 shrink-0">
                <div class="bg-white dark:bg-[#1a2632] rounded-xl p-6 shadow-sm border border-gray-200 dark:border-gray-700 sticky top-24">
                    <div class="flex items-center justify-between mb-4">
                        <h3 class="text-lg font-bold text-gray-900 dark:text-white">Vista Previa</h3>
                        <span class="bg-primary/10 text-primary text-xs font-bold px-2 py-1 rounded">BORRADOR</span>
                    </div>
                    <div class="bg-gray-50 dark:bg-gray-800 rounded-lg p-6 flex flex-col items-center gap-4 text-center border border-dashed border-gray-300 dark:border-gray-600">
                        <div class="bg-white p-3 rounded-lg shadow-sm">
                            <span class="material-symbols-outlined text-6xl text-gray-300">qr_code_2</span>
                        </div>
                        <div>
                            <p class="text-sm font-bold text-gray-900 dark:text-white">ID: <%= esEdicion ? gato.getIdGato() : "Pendiente..." %></p>
                            <p class="text-xs text-gray-500 mt-1">El código QR se generará al guardar.</p>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </main>
</body>
</html>