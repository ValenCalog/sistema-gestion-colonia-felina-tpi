<%@page import="com.prog.tpi_colonia_felina_paii.modelo.*"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // RECUPERAR DATOS
    Gato g = (Gato) request.getAttribute("gato");
    Usuario u = (Usuario) session.getAttribute("usuarioLogueado");
    
    // validar si hay foto del gato
    boolean tieneFoto = (g.getFotografia() != null && !g.getFotografia().isEmpty());
    String fotoUrl = tieneFoto ? request.getContextPath() + g.getFotografia() : "";
    
    String estadoSalud = g.getEstadoSalud().toString();
    String colorSalud = "";
    String iconoSalud = "";

    switch (estadoSalud) {
        case "SANO":
            colorSalud = "bg-green-500"; // Verde
            iconoSalud = "check";        // Icono Check
            break;
            
        case "EN_TRATAMIENTO":
            colorSalud = "bg-amber-500"; // Naranja/Ambar
            iconoSalud = "healing";      // Icono de Curita/Sanación
            break;
            
        case "ENFERMO":
        default:
            colorSalud = "bg-red-500";   // Rojo
            iconoSalud = "medical_services"; // Icono Cruz Médica
            break;
    }
%>
<!DOCTYPE html>
<html lang="es" class="scroll-smooth">
<head>
    <title>Ficha: <%= g.getNombre() %> - Misión Michi</title>
    <jsp:include page="/WEB-INF/fragmentos/cabecera-estilos.jsp" />
    <style>
        /* para impresión de la tarjeta de identificación */
        @media print {
            body * { visibility: hidden; }
            #printable-id-card, #printable-id-card * { visibility: visible; }
            #printable-id-card { position: absolute; left: 0; top: 0; width: 100%; }
        }
    </style>
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css"
        integrity="sha256-p4NxAoJBhIIN+hmNHrzRCf9tD/miZyoHS5obTRR9BMY="
        crossorigin=""/>

    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"
         integrity="sha256-20nQCchB9co0qIjJZRGuk2/Z9VM+kNiyxNV1lvTlZBo="
         crossorigin=""></script>
</head>

<body class="bg-surface-light dark:bg-surface-dark font-sans text-ink dark:text-white antialiased">
    
    <jsp:include page="/WEB-INF/fragmentos/navbar-voluntario.jsp" />

    <main class="flex-1 overflow-y-auto p-4 md:p-8">
        
        <div class="max-w-[1200px] mx-auto mb-6 flex items-center gap-2 text-sm text-ink-light">
            <a href="VoluntarioServlet" class="hover:text-primary">Inicio</a>
            <span>/</span>
            <a href="GatoServlet?accion=listar" class="hover:text-primary">Listado</a>
            <span>/</span>
            <span class="font-bold text-ink dark:text-white"><%= g.getNombre() %> (#<%= g.getIdGato() %>)</span>
        </div>

        <div class="max-w-[1200px] mx-auto flex flex-col lg:flex-row gap-6">
            
            <div class="w-full lg:w-1/3 flex flex-col gap-6">
                
                <div id="printable-id-card" class="bg-white dark:bg-surface-cardDark rounded-2xl p-6 border border-border-light dark:border-border-dark shadow-lg relative overflow-hidden group">
                    <div class="absolute top-0 left-0 w-full h-1 bg-gradient-to-r from-primary to-green-800"></div>
                    
                    <div class="flex flex-col items-center text-center">
                        <div class="relative mb-4">
                    <div class="size-32 rounded-full border-4 border-white dark:border-surface-cardDark shadow-lg overflow-hidden bg-gray-100 dark:bg-white/5 flex items-center justify-center relative">

                        <% if (tieneFoto) { %>
                            <img src="<%= fotoUrl %>" class="w-full h-full object-cover">

                        <% } else { %>
                            <div class="flex flex-col items-center justify-center text-gray-300 dark:text-gray-600">
                                <span class="material-symbols-outlined text-5xl">pets</span>
                                <span class="text-[10px] font-bold uppercase mt-1 text-gray-400">Sin Foto</span>
                            </div>
                        <% } %>

                    </div>

                    <div class="absolute bottom-1 right-1 <%= colorSalud %> border-2 border-white rounded-full p-1" title="<%= estadoSalud %>">
                        <span class="material-symbols-outlined text-white text-[14px] block">
                            <%= estadoSalud.equals("SANO") ? "check" : "medical_services" %>
                        </span>
                    </div>
                </div>
                        
                        <h2 class="text-2xl font-black text-ink dark:text-white mb-1"><%= g.getNombre() %></h2>
                        
                        <div class="flex items-center gap-2 mb-4">
                            <span class="bg-gray-100 dark:bg-white/10 px-2 py-0.5 rounded text-xs font-mono border border-border-light dark:border-border-dark">
                                ID: <%= g.getIdGato() %>
                            </span>
                        </div>

                        <div class="flex flex-wrap justify-center gap-2 mb-6 w-full">
                           
                        </div>

                        <div class="w-full bg-gray-50 dark:bg-black/20 rounded-xl p-4 flex items-center justify-between border border-border-light dark:border-border-dark">
                            <div class="text-left">
                                <p class="text-[10px] uppercase tracking-wider text-ink-light font-bold mb-1">Identidad Digital</p>
                                <button onclick="window.print()" class="text-xs text-primary hover:underline flex items-center gap-1 font-bold">
                                    <span class="material-symbols-outlined text-[14px]">print</span> Imprimir Ficha
                                </button>
                            </div>
                            <div class="bg-white p-1 rounded shadow-sm">
                                <img src="ImagenQrServlet?id=<%= g.getIdGato() %>" class="size-12">
                            </div>
                        </div>
                    </div>
                </div>

                <div class="bg-white dark:bg-surface-cardDark rounded-2xl p-6 border border-border-light dark:border-border-dark shadow-sm">
                    <h3 class="text-sm uppercase tracking-wider font-bold text-ink-light mb-4">Acciones de Voluntario</h3>
                    <div class="flex flex-col gap-3">
                        <a href="TareaServlet?accion=nueva&tipo=ALIMENTACION&idGato=<%= g.getIdGato() %>" class="w-full btn btn-primary flex items-center justify-center gap-2 py-3">
                            <span class="material-symbols-outlined">restaurant</span>
                            Registrar Alimentación
                        </a>
                        
                        <div class="grid grid-cols-2 gap-3">
                            <a href="TareaServlet?accion=nueva&tipo=SALUD&idGato=<%= g.getIdGato() %>" class="btn bg-red-50 hover:bg-red-100 text-red-700 border border-red-200 flex flex-col items-center gap-1 py-3 h-auto">
                                <span class="material-symbols-outlined">healing</span>
                                <span class="text-xs font-bold">Reportar Salud</span>
                            </a>
                            <a href="GatoServlet?accion=editar&id=<%= g.getIdGato() %>" class="btn bg-gray-50 hover:bg-gray-100 text-ink border border-gray-200 flex flex-col items-center gap-1 py-3 h-auto">
                                <span class="material-symbols-outlined">add_a_photo</span>
                                <span class="text-xs font-bold">Cambiar Foto</span>
                            </a>
                        </div>
                        
                        <a href="GatoServlet?accion=editar&id=<%= g.getIdGato() %>" class="w-full btn btn-secondary flex items-center justify-center gap-2 mt-1">
                            <span class="material-symbols-outlined text-[18px]">edit_document</span>
                            Editar Datos del Gato
                        </a>
                    </div>
                </div>
            </div>

            <div class="w-full lg:w-2/3 flex flex-col gap-6">
                
                <div class="border-b border-border-light dark:border-border-dark">
                    <nav class="flex gap-6">
                        <button class="border-b-2 border-primary text-ink dark:text-white font-bold text-sm px-1 py-3">
                            Información General
                        </button>
                        <button class="border-b-2 border-transparent text-ink-light hover:text-primary font-medium text-sm px-1 py-3 transition-colors">
                            Historial de Tareas
                        </button>
                    </nav>
                </div>

                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    
                    <div class="bg-white dark:bg-surface-cardDark rounded-2xl p-6 border border-border-light dark:border-border-dark shadow-sm">
                        <div class="flex items-center gap-2 mb-4 text-primary">
                            <span class="material-symbols-outlined">palette</span>
                            <h3 class="text-base font-bold text-ink dark:text-white">Atributos Físicos</h3>
                        </div>
                        
                        <div class="grid grid-cols-2 gap-4">
                            <div>
                                <p class="text-xs text-ink-light mb-1 uppercase font-bold">Color / Pelaje</p>
                                <p class="text-sm font-medium"><%= g.getColor() %></p>
                            </div>
                            <div>
                                <p class="text-xs text-ink-light mb-1 uppercase font-bold">Estado</p>

                                <% 
                                   // Lógica visual simple para el texto
                                   String claseTexto = "text-red-600";
                                   if(estadoSalud.equals("SANO")) claseTexto = "text-green-600";
                                   if(estadoSalud.equals("EN_TRATAMIENTO")) claseTexto = "text-amber-600";
                                %>

                                <p class="text-sm font-bold <%= claseTexto %>">
                                    <%= estadoSalud.replace("_", " ") %> </p>
                            </div>
                             <div>
                                <p class="text-xs text-ink-light mb-1 uppercase font-bold">Disponibilidad</p>
                                <p class="text-sm font-medium text-blue-600">
                                    <%= (g.getDisponibilidad() != null) ? g.getDisponibilidad() : "N/A" %>
                                </p>
                            </div>
                        </div>

                        <div class="pt-4 mt-4 border-t border-border-light dark:border-border-dark">
                            <p class="text-xs text-ink-light mb-1 uppercase font-bold">Características y Señas</p>
                            <p class="text-sm text-ink leading-relaxed">
                                <%= (g.getCaracteristicas() != null) ? g.getCaracteristicas() : "Sin descripción detallada." %>
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
                                    <%= (g.getZona() != null) ? g.getZona().getNombre() : "Sin Zona Asignada" %>
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
                                        <p class="text-xs text-ink font-mono"><%= lat %>, <%= lon %></p>
                                    </div>
                                    <span class="text-[10px] text-green-600 font-bold bg-green-50 px-2 py-1 rounded-full border border-green-100 flex items-center gap-1">
                                        <span class="material-symbols-outlined text-[12px]">my_location</span>
                                        Geolocalizado
                                    </span>
                                </div>

                                <a href="https://www.google.com/maps?q=<%= lat %>,<%= lon %>" 
                                   target="_blank"
                                   class="mt-3 w-full flex items-center justify-center gap-2 bg-white dark:bg-surface-light border border-gray-200 dark:border-gray-700 hover:bg-gray-50 dark:hover:bg-white/5 text-ink dark:text-white font-bold py-2.5 rounded-lg transition-colors shadow-sm text-sm">
                                    <img src="https://upload.wikimedia.org/wikipedia/commons/a/aa/Google_Maps_icon_%282020%29.svg" class="w-5 h-5" alt="GMaps">
                                    Ver en Google Maps
                                </a>

                                <script>
                                    document.addEventListener("DOMContentLoaded", function() {
                                        // inicializamos el mapa
                                        var map = L.map('map-gato').setView([<%= lat %>, <%= lon %>], 16);

                                        // capa OpenStreetMap
                                        L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
                                            maxZoom: 19,
                                            attribution: '&copy; OpenStreetMap'
                                        }).addTo(map);

                                        // marcador
                                        var marker = L.marker([<%= lat %>, <%= lon %>]).addTo(map);
                                        marker.bindPopup("<b><%= g.getNombre() %></b> <br> Visto por ultima vez aquí.").openPopup();
                                    });
                                </script>

                            <% } else { %>

                                <div class="h-48 bg-gray-100 dark:bg-white/5 rounded-xl flex flex-col items-center justify-center text-ink-light border-2 border-dashed border-border-light dark:border-gray-700">
                                    <span class="material-symbols-outlined text-4xl mb-2 opacity-50">wrong_location</span>
                                    <p class="text-sm font-medium">Ubicación no registrada</p>
                                    <a href="GatoServlet?accion=editar&id=<%= g.getIdGato() %>" class="text-xs text-primary font-bold hover:underline mt-1">
                                        Agregar coordenadas
                                    </a>
                                </div>

                            <% } %>

                </div>
            </div>
        </div>
    </main>
</body>
</html>