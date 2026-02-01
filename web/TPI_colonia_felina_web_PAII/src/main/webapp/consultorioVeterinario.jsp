<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.prog.tpi_colonia_felina_paii.modelo.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // gato seleccionado actualmente
    Gato gato = (Gato) request.getAttribute("gatoSeleccionado");
    
    // Lista de gatos para la barra lateral 
    List<Gato> pacientes = (List<Gato>) request.getAttribute("listaPacientes");
    if (pacientes == null) pacientes = new ArrayList<>();

    Usuario veterinario = (Usuario) session.getAttribute("usuarioLogueado");
    String nombreVet = (veterinario != null) ? veterinario.getNombre() : "Dr. Veterinario";

    // datos auxiliares del gato seleccionado
    boolean hayGato = (gato != null);
    String nombreGato = hayGato ? gato.getNombre() : "Seleccione un paciente";
    String idGato = hayGato ? String.valueOf(gato.getIdGato()) : "-";
    String fotoUrl = (hayGato && gato.getFotografia() != null) ? request.getContextPath() + gato.getFotografia() : "";
    boolean esEsterilizado = hayGato && gato.isEsterilizado();
    
    List<Estudio> listaEstudios = (List<Estudio>) request.getAttribute("historialEstudios");
%>
<!DOCTYPE html>
<html lang="es" class="light">
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>Panel Médico Veterinario - Misión Michi</title>
    
    <jsp:include page="/WEB-INF/fragmentos/cabecera-estilos.jsp" />
    
    <style>
        /* Scrollbar personalizado para la lista de pacientes */
        .custom-scrollbar::-webkit-scrollbar { width: 6px; }
        .custom-scrollbar::-webkit-scrollbar-track { background: transparent; }
        .custom-scrollbar::-webkit-scrollbar-thumb { background-color: #cbd5e1; border-radius: 20px; }
        .dark .custom-scrollbar::-webkit-scrollbar-thumb { background-color: #334155; }
    </style>
</head>

<body class="bg-surface-light dark:bg-surface-dark font-sans text-ink dark:text-white overflow-hidden h-screen flex flex-col">

<jsp:include page="/WEB-INF/fragmentos/navbar-veterinario.jsp" />

<div class="flex flex-1 overflow-hidden">
    
    <aside class="w-full max-w-[320px] bg-white dark:bg-surface-cardDark border-r border-border-light dark:border-border-dark flex flex-col z-10">
        <div class="px-4 py-4 border-b border-border-light dark:border-gray-800">
            <div class="flex items-center justify-between mb-4">
                <h2 class="text-base font-bold text-ink dark:text-white">Pacientes en Espera</h2>
                <span class="bg-blue-100 text-blue-700 text-xs font-bold px-2 py-0.5 rounded-full"><%= pacientes.size() %> Activos</span>
            </div>
            <div class="relative">
                <span class="material-symbols-outlined absolute left-3 top-2.5 text-gray-400 text-[20px]">search</span>
                <input class="block w-full rounded-lg border-0 py-2.5 pl-10 text-sm bg-gray-50 dark:bg-black/20 ring-1 ring-inset ring-gray-200 dark:ring-gray-700 focus:ring-2 focus:ring-primary" 
                       placeholder="Buscar por nombre o ID..." type="text"/>
            </div>
        </div>

        <div class="flex-1 overflow-y-auto custom-scrollbar p-2 space-y-2">
            <% for (Gato p : pacientes) { 
                boolean esElSeleccionado = (hayGato && p.getIdGato().equals(gato.getIdGato()));
                String claseItem = esElSeleccionado ? "bg-primary/5 border-primary/50" : "hover:bg-gray-50 dark:hover:bg-white/5 border-transparent";
            %>
            <a href="VeterinarioServlet?accion=consultorio&idGato=<%= p.getIdGato() %>" class="block">
                <div class="flex flex-col gap-2 p-3 border rounded-xl cursor-pointer transition-all <%= claseItem %> relative group">
                    <% if(esElSeleccionado) { %><div class="absolute left-0 top-0 bottom-0 w-1 bg-primary rounded-l-xl"></div><% } %>
                    
                    <div class="flex items-start gap-3">
                        <div class="shrink-0 relative">
                             <% if(p.getFotografia() != null) { %>
                                <div class="bg-center bg-cover rounded-lg size-12" style='background-image: url("<%= request.getContextPath() + p.getFotografia() %>");'></div>
                             <% } else { %>
                                <div class="bg-gray-200 rounded-lg size-12 flex items-center justify-center"><span class="material-symbols-outlined text-gray-400">pets</span></div>
                             <% } %>
                        </div>
                        
                        <div class="flex-1 min-w-0">
                            <div class="flex justify-between items-start">
                                <h3 class="text-sm font-bold text-ink dark:text-white truncate"><%= p.getNombre() %></h3>
                                <span class="text-xs text-ink-light"><%= p.getIdGato() %></span>
                            </div>
                            <div class="flex items-center gap-2 mt-1">
                                <span class="inline-flex items-center rounded bg-gray-100 dark:bg-gray-800 px-1.5 py-0.5 text-[10px] font-medium text-gray-600 dark:text-gray-300">
                                    <%= p.getEstadoSalud() %>
                                </span>
                            </div>
                        </div>
                    </div>
                </div>
            </a>
            <% } %>
        </div>
    </aside>


    <main class="flex-1 flex flex-col min-w-0 overflow-y-auto bg-surface-light dark:bg-surface-dark p-6">
        <% if (hayGato) { %>
        <div class="max-w-6xl mx-auto w-full flex flex-col gap-6">
            
            <div class="bg-white dark:bg-surface-cardDark rounded-2xl p-6 shadow-sm border border-border-light dark:border-border-dark flex flex-col md:flex-row gap-6 items-start">
                <div class="shrink-0 relative">
                    <div class="size-32 rounded-xl bg-center bg-cover border-4 border-white shadow-md dark:border-gray-700 bg-gray-100" 
                         style='background-image: url("<%= (fotoUrl.isEmpty()) ? "img/placeholder_cat.png" : fotoUrl %>");'>
                         <% if(fotoUrl.isEmpty()) { %> <span class="material-symbols-outlined text-4xl text-gray-300 absolute inset-0 m-auto w-fit h-fit">pets</span> <% } %>
                    </div>
                </div>

                <div class="flex-1 min-w-0 w-full">
                    <div class="flex flex-col sm:flex-row sm:items-center justify-between gap-4 mb-3">
                        <div>
                            <h1 class="text-2xl font-bold text-ink dark:text-white flex items-center gap-2">
                                <%= nombreGato %>
                                <span class="text-sm font-medium text-ink-light bg-gray-100 dark:bg-gray-800 px-2 py-1 rounded-md">#<%= idGato %></span>
                            </h1>
                        </div>
                        <div class="flex items-center gap-2">
                            <% 
                                String colorEstado = "bg-green-500";
                                if(gato.getEstadoSalud().toString().equals("ENFERMO")) colorEstado = "bg-red-500";
                                if(gato.getEstadoSalud().toString().equals("EN_TRATAMIENTO")) colorEstado = "bg-amber-500";
                            %>
                            <span class="flex h-3 w-3 rounded-full <%= colorEstado %>"></span>
                            <span class="text-sm font-bold text-ink-light"><%= gato.getEstadoSalud() %></span>
                        </div>
                    </div>

                    <div class="grid grid-cols-2 sm:grid-cols-4 gap-4 mb-4">
                        <div class="bg-gray-50 dark:bg-black/20 p-3 rounded-lg">
                            <p class="text-xs text-ink-light uppercase font-bold">Sexo</p>
                            <p class="text-sm font-medium flex items-center gap-1"><%= gato.getSexo() %></p>
                        </div>
                        <div class="bg-gray-50 dark:bg-black/20 p-3 rounded-lg">
                            <p class="text-xs text-ink-light uppercase font-bold">Ubicación</p>
                            <p class="text-sm font-medium"><%= (gato.getZona() != null) ? gato.getZona().getNombre() : "Sin asignar" %></p>
                        </div>
                        <div class="bg-gray-50 dark:bg-black/20 p-3 rounded-lg">
                            <p class="text-xs text-ink-light uppercase font-bold">Esterilizado</p>
                            <p class="text-sm font-medium <%= esEsterilizado ? "text-green-600" : "text-amber-600" %>">
                                <span class="material-symbols-outlined text-sm align-bottom"><%= esEsterilizado ? "check_circle" : "cancel" %></span> 
                                <%= esEsterilizado ? "Sí" : "No" %>
                            </p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="border-b border-border-light dark:border-border-dark">
                <nav class="-mb-px flex space-x-8" aria-label="Tabs">
                    <button onclick="switchTab('diagnostico')" id="tab-diagnostico" class="border-primary text-primary border-b-2 py-4 px-1 text-sm font-bold flex items-center gap-2">
                        <span class="material-symbols-outlined">diagnosis</span> Diagnóstico y Tratamiento 
                    </button>
                    <button onclick="switchTab('estudios')" id="tab-estudios" class="border-transparent text-ink-light hover:text-primary border-b-2 py-4 px-1 text-sm font-medium flex items-center gap-2">
                        <span class="material-symbols-outlined">science</span> Estudios Médicos 
                    </button>
                    <button onclick="switchTab('certificado')" id="tab-certificado" class="border-transparent text-ink-light hover:text-primary border-b-2 py-4 px-1 text-sm font-medium flex items-center gap-2">
                        <span class="material-symbols-outlined">verified</span> Certificado Adopción 
                    </button>
                </nav>
            </div>

            <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
                
                <div class="lg:col-span-2 space-y-6">
                    
                    <div id="view-diagnostico">
                        <div class="bg-white dark:bg-surface-cardDark rounded-2xl p-8 text-center border border-border-light dark:border-border-dark shadow-sm">

                            <div class="size-16 bg-blue-50 text-primary rounded-full flex items-center justify-center mx-auto mb-4">
                                <span class="material-symbols-outlined text-3xl">clinical_notes</span>
                            </div>

                            <h3 class="text-xl font-bold text-ink dark:text-white mb-2">Diagnóstico y Tratamientos</h3>
                            <p class="text-ink-light mb-6 max-w-md mx-auto">
                                Registre nuevos diagnósticos, cambios en el estado de salud y asigne tratamientos farmacológicos o procedimientos.
                            </p>

                            <a href="VeterinarioServlet?accion=nuevaEvolucion&idGato=<%= gato.getIdGato() %>" 
                               class="btn btn-primary px-6 py-3 rounded-xl font-bold inline-flex items-center gap-2 shadow-lg shadow-primary/20 hover:scale-105 transition-transform">
                                <span class="material-symbols-outlined">add</span>
                                Registrar Nueva Evolución
                            </a>

                        </div>

                    </div>

                    <div id="view-estudios" class="hidden">
                        <div class="flex items-center justify-between mb-6">
                            <h3 class="text-lg font-bold text-ink dark:text-white flex items-center gap-2">
                                <span class="material-symbols-outlined text-primary">science</span> Historial de Estudios
                            </h3>
                            <a href="VeterinarioServlet?accion=nuevoEstudio&idGato=<%= idGato%>" class="btn btn-primary px-4 py-2 rounded-xl text-sm font-bold flex items-center gap-2 shadow-sm">
                                <span class="material-symbols-outlined text-[18px]">cloud_upload</span> Subir Nuevo
                            </a>
                        </div>
                        <% if (listaEstudios != null && !listaEstudios.isEmpty()) { %>
                        <div class="bg-white dark:bg-surface-cardDark rounded-xl shadow-sm border border-border-light p-5 space-y-3">
                            <% for (Estudio e : listaEstudios) { %>
                            <div class="flex flex-col bg-gray-50 dark:bg-black/20 border border-gray-200 dark:border-gray-700 rounded-lg transition-colors">
                                <div class="flex items-center justify-between p-3">
                                    <div class="flex items-center gap-3 overflow-hidden">
                                        <div class="p-2 rounded-lg bg-white dark:bg-white/10 text-primary border border-gray-200 dark:border-gray-600">
                                            <% if (e.getRutaArchivo().endsWith(".pdf")) { %>
                                            <span class="material-symbols-outlined">picture_as_pdf</span>
                                            <% } else { %>
                                            <span class="material-symbols-outlined">image</span>
                                            <% }%>
                                        </div>
                                        <div class="min-w-0">
                                            <p class="text-sm font-bold text-ink dark:text-white truncate"><%= e.getTipoDeEstudio()%></p>
                                            <p class="text-xs text-ink-light">
                                                <%= e.getFecha()%> • Dr. <%= e.getVeterinario().getNombre()%>
                                            </p>
                                        </div>
                                    </div>
                                    <div class="flex items-center gap-2">
                                        <a href="DescargarArchivoServlet?ruta=<%= e.getRutaArchivo()%>" target="_blank" class="btn bg-white border border-gray-200 text-xs px-3 py-1.5 rounded-lg hover:text-primary hover:border-primary font-bold shadow-sm">
                                            Ver Archivo
                                        </a>
                                        <button type="button" onclick="toggleObservacion('<%= e.getIdEstudio()%>')" class="p-1.5 rounded-lg text-gray-400 hover:text-primary hover:bg-gray-200 dark:hover:bg-white/10 transition-colors">
                                            <span id="icon-<%= e.getIdEstudio()%>" class="material-symbols-outlined text-[20px] transition-transform duration-200">expand_more</span>
                                        </button>
                                    </div>
                                </div>

                                <div id="obs-<%= e.getIdEstudio()%>" class="hidden border-t border-gray-200 dark:border-gray-700 p-3 bg-white/50 dark:bg-white/5 rounded-b-lg">
                                    <div class="flex gap-2">
                                        <span class="material-symbols-outlined text-gray-400 text-lg">description</span>
                                        <div class="text-sm text-ink-light">
                                            <span class="font-bold text-ink dark:text-white text-xs uppercase block mb-1">Observaciones del Profesional:</span>
                                            <p class="italic">
                                                <%= (e.getObservaciones() != null && !e.getObservaciones().trim().isEmpty())
                                                                ? e.getObservaciones()
                                                                : "Sin observaciones registradas."%>
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <% } %>
                        </div>
                    </div>
                        <% } else { %>
                        <div class="text-center p-8 border-2 border-dashed border-gray-200 rounded-xl text-ink-light">
                            <p>No hay estudios cargados para este paciente.</p>
                        </div>
                        <% } %>

                    </div>
                    
                    <div id="view-certificado" class="bg-gradient-to-br from-blue-50 to-white dark:from-surface-cardDark dark:to-black/40 rounded-xl shadow-sm border border-blue-100 dark:border-blue-900/30 p-5">
                        <h3 class="text-lg font-bold text-ink dark:text-white mb-3 flex items-center gap-2">
                            <span class="material-symbols-outlined text-primary">verified_user</span>
                            Aptitud Adopción
                        </h3>
                        <p class="text-sm text-ink-light mb-4">
                            Emitir certificado si el paciente cumple con los requisitos de salud para ser adoptado.
                        </p>
                        
                        <% if(gato.getEstadoSalud().toString().equals("SANO")) { %>
                            <form action="CertificadoServlet" method="POST">
                                <input type="hidden" name="accion" value="emitirAptitud">
                                <input type="hidden" name="idGato" value="<%= gato.getIdGato() %>">
                                
                                <div class="bg-white dark:bg-black/20 p-4 rounded-lg border border-border-light dark:border-gray-700 mb-4">
                                    <div class="flex items-start gap-3">
                                        <input class="mt-1 h-4 w-4 rounded border-gray-300 text-primary focus:ring-primary" id="check-apto" type="checkbox" required/>
                                        <div class="text-sm">
                                            <label class="font-medium text-ink dark:text-white" for="check-apto">Confirmo aptitud médica</label>
                                            <p class="text-xs text-ink-light mt-1">El gato no presenta síntomas activos.</p>
                                        </div>
                                    </div>
                                </div>
                                <button type="submit" class="w-full btn btn-primary flex items-center justify-center gap-2">
                                    <span class="material-symbols-outlined">contract_edit</span>
                                    Emitir Certificado
                                </button>
                            </form>
                        <% } else { %>
                            <div class="bg-red-50 dark:bg-red-900/20 p-4 rounded-lg border border-red-200 dark:border-red-900/50 text-center">
                                <span class="material-symbols-outlined text-red-500 text-3xl mb-2">block</span>
                                <p class="text-sm font-bold text-red-700 dark:text-red-300">No apto para emisión</p>
                                <p class="text-xs text-red-600 dark:text-red-400 mt-1">El gato debe estar marcado como "SANO".</p>
                            </div>
                        <% } %>
                    </div>

                    <div class="bg-white dark:bg-surface-cardDark rounded-xl shadow-sm border border-border-light dark:border-border-dark p-5">
                        <h3 class="text-lg font-bold text-ink dark:text-white mb-4">Historial Reciente</h3>
                        <div class="space-y-4">
                            <div class="relative pl-4 border-l-2 border-gray-200 dark:border-gray-700">
                                <div class="mb-1 text-xs text-ink-light">Hoy</div>
                                <div class="text-sm font-bold text-ink dark:text-white">Consulta General</div>
                                <div class="text-xs text-ink-light">Dr. <%= nombreVet %></div>
                            </div>
                            <div class="relative pl-4 border-l-2 border-gray-200 dark:border-gray-700">
                                <div class="mb-1 text-xs text-ink-light">Hace 2 días</div>
                                <div class="text-sm font-bold text-ink dark:text-white">Vacunación Triple</div>
                                <div class="text-xs text-ink-light">Vet. Auxiliar</div>
                            </div>
                        </div>
                        <a href="#" class="block mt-4 text-center text-sm font-bold text-primary hover:underline">Ver Historial Completo</a>
                    </div>

                </div>
            </div>

        </div>
        <% } else { %>
            <div class="h-full flex flex-col items-center justify-center text-center text-ink-light">
                <span class="material-symbols-outlined text-6xl mb-4 opacity-30">pets</span>
                <h2 class="text-xl font-bold text-ink dark:text-white">Seleccione un Paciente</h2>
                <p class="max-w-md mt-2">Utilice la barra lateral para buscar un gato por nombre o ID, o escanee un código QR para acceder a su historia clínica.</p>
            </div>
        <% } %>
    </main>
</div>

<script>
    function switchTab(tabName) {
        // Ocultar todos los views
        document.getElementById('view-diagnostico').classList.add('hidden');
        document.getElementById('view-estudios').classList.add('hidden');
        
        
        //Resetear estilos de botones
        const tabs = ['diagnostico', 'estudios', 'certificado'];
        tabs.forEach(t => {
            const btn = document.getElementById('tab-' + t);
            btn.classList.remove('border-primary', 'text-primary', 'font-bold');
            btn.classList.add('border-transparent', 'text-ink-light', 'font-medium');
        });

        // Activar el actual
        const activeBtn = document.getElementById('tab-' + tabName);
        activeBtn.classList.remove('border-transparent', 'text-ink-light', 'font-medium');
        activeBtn.classList.add('border-primary', 'text-primary', 'font-bold');

        // Mostrar contenido específico
        if(tabName === 'diagnostico') {
            document.getElementById('view-diagnostico').classList.remove('hidden');
        } else if (tabName === 'estudios') {
            document.getElementById('view-estudios').classList.remove('hidden');
        } else if (tabName === 'certificado') {
             document.getElementById('view-certificado').scrollIntoView({behavior: 'smooth'});
        }
    }
    
    //esta funcion es para desplegar las observaciones de los estudios
    function toggleObservacion(idEstudio) {
        const content = document.getElementById('obs-' + idEstudio);
        const icon = document.getElementById('icon-' + idEstudio);

        if (content.classList.contains('hidden')) {
            content.classList.remove('hidden');
            icon.style.transform = 'rotate(180deg)'; // gira la flecha arriba
        } else {
            content.classList.add('hidden');
            icon.style.transform = 'rotate(0deg)'; // queda normal la flecha
        }
    }
</script>

</body>
</html>