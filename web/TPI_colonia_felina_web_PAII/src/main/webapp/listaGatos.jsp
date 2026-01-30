<%@page import="com.prog.tpi_colonia_felina_paii.modelo.Gato"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    List<Gato> gatos = (List<Gato>) request.getAttribute("gatos");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Gatos - Misión Michi</title>
    <jsp:include page="/WEB-INF/fragmentos/cabecera-estilos.jsp" />
    
    <script src="https://unpkg.com/html5-qrcode" type="text/javascript"></script>
</head>

<body class="bg-surface-light dark:bg-surface-dark font-sans text-ink dark:text-white pb-20">
    
    <jsp:include page="/WEB-INF/fragmentos/navbar-voluntario.jsp" />

    <main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        
        <div class="flex flex-col sm:flex-row justify-between items-end gap-4 mb-8">
            <div>
                <h1 class="heading-xl text-3xl">Nuestros Habitantes 🐱</h1>
                <p class="text-body">Listado completo de la colonia.</p>
            </div>
            
            <button onclick="abrirEscaner()" class="btn btn-primary shadow-lg shadow-primary/30 gap-2 animate-bounce">
                <span class="material-symbols-outlined">qr_code_scanner</span>
                Escanear QR
            </button>
        </div>

        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
            <% 
            if (gatos != null && !gatos.isEmpty()) {
                for (Gato g : gatos) {
                    
                    String estadoColor = "bg-green-100 text-green-700";
                    if (g.getEstadoSalud().toString().equals("ENFERMO")) estadoColor = "bg-red-100 text-red-700";
            %>
            
            <div class="card p-0 overflow-hidden group hover:shadow-xl transition-all duration-300">
                <div class="h-48 bg-gray-200 relative overflow-hidden group">
                <% 

                    boolean tieneFoto = (g.getFotografia() != null && !g.getFotografia().isEmpty());

                    if (tieneFoto) {
                        // si tiene foto, armamos la URL completa
                        String fotoUrl = request.getContextPath() + g.getFotografia();
                %>
                     <img src="<%= fotoUrl %>" 
                          alt="<%= g.getNombre() %>"
                          class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500">
                <% 
                    } else { 
                %>
                     <div class="flex flex-col items-center justify-center text-gray-400 dark:text-gray-600">
                         <span class="material-symbols-outlined text-5xl mb-1">no_photography</span>
                         <span class="text-[10px] font-bold uppercase tracking-widest opacity-70">Sin Foto</span>
                     </div>
                <% } %>

                <span class="absolute top-3 right-3 badge <%= estadoColor %> border-0 shadow-sm">
                    <%= g.getEstadoSalud() %>
                </span>
            </div>
                
                <div class="p-5">
                    <div class="flex justify-between items-start mb-2">
                        <h3 class="text-xl font-bold"><%= g.getNombre() %></h3>
                        <span class="text-xs font-bold text-ink-light bg-surface-light dark:bg-white/10 px-2 py-1 rounded">
                            #<%= g.getIdGato() %>
                        </span>
                    </div>
                    
                    <div class="space-y-2 text-sm text-ink-light mb-4">
                        <div class="flex items-center gap-2">
                            <span class="material-symbols-outlined text-[18px]">palette</span>
                            <%= g.getColor() %>
                        </div>

                        <p>Ubicación: 
                            <%= (g.getZona() != null) ? g.getZona().getNombre() : "Sin asignar" %>
                        </p>
                    </div>

                    <div class="flex gap-2">
                        <a href="GatoServlet?accion=verDetalle&id=<%= g.getIdGato() %>" class="btn btn-secondary flex-1 text-sm">Ver Ficha</a>
                        <a href="TareaServlet?accion=nueva&idGato=<%= g.getIdGato() %>" class="btn flex-1 text-sm border border-border-light hover:bg-gray-50 dark:hover:bg-white/5">
                            <span class="material-symbols-outlined text-[18px]">add_task</span>
                        </a>
                    </div>
                </div>
            </div>
            
            <% 
                }
            } else { 
            %>
            <div class="col-span-full py-12 text-center text-ink-light border-2 border-dashed border-border-light rounded-xl">
                <span class="material-symbols-outlined text-4xl mb-2 opacity-50">pets</span>
                <p>No hay gatos registrados aún.</p>
            </div>
            <% } %>
        </div>
    </main>

    <div id="modal-scanner" class="fixed inset-0 z-[60] hidden bg-black/80 backdrop-blur-sm flex items-center justify-center p-4">
        <div class="bg-surface-card dark:bg-surface-cardDark w-full max-w-md rounded-2xl overflow-hidden shadow-2xl relative">
            
            <div class="p-4 border-b border-border-light dark:border-border-dark flex justify-between items-center bg-surface-light dark:bg-black/20">
                <h3 class="font-bold text-lg flex items-center gap-2">
                    <span class="material-symbols-outlined text-primary">qr_code_scanner</span> Escanear Michi
                </h3>
                <button onclick="cerrarEscaner()" class="text-ink-light hover:text-red-500 transition-colors">
                    <span class="material-symbols-outlined">close</span>
                </button>
            </div>
            
            <div class="p-4 bg-black relative">
                <div id="reader" class="w-full h-[300px] bg-black"></div>
                <div class="absolute inset-0 pointer-events-none border-[30px] border-black/50 flex items-center justify-center">
                    <div class="w-48 h-48 border-2 border-primary/50 rounded-lg relative">
                        <div class="absolute top-0 left-0 w-4 h-4 border-l-4 border-t-4 border-primary -ml-1 -mt-1"></div>
                        <div class="absolute top-0 right-0 w-4 h-4 border-r-4 border-t-4 border-primary -mr-1 -mt-1"></div>
                        <div class="absolute bottom-0 left-0 w-4 h-4 border-l-4 border-b-4 border-primary -ml-1 -mb-1"></div>
                        <div class="absolute bottom-0 right-0 w-4 h-4 border-r-4 border-b-4 border-primary -mr-1 -mb-1"></div>
                    </div>
                </div>
            </div>

            <div class="p-4 text-center text-sm text-ink-light">
                Apunta la cámara al código QR del collar o ficha.
            </div>
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