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
    String estadoSalud = (hayGato && gato.getEstadoSalud() != null) ? gato.getEstadoSalud().toString() : "DESCONOCIDO";
    
    List<Estudio> listaEstudios = (List<Estudio>) request.getAttribute("historialEstudios");
    CertificadoAptitud certificado = (CertificadoAptitud) request.getAttribute("certificado");
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
        
        @media print {
            body * {
                visibility: hidden; 
            }

            #certificado-impresion, #certificado-impresion * {
                visibility: visible;
            }

            #certificado-impresion {
                position: absolute;
                left: 0;
                top: 0;
                width: 100%;
                margin: 0;
                padding: 20px;
                border: 2px solid black !important;
                background: white !important;
                color: black !important;
                box-shadow: none !important;
            }

            .no-print, .btn { 
                display: none !important; 
            }
            
            * {
                -webkit-print-color-adjust: exact !important;
                print-color-adjust: exact !important;
            }
        }
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

            <div class="max-w-4xl mx-auto w-full flex flex-col gap-6">
                <div class="w-full space-y-6">
                    
                    <% 
                        List<Diagnostico> listaDiagnosticos = (List<Diagnostico>) request.getAttribute("listaDiagnosticos"); 
                    %>

                    <div id="view-diagnostico">

                        <div class="flex flex-col md:flex-row items-center justify-between gap-4 mb-8">
                            <div>
                                <h3 class="text-xl font-bold text-ink dark:text-white flex items-center gap-2">
                                    <span class="material-symbols-outlined text-primary">clinical_notes</span>
                                    Historia Clínica
                                </h3>
                                <p class="text-sm text-ink-light">Evolución cronológica del paciente.</p>
                            </div>

                            <a href="VeterinarioServlet?accion=nuevaEvolucion&idGato=<%= idGato %>" 
                               class="btn btn-primary px-6 py-2.5 rounded-xl font-bold inline-flex items-center gap-2 shadow-lg shadow-primary/20 hover:scale-105 transition-transform no-print">
                                <span class="material-symbols-outlined">add</span> Nueva Evolución
                            </a>
                        </div>

                        <div class="space-y-8 relative before:absolute before:inset-0 before:ml-5 before:-translate-x-px md:before:mx-auto md:before:translate-x-0 before:h-full before:w-0.5 before:bg-gradient-to-b before:from-transparent before:via-gray-300 before:to-transparent">

                            <% if (listaDiagnosticos != null && !listaDiagnosticos.isEmpty()) { 
                                 for (Diagnostico d : listaDiagnosticos) { 
                            %>
                                <div class="relative flex items-center justify-between md:justify-normal md:odd:flex-row-reverse group is-active">

                                    <div class="flex items-center justify-center w-10 h-10 rounded-full border-4 border-white dark:border-surface-dark bg-blue-100 text-primary shadow shrink-0 md:order-1 md:group-odd:-translate-x-1/2 md:group-even:translate-x-1/2 z-10">
                                        <span class="material-symbols-outlined text-sm">event</span>
                                    </div>

                                    <div class="w-[calc(100%-4rem)] md:w-[calc(50%-2.5rem)] bg-white dark:bg-surface-cardDark rounded-2xl border border-gray-200 dark:border-gray-700 shadow-sm p-5 hover:shadow-md transition-shadow">

                                        <div class="flex justify-between items-start mb-3 pb-3 border-b border-gray-100 dark:border-gray-700">
                                            <div>
                                                <span class="text-xs font-bold text-gray-400 uppercase"><%= d.getFecha() %></span>
                                                <div class="flex items-center gap-1 mt-1">
                                                    <span class="material-symbols-outlined text-sm text-primary">person</span>
                                                    <span class="text-xs font-bold text-ink">Dr. <%= (d.getVeterinario() != null) ? d.getVeterinario().getNombre() : "Veterinario" %></span>
                                                </div>
                                            </div>
                                            <% if(d.getEstadoClinico() != null) { %>
                                                <span class="px-2 py-1 rounded-lg text-[10px] font-bold uppercase bg-gray-100 text-gray-600">
                                                    <%= d.getEstadoClinico() %>
                                                </span>
                                            <% } %>
                                        </div>

                                        <div class="mb-4">
                                            <h4 class="text-md font-bold text-ink dark:text-white mb-1">Diagnóstico</h4>
                                            <p class="text-sm text-gray-600 dark:text-gray-300">
                                                <%= (d.getDescDetallada() != null) ? d.getDescDetallada() : "Sin descripción." %>
                                            </p>
                                            <% if(d.getObservaciones() != null && !d.getObservaciones().isEmpty()) { %>
                                                <p class="text-xs text-gray-400 italic mt-2">"<%= d.getObservaciones() %>"</p>
                                            <% } %>
                                        </div>

                                        <% 
                                            List<Tratamiento> listaTratamientos = d.getTratamientos(); // Esto funciona si pusiste EAGER
                                            if (listaTratamientos != null && !listaTratamientos.isEmpty()) { 
                                        %>
                                            <div class="bg-blue-50/50 dark:bg-blue-900/10 rounded-xl p-3 border border-blue-100 dark:border-blue-800">
                                                <p class="text-xs font-bold text-blue-600 dark:text-blue-400 uppercase mb-2 flex items-center gap-1">
                                                    <span class="material-symbols-outlined text-sm">prescriptions</span> Tratamientos Aplicados
                                                </p>
                                                <ul class="space-y-2">
                                                    <% for(Tratamiento t : listaTratamientos) { %>
                                                        <li class="text-sm bg-white dark:bg-black/20 p-2 rounded-lg border border-blue-100/50 shadow-sm">
                                                            <div class="font-bold text-ink dark:text-white"><%= (t.getMedicacion() != null) ? t.getMedicacion() : "Procedimiento" %></div>
                                                            <% if(t.getDescripcion() != null) { %>
                                                                <div class="text-xs text-gray-500"><%= t.getDescripcion() %></div>
                                                            <% } %>
                                                        </li>
                                                    <% } %>
                                                </ul>
                                            </div>
                                        <% } %>

                                    </div>
                                </div>
                            <% 
                                 } 
                               } else { 
                            %>
                                <div class="flex flex-col items-center justify-center py-12 text-center bg-gray-50 dark:bg-black/20 rounded-2xl border-2 border-dashed border-gray-200">
                                    <div class="size-16 bg-gray-200 dark:bg-white/10 rounded-full flex items-center justify-center mb-4 text-gray-400">
                                        <span class="material-symbols-outlined text-3xl">history_edu</span>
                                    </div>
                                    <h3 class="text-lg font-bold text-ink dark:text-white">Sin historial registrado</h3>
                                    <p class="text-sm text-ink-light max-w-xs mt-1 mb-4">Este paciente aún no tiene diagnósticos cargados.</p>
                                </div>
                            <% } %>

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
                    
                    <div id="view-certificado" class="hidden">
                        <% if (certificado != null) {%>
                        <div class="flex flex-col items-center justify-center text-center p-4">

                            <div id="certificado-impresion" class="bg-white border border-gray-200 rounded-3xl p-10 max-w-3xl w-full shadow-xl relative overflow-hidden text-left">

                                <span class="material-symbols-outlined absolute -right-10 -bottom-10 text-[15rem] text-gray-50 opacity-50 pointer-events-none select-none">pets</span>

                                <div class="absolute top-6 right-6 bg-green-100 text-green-700 text-xs font-bold px-3 py-1.5 rounded-full border border-green-200 uppercase tracking-wide no-print flex items-center gap-1">
                                    <span class="material-symbols-outlined text-sm">check_circle</span> Vigente
                                </div>

                                <div class="text-center mb-8 relative z-10">
                                    <div class="inline-flex items-center justify-center p-3 bg-primary/10 rounded-2xl mb-4 text-primary">
                                        <span class="material-symbols-outlined text-4xl">verified_user</span>
                                    </div>
                                    <h2 class="text-3xl font-black text-ink dark:text-black tracking-tight mb-1">Certificado de Aptitud</h2>
                                    <p class="text-sm font-medium text-gray-400 uppercase tracking-widest">Misión Michi</p>
                                </div>

                                <div class="space-y-8 relative z-10 font-sans text-ink">
                                    <p class="text-lg text-gray-600 text-center max-w-2xl mx-auto leading-relaxed">
                                        Por medio de la presente, se certifica que el paciente felino detallado a continuación ha sido evaluado clínicamente y cumple con los <strong class="text-primary">requisitos de salud</strong> para su adopción responsable.
                                    </p>

                                    <div class="bg-gray-50 border border-gray-100 rounded-2xl p-6 grid grid-cols-2 gap-y-6 gap-x-4 shadow-inner">
                                        <div>
                                            <span class="block text-[10px] font-bold text-gray-400 uppercase tracking-wider mb-1">Paciente</span>
                                            <span class="text-xl font-black text-ink capitalize"><%= nombreGato%></span>
                                        </div>
                                        <div>
                                            <span class="block text-[10px] font-bold text-gray-400 uppercase tracking-wider mb-1">ID Registro</span>
                                            <span class="text-xl font-bold text-ink">#<%= idGato%></span>
                                        </div>
                                        <div>
                                            <span class="block text-[10px] font-bold text-gray-400 uppercase tracking-wider mb-1">Sexo</span>
                                            <span class="text-base font-medium text-gray-700 bg-white px-3 py-1 rounded-lg border border-gray-100 inline-block">
                                                <%= gato.getSexo()%>
                                            </span>
                                        </div>
                                        <div>
                                            <span class="block text-[10px] font-bold text-gray-400 uppercase tracking-wider mb-1">Esterilizado</span>
                                            <span class="text-base font-medium text-gray-700 bg-white px-3 py-1 rounded-lg border border-gray-100 inline-block">
                                                <%= esEsterilizado ? "SÍ" : "NO"%>
                                            </span>
                                        </div>
                                    </div>

                                    <div class="flex items-center justify-center gap-3 py-2">
                                        <span class="text-gray-500 font-medium">Condición Actual:</span>
                                        <span class="bg-green-100 text-green-700 px-4 py-1 rounded-lg font-black text-lg border border-green-200">
                                            SANO / APTO
                                        </span>
                                    </div>

                                    <div class="border-t border-gray-100 pt-6">
                                        <strong class="text-xs font-bold text-gray-400 uppercase tracking-wider block mb-2">Observaciones / Recomendaciones</strong>
                                        <div class="bg-blue-50/50 rounded-xl p-4 border border-blue-100 text-gray-700 text-sm italic relative">
                                            <span class="material-symbols-outlined absolute top-4 left-3 text-blue-200 text-xl">format_quote</span>
                                            <p class="pl-6">
                                                <%= (certificado.getObservaciones() != null && !certificado.getObservaciones().isEmpty()) ? certificado.getObservaciones() : "Sin observaciones particulares."%>
                                            </p>
                                        </div>
                                    </div>
                                </div>

                                <div class="flex justify-between items-end mt-12 pt-6 border-t border-gray-200 relative z-10">
                                    <div>
                                        <p class="text-[10px] font-bold text-gray-400 uppercase mb-1">Fecha de Emisión</p>
                                        <p class="text-base font-bold text-ink"><%= certificado.getFechaEmision()%></p>
                                    </div>
                                    <div class="text-right">
                                        <div class="h-8"></div> <p class="text-base font-bold text-ink border-t-2 border-gray-300 pt-2 px-2 inline-block">Dr. <%= certificado.getVeterinario().getNombre() + " " + certificado.getVeterinario().getNombre()%></p>
                                        <p class="text-[10px] font-bold text-gray-400 uppercase mt-1">Médico Veterinario</p>
                                    </div>
                                </div>
                            </div>

                            <button onclick="window.print()" class="mt-8 btn bg-primary text-white hover:bg-blue-700 font-bold py-3 px-8 rounded-xl flex items-center justify-center gap-2 shadow-lg shadow-primary/30 transition-all hover:scale-105 no-print">
                                <span class="material-symbols-outlined">print</span> Imprimir Copia Oficial
                            </button>
                        </div>

                        <% } else if ("SANO".equals(estadoSalud)) {%>
                        <div class="bg-white dark:bg-surface-cardDark rounded-2xl p-8 text-center border border-border-light shadow-sm">
                            <div class="size-16 bg-blue-50 text-primary rounded-full flex items-center justify-center mx-auto mb-4">
                                <span class="material-symbols-outlined text-3xl">verified_user</span>
                            </div>
                            <h3 class="text-xl font-bold text-ink dark:text-white mb-2">Paciente Apto para Adopción</h3>
                            <p class="text-ink-light mb-6 max-w-md mx-auto">El paciente cumple con los requisitos clínicos. Puede emitir el certificado legal.</p>
                            <a href="VeterinarioServlet?accion=emitirCertificado&idGato=<%= idGato%>" class="btn btn-primary px-8 py-3 rounded-xl font-bold text-lg shadow-lg hover:scale-105 transition-transform flex items-center justify-center gap-2">
                                <span class="material-symbols-outlined">edit_document</span> Iniciar Trámite
                            </a>
                        </div>

                        <% } else {%>
                        <div class="bg-white dark:bg-surface-cardDark rounded-2xl p-8 text-center border-2 border-red-100">
                            <div class="size-16 bg-red-50 text-red-500 rounded-full flex items-center justify-center mx-auto mb-4 animate-pulse">
                                <span class="material-symbols-outlined text-3xl">block</span>
                            </div>
                            <h3 class="text-xl font-bold text-red-600 mb-2">Emisión Bloqueada</h3>
                            <p class="text-ink-light mb-6">El paciente figura como <strong class="text-red-500 uppercase"><%= estadoSalud%></strong>. Debe estar SANO.</p>
                            <button onclick="switchTab('diagnostico')" class="text-primary font-bold hover:underline flex items-center justify-center gap-1 mx-auto">
                                Ir a Diagnóstico <span class="material-symbols-outlined text-sm">arrow_forward</span>
                            </button>
                        </div>
                        <% }%>
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
        const views = ['view-diagnostico', 'view-estudios', 'view-certificado'];
        const tabs = ['tab-diagnostico', 'tab-estudios', 'tab-certificado'];

        views.forEach(id => {
            const el = document.getElementById(id);
            if(el) el.classList.add('hidden'); 
        });

        tabs.forEach(id => {
            const btn = document.getElementById(id);
            if(btn) {
                btn.classList.remove('border-primary', 'text-primary', 'font-bold');
                btn.classList.add('border-transparent', 'text-ink-light', 'font-medium');
            }
        });

        const activeView = document.getElementById('view-' + tabName);
        const activeBtn = document.getElementById('tab-' + tabName);

        if (activeView) {
            activeView.classList.remove('hidden');
            
            if(tabName === 'certificado') {
                activeView.scrollIntoView({behavior: 'smooth'});
            }
        }

        if (activeBtn) {
            activeBtn.classList.remove('border-transparent', 'text-ink-light', 'font-medium');
            activeBtn.classList.add('border-primary', 'text-primary', 'font-bold');
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