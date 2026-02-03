<%@page import="com.prog.tpi_colonia_felina_paii.modelo.Zona"%>
<%@page import="com.prog.tpi_colonia_felina_paii.modelo.Gato"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    List<Gato> gatos = (List<Gato>) request.getAttribute("gatos");
    
    List<Zona> listaZonas = (List<Zona>) request.getAttribute("listaZonas");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Gatos - Misión Michi</title>
    <jsp:include page="/WEB-INF/fragmentos/cabecera-estilos.jsp" />
    <script src="https://unpkg.com/html5-qrcode" type="text/javascript"></script>
    
    <style>
        /* Estilo para ocultar elementos filtrados */
        .hidden-card { display: none !important; }
    </style>
</head>

<body class="bg-surface-light dark:bg-surface-dark font-sans text-ink dark:text-white pb-20">
    
    <jsp:include page="/WEB-INF/fragmentos/navbar-voluntario.jsp" />

    <main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        
        <div class="flex flex-col sm:flex-row justify-between items-end gap-4 mb-8">
            <div>
                <h1 class="heading-xl text-3xl">Nuestros Habitantes 🐱</h1>
                <p class="text-body text-ink-light">Gestión y seguimiento de la colonia.</p>
            </div>
            <div class="flex flex-wrap gap-3">
                <a href="GatoServlet?accion=crear" class="btn bg-white dark:bg-surface-cardDark border border-gray-200 dark:border-gray-700 text-ink dark:text-white hover:border-primary hover:text-primary transition-all shadow-sm gap-2">
                        <span class="material-symbols-outlined">add_circle</span>
                         Nuevo Gato
                </a>
                <button onclick="abrirEscaner()" class="btn btn-primary shadow-lg shadow-primary/30 gap-2">
                    <span class="material-symbols-outlined">qr_code_scanner</span>
                    Escanear QR
                </button>
            </div>
        </div>

        <div class="flex flex-col lg:flex-row gap-8">
            
            <aside class="w-full lg:w-72 shrink-0 space-y-6">
    
                <div class="bg-white dark:bg-surface-cardDark p-5 rounded-2xl shadow-sm border border-border-light dark:border-border-dark sticky top-24">

                    <form action="GatoServlet" method="GET">
                        <input type="hidden" name="accion" value="listar">

                        <div class="flex gap-2 mb-4">
                            <div class="relative flex-1">
                                <span class="material-symbols-outlined absolute left-3 top-2.5 text-gray-400 text-[20px]">search</span>
                                <input type="text" name="q" 
                                       value="<%= request.getParameter("q") != null ? request.getParameter("q") : ""%>"
                                       class="w-full pl-10 pr-3 py-2 rounded-xl border-gray-200 dark:border-gray-700 bg-gray-50 dark:bg-black/20 text-sm focus:ring-primary" 
                                       placeholder="Buscar Nombre o ID...">
                            </div>
                            <button type="submit" class="btn p-2 rounded-xl bg-primary/10 text-primary hover:bg-primary hover:text-white transition-colors">
                                <span class="material-symbols-outlined">search</span>
                            </button>
                        </div>

                        <div class="space-y-4">
                            <h3 class="font-bold text-sm text-gray-500 uppercase tracking-wider">Filtrar por:</h3>

                            <div>
                                <label class="text-xs font-bold text-ink mb-1 block">Estado de Salud</label>
                                <select name="salud" onchange="this.form.submit()" class="w-full rounded-lg border-gray-200 text-sm py-2">
                                    <option value="all">Todos</option>
                                    <option value="SANO" <%= "SANO".equals(request.getParameter("salud")) ? "selected" : ""%>>Sanos 🟢</option>
                                    <option value="EN_TRATAMIENTO" <%= "EN_TRATAMIENTO".equals(request.getParameter("salud")) ? "selected" : ""%>>En Tratamiento 🟠</option>
                                    <option value="ENFERMO" <%= "ENFERMO".equals(request.getParameter("salud")) ? "selected" : ""%>>Enfermos 🔴</option>
                                </select>
                            </div>

                            <div>
                                <label class="text-xs font-bold text-ink mb-1 block">Zona / Ubicación</label>
                                <select name="zona" onchange="this.form.submit()" class="w-full rounded-lg border-gray-200 text-sm py-2">
                                    <option value="all">Todas las zonas</option>
                                    <% if (listaZonas != null) {
                                            for (Zona z : listaZonas) {
                                                String selected = z.getNombre().equals(request.getParameter("zona")) ? "selected" : "";
                                    %>
                                    <option value="<%= z.getNombre()%>" <%= selected%>><%= z.getNombre()%></option>
                                    <%   }
                            }%>
                                    <option value="Sin asignar" <%= "Sin asignar".equals(request.getParameter("zona")) ? "selected" : ""%>>Sin zona asignada</option>
                                </select>
                            </div>

                            <div>
                                <label class="text-xs font-bold text-ink mb-1 block">Esterilización</label>
                                <select name="esterilizado" onchange="this.form.submit()" class="w-full rounded-lg border-gray-200 text-sm py-2">
                                    <option value="all">Indiferente</option>
                                    <option value="true" <%= "true".equals(request.getParameter("esterilizado")) ? "selected" : ""%>>Sí, esterilizado</option>
                                    <option value="false" <%= "false".equals(request.getParameter("esterilizado")) ? "selected" : ""%>>No esterilizado</option>
                                </select>
                            </div>

                            <div>
                                <label class="text-xs font-bold text-ink mb-1 block">Disponibilidad</label>
                                <select name="disponibilidad" onchange="this.form.submit()" class="w-full rounded-lg border-gray-200 text-sm py-2">
                                    <option value="all">Todos</option>
                                    <option value="DISPONIBLE" <%= "DISPONIBLE".equals(request.getParameter("disponibilidad")) ? "selected" : ""%>>Disponibles</option>
                                    <option value="NO_DISPONIBLE" <%= "NO_DISPONIBLE".equals(request.getParameter("disponibilidad")) ? "selected" : ""%>>No Disponibles</option>
                                    <option value="ADOPTADO" <%= "ADOPTADO".equals(request.getParameter("disponibilidad")) ? "selected" : ""%>>Adoptados</option>
                                </select>
                            </div>

                            <a href="GatoServlet?accion=listar" class="w-full block text-center py-2 text-sm text-gray-500 hover:text-primary underline">
                                Limpiar Filtros
                            </a>

                            <div class="pt-2 border-t border-gray-100 text-center">
                                <span class="text-xs font-bold text-primary">
                                    <%= (gatos != null) ? gatos.size() : 0%> gatos encontrados
                                </span>
                            </div>
                        </div>
                    </form>
                </div>
            </aside>

            <section class="flex-1">
                <div class="grid grid-cols-1 sm:grid-cols-2 xl:grid-cols-3 gap-6" id="gridGatos">
                    <% 
                    if (gatos != null && !gatos.isEmpty()) {
                        for (Gato g : gatos) {
                            
                            // Preparar datos para los filtros
                            String estadoStr = g.getEstadoSalud().toString();
                            String zonaStr = (g.getZona() != null) ? g.getZona().getNombre() : "Sin asignar";
                            String esterilizadoStr = g.isEsterilizado() ? "SI" : "NO";
                            String dispStr = (g.getDisponibilidad() != null) ? g.getDisponibilidad().toString() : "NO_DISPONIBLE";
                            
                            // Colores UI
                            String estadoColor = "bg-green-100 text-green-700";
                            if (estadoStr.equals("ENFERMO")) estadoColor = "bg-red-100 text-red-700";
                            else if (estadoStr.equals("EN_TRATAMIENTO")) estadoColor = "bg-amber-100 text-amber-700";
                    %>
                    
                    <div class="card-gato card p-0 overflow-hidden group hover:shadow-xl transition-all duration-300"
                         data-name="<%= g.getNombre().toLowerCase() %>"
                         data-id="<%= g.getIdGato() %>"
                         data-salud="<%= estadoStr %>"
                         data-zona="<%= zonaStr %>"
                         data-esterilizado="<%= esterilizadoStr %>"
                         data-disponibilidad="<%= dispStr %>">
                         
                        <div class="h-48 bg-gray-200 relative overflow-hidden group">
                            <% 
                                boolean tieneFoto = (g.getFotografia() != null && !g.getFotografia().isEmpty());
                                if (tieneFoto) { 
                            %>
                                 <img src="<%= request.getContextPath() + g.getFotografia() %>" class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500">
                            <% } else { %>
                                 <div class="flex flex-col items-center justify-center h-full text-gray-400 dark:text-gray-600">
                                     <span class="material-symbols-outlined text-5xl mb-1">no_photography</span>
                                     <span class="text-[10px] font-bold uppercase tracking-widest opacity-70">Sin Foto</span>
                                 </div>
                            <% } %>

                            <span class="absolute top-3 right-3 badge <%= estadoColor %> border-0 shadow-sm font-bold text-[10px]">
                                <%= g.getEstadoSalud() %>
                            </span>
                        </div>
                        
                        <div class="p-5">
                            <div class="flex justify-between items-start mb-2">
                                <h3 class="text-xl font-bold"><%= g.getNombre() %></h3>
                                <span class="text-xs font-bold text-ink-light bg-gray-100 dark:bg-white/10 px-2 py-1 rounded">
                                    #<%= g.getIdGato() %>
                                </span>
                            </div>
                            
                            <div class="space-y-2 text-sm text-ink-light mb-4">
                                <div class="flex items-center gap-2" title="Color">
                                    <span class="material-symbols-outlined text-[18px] text-gray-400">palette</span>
                                    <%= g.getColor() %>
                                </div>
                                <div class="flex items-center gap-2" title="Zona">
                                    <span class="material-symbols-outlined text-[18px] text-gray-400">location_on</span>
                                    <%= zonaStr %>
                                </div>
                                <div class="flex items-center gap-2" title="Esterilizado">
                                    <span class="material-symbols-outlined text-[18px] <%= g.isEsterilizado() ? "text-green-500" : "text-red-400" %>">
                                        <%= g.isEsterilizado() ? "check_circle" : "cancel" %>
                                    </span>
                                    <%= g.isEsterilizado() ? "Esterilizado" : "Sin operar" %>
                                </div>
                            </div>

                            <div class="flex gap-2">
                                <a href="GatoServlet?accion=verDetalle&id=<%= g.getIdGato() %>" class="btn btn-secondary flex-1 text-sm justify-center">Ficha</a>
                                <a href="TareaServlet?accion=nueva&idGato=<%= g.getIdGato() %>" class="btn border border-gray-200 hover:bg-gray-50 text-gray-600 flex-none px-3" title="Asignar Tarea">
                                    <span class="material-symbols-outlined text-[20px]">add_task</span>
                                </a>
                            </div>
                        </div>
                    </div>
                    
                    <% 
                        }
                    } else { 
                    %>
                    <div class="col-span-full py-12 text-center text-ink-light border-2 border-dashed border-gray-300 rounded-xl">
                        <span class="material-symbols-outlined text-4xl mb-2 opacity-50">pets</span>
                        <p>No hay gatos registrados aún.</p>
                    </div>
                    <% } %>
                    
                    <div id="noResults" class="col-span-full py-12 text-center hidden">
                        <span class="material-symbols-outlined text-4xl mb-2 text-gray-300">search_off</span>
                        <p class="text-gray-500">No se encontraron gatos con esos filtros.</p>
                    </div>
                </div>
            </section>
        </div>
    </main>

    <div id="modal-scanner" class="fixed inset-0 z-[60] hidden bg-black/80 backdrop-blur-sm flex items-center justify-center p-4">
        <div class="bg-surface-card dark:bg-surface-cardDark w-full max-w-md rounded-2xl overflow-hidden shadow-2xl relative">
            <div class="p-4 border-b border-gray-200 dark:border-gray-700 flex justify-between items-center bg-gray-50 dark:bg-black/20">
                <h3 class="font-bold text-lg flex items-center gap-2">
                    <span class="material-symbols-outlined text-primary">qr_code_scanner</span> Escanear
                </h3>
                <button onclick="cerrarEscaner()" class="text-gray-400 hover:text-red-500 transition-colors">
                    <span class="material-symbols-outlined">close</span>
                </button>
            </div>
            <div class="p-4 bg-black relative">
                <div id="reader" class="w-full h-[300px] bg-black"></div>
            </div>
            <div class="p-4 text-center text-sm text-gray-500">Apunta al código QR.</div>
        </div>
    </div>

    <script>
        let html5QrcodeScanner = null;

        function abrirEscaner() {
            document.getElementById('modal-scanner').classList.remove('hidden');
            
            // iniciar cámara
            html5QrcodeScanner = new Html5Qrcode("reader");
            const config = { fps: 10, qrbox: { width: 250, height: 250 } };
            
            html5QrcodeScanner.start(
                { facingMode: "environment" }, // usar la camara trasera
                config,
                onScanSuccess,
                onScanFailure
            ).catch(err => {
                console.error("Error iniciando cámara", err);
                alert("No se pudo acceder a la cámara. Revisa los permisos.");
            });
        }

        function cerrarEscaner() {
            document.getElementById('modal-scanner').classList.add('hidden');
            if (html5QrcodeScanner) {
                html5QrcodeScanner.stop().then(() => {
                    html5QrcodeScanner.clear();
                }).catch(err => console.error("Error al detener", err));
            }
        }

        function onScanSuccess(decodedText, decodedResult) {
            console.log(`Código escaneado: ${decodedText}`);
            
            // detenemos el escáner
            cerrarEscaner();

            // opción a: el QR es una URL entonces hay que redirigir directo
            if (decodedText.startsWith("http")) {
                window.location.href = decodedText;
            } 
            // opción b: el QR es solo el ID entonces hay que construir la URL
            else {
                // redirigimos al servlet para ver detalle
                window.location.href = `GatoServlet?accion=verDetalle&id=${decodedText}`;
            }
        }

        function onScanFailure(error) {
            console.warn(`Code scan error = ${error}`);
        }
    </script>

</body>
</html>