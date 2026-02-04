<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="com.prog.tpi_colonia_felina_paii.modelo.Tarea"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    List<Tarea> tareas = (List<Tarea>) request.getAttribute("misTareas");
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
    
    int totalTareas = (tareas != null) ? tareas.size() : 0;
    
    long cantAlim = 0;
    long cantVet = 0;
    long cantCastra = 0;
    long cantTrans = 0;

    if (tareas != null) {
        cantAlim = tareas.stream().filter(t -> "ALIMENTACION".equals(t.getTipoDeTarea().toString())).count();
        cantVet = tareas.stream().filter(t -> "CONTROL_VETERINARIO".equals(t.getTipoDeTarea().toString())).count();
        cantCastra = tareas.stream().filter(t -> "CAPTURA_CASTRACION".equals(t.getTipoDeTarea().toString())).count();
        cantTrans = tareas.stream().filter(t -> "TRANSPORTE_HOGAR_TRANSITORIO".equals(t.getTipoDeTarea().toString())).count();
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Mis Contribuciones - Misión Michi</title>
    <jsp:include page="/WEB-INF/fragmentos/cabecera-estilos.jsp" />
</head>

<body class="bg-surface-light dark:bg-surface-dark font-sans text-ink dark:text-white pb-20">
    
    <jsp:include page="/WEB-INF/fragmentos/navbar-voluntario.jsp" />

    <main class="max-w-4xl mx-auto px-4 sm:px-6 py-8">
        
        <div class="flex flex-col sm:flex-row items-center justify-between gap-4 mb-8">
            <div class="text-center sm:text-left">
                <h1 class="text-3xl font-black text-ink dark:text-white mb-1">Mis Contribuciones 🧡</h1>
                <p class="text-gray-500 text-sm mt-1">
                    Has realizado un total de <strong class="text-primary"><%= totalTareas %></strong> tareas. ¡Gracias!
                </p>
            </div>
            <a href="TareaServlet?accion=nueva" class="btn btn-primary px-5 py-2.5 rounded-xl shadow-lg shadow-primary/30 flex items-center gap-2 transition-transform hover:scale-105 font-bold text-white shrink-0">
                <span class="material-symbols-outlined">add_task</span>
                Registrar Nueva Tarea
            </a>
        </div>

        <% if (tareas != null && !tareas.isEmpty()) { %>
        
            <div class="grid grid-cols-2 md:grid-cols-4 gap-4 mb-8">
                
                <div class="bg-white dark:bg-surface-cardDark p-4 rounded-xl border border-gray-100 dark:border-gray-700 shadow-sm flex flex-col items-center text-center gap-2">
                    <div class="size-10 rounded-full bg-orange-50 text-orange-600 flex items-center justify-center">
                        <span class="material-symbols-outlined">restaurant</span>
                    </div>
                    <div>
                        <p class="text-2xl font-black text-ink dark:text-white"><%= cantAlim %></p>
                        <p class="text-[10px] text-gray-400 uppercase font-bold">Alimentación</p>
                    </div>
                </div>

                <div class="bg-white dark:bg-surface-cardDark p-4 rounded-xl border border-gray-100 dark:border-gray-700 shadow-sm flex flex-col items-center text-center gap-2">
                    <div class="size-10 rounded-full bg-red-50 text-red-600 flex items-center justify-center">
                        <span class="material-symbols-outlined">medical_services</span>
                    </div>
                    <div>
                        <p class="text-2xl font-black text-ink dark:text-white"><%= cantVet %></p>
                        <p class="text-[10px] text-gray-400 uppercase font-bold">Controles Vet.</p>
                    </div>
                </div>

                <div class="bg-white dark:bg-surface-cardDark p-4 rounded-xl border border-gray-100 dark:border-gray-700 shadow-sm flex flex-col items-center text-center gap-2">
                    <div class="size-10 rounded-full bg-purple-50 text-purple-600 flex items-center justify-center">
                        <span class="material-symbols-outlined">content_cut</span>
                    </div>
                    <div>
                        <p class="text-2xl font-black text-ink dark:text-white"><%= cantCastra %></p>
                        <p class="text-[10px] text-gray-400 uppercase font-bold">Castraciones</p>
                    </div>
                </div>

                <div class="bg-white dark:bg-surface-cardDark p-4 rounded-xl border border-gray-100 dark:border-gray-700 shadow-sm flex flex-col items-center text-center gap-2">
                    <div class="size-10 rounded-full bg-blue-50 text-blue-600 flex items-center justify-center">
                        <span class="material-symbols-outlined">directions_car</span>
                    </div>
                    <div>
                        <p class="text-2xl font-black text-ink dark:text-white"><%= cantTrans %></p>
                        <p class="text-[10px] text-gray-400 uppercase font-bold">Traslados</p>
                    </div>
                </div>
            </div>
                        
            <div class="bg-white dark:bg-surface-cardDark rounded-2xl shadow-sm border border-gray-200 dark:border-gray-700 overflow-hidden">
                <div class="overflow-x-auto">
                    <table class="w-full text-left border-collapse">
                        <thead>
                            <tr class="bg-gray-50 dark:bg-black/20 text-xs uppercase text-gray-400 border-b border-gray-100 dark:border-gray-700">
                                <th class="p-4 font-bold whitespace-nowrap">Fecha</th>
                                <th class="p-4 font-bold">Paciente (Ver Ficha)</th> <th class="p-4 font-bold">Tipo de Tarea</th>
                                <th class="p-4 font-bold w-1/2">Observaciones</th> </tr>
                        </thead>
                        <tbody class="divide-y divide-gray-100 dark:divide-gray-700 text-sm">
                            
                            <% for (Tarea t : tareas) { 
                                String tipo = t.getTipoDeTarea().toString();
                                String badgeColor = "bg-gray-100 text-gray-600";
                                String icono = "task";
                                String textoAmigable = tipo;

                                switch(tipo) {
                                    case "ALIMENTACION":
                                        badgeColor = "bg-orange-50 text-orange-600 border border-orange-100";
                                        icono = "restaurant";
                                        textoAmigable = "Alimentación";
                                        break;
                                    case "CONTROL_VETERINARIO":
                                        badgeColor = "bg-red-50 text-red-600 border border-red-100";
                                        icono = "medical_services";
                                        textoAmigable = "Control Veterinario";
                                        break;
                                    case "CAPTURA_CASTRACION":
                                        badgeColor = "bg-purple-50 text-purple-600 border border-purple-100";
                                        icono = "content_cut";
                                        textoAmigable = "Captura para castración";
                                        break;
                                    case "TRANSPORTE_HOGAR_TRANSITORIO":
                                        badgeColor = "bg-blue-50 text-blue-600 border border-blue-100";
                                        icono = "directions_car";
                                        textoAmigable = "Transporte / Hogar";
                                        break;
                                }
                            %>
                            <tr class="hover:bg-gray-50 dark:hover:bg-white/5 transition-colors group">
                                
                                <td class="p-4 whitespace-nowrap font-mono text-gray-500 align-top pt-5">
                                    <%= t.getFecha().format(formatter) %>
                                </td>

                                <td class="p-3 align-top">
                                    <a href="GatoServlet?accion=verDetalle&id=<%= t.getGato().getIdGato() %>" 
                                       class="flex items-center gap-3 p-2 -ml-2 rounded-xl hover:bg-white dark:hover:bg-white/10 hover:shadow-sm border border-transparent hover:border-gray-200 dark:hover:border-gray-600 transition-all group-hover:border-gray-200"
                                       title="Ir al perfil de <%= t.getGato().getNombre() %>">
                                        
                                        <div class="size-10 rounded-full bg-gray-200 overflow-hidden shrink-0 border border-gray-100">
                                            <% if(t.getGato().getFotografia() != null) { %>
                                                <img src="<%= request.getContextPath() + t.getGato().getFotografia() %>" class="w-full h-full object-cover">
                                            <% } else { %>
                                                <div class="w-full h-full flex items-center justify-center text-gray-400">
                                                    <span class="material-symbols-outlined text-[18px]">pets</span>
                                                </div>
                                            <% } %>
                                        </div>
                                        
                                        <div class="flex flex-col">
                                            <span class="font-black text-ink dark:text-white text-base group-hover:text-primary transition-colors">
                                                <%= t.getGato().getNombre() %>
                                            </span>
                                            <span class="text-[10px] text-gray-400 uppercase font-bold flex items-center gap-1">
                                                Ver Ficha <span class="material-symbols-outlined text-[10px]">arrow_outward</span>
                                            </span>
                                        </div>
                                    </a>
                                </td>

                                <td class="p-4 align-top pt-5">
                                    <span class="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-lg border text-xs font-bold uppercase tracking-wide <%= badgeColor %>">
                                        <span class="material-symbols-outlined text-[14px]"><%= icono %></span>
                                        <%= t.getTipoDeTarea().getDescripcion() %>
                                    </span>
                                </td>

                                <td class="p-4 text-gray-500 dark:text-gray-400 italic align-top pt-5">
                                    <% if (t.getObservaciones() != null && !t.getObservaciones().isEmpty()) { %>
                                        <div class="line-clamp-2" title="<%= t.getObservaciones() %>">
                                            "<%= t.getObservaciones() %>"
                                        </div>
                                    <% } else { %>
                                        <span class="opacity-30">-</span>
                                    <% } %>
                                    
                                    <% if (t.getUbicacion() != null && !t.getUbicacion().isEmpty()) { %>
                                        <div class="flex items-center gap-1 text-[10px] text-gray-400 mt-1 not-italic font-bold">
                                            <span class="material-symbols-outlined text-[12px]">pin_drop</span>
                                            <%= t.getUbicacion() %>
                                        </div>
                                    <% } %>
                                </td>

                            </tr>
                            <% } %>

                        </tbody>
                    </table>
                </div>
            </div>

        <% } else { %>

            <div class="flex flex-col items-center justify-center py-24 text-center">
                <div class="bg-white dark:bg-surface-cardDark p-8 rounded-full shadow-lg mb-6 animate-pulse">
                    <img src="https://cdn-icons-png.flaticon.com/512/7486/7486744.png" class="w-24 opacity-80" alt="Gato dormido">
                </div>
                <h2 class="text-2xl font-black text-ink dark:text-white">Tu historial está vacío</h2>
                <p class="text-gray-500 max-w-md mt-2 mb-8">Parece que todavía no has registrado ninguna actividad. ¡Los michis esperan tu ayuda!</p>
                <a href="GatoServlet?accion=listar" class="btn btn-primary px-8 py-3 rounded-xl font-bold shadow-xl shadow-primary/20 hover:scale-105 transition-transform">
                    Comenzar ahora
                </a>
            </div>

        <% } %>

    </main>
</body>
</html>