<%@page import="com.prog.tpi_colonia_felina_paii.modelo.Usuario"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.util.List"%>
<%@page import="com.prog.tpi_colonia_felina_paii.modelo.Postulacion"%>
<%@page import="com.prog.tpi_colonia_felina_paii.enums.EstadoPostulacion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    List<Postulacion> lista = (List<Postulacion>) request.getAttribute("postulaciones");
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd 'de' MMMM, yyyy");
    
    // Contadores
    int pendientes = 0;
    int aceptadas = 0;
    if(lista != null) {
        for(Postulacion p : lista) {
            if(p.getEstado() == EstadoPostulacion.PENDIENTE) pendientes++;
            else if(p.getEstado() == EstadoPostulacion.ACEPTADA) aceptadas++;
        }
    }
%>

<!DOCTYPE html>
<html lang="es" class="scroll-smooth light">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Gestión de Adopciones - Misión Michi</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Manrope:wght@200..800&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    
    <script>
        tailwind.config = {
            darkMode: "class",
            theme: {
                fontFamily: { sans: ["Manrope", "sans-serif"] },
                extend: {
                    colors: {
                        primary: "#f97316",
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
                    }
                }
            }
        }
    </script>
</head>
<body class="bg-surface-light dark:bg-background-dark text-ink dark:text-white antialiased font-sans min-h-screen flex flex-col">

    <jsp:include page="/WEB-INF/fragmentos/navbar-voluntario.jsp" />

    <main class="flex-1 p-6 md:p-10 max-w-7xl mx-auto w-full flex flex-col justify-start">
        
        <header class="flex flex-col md:flex-row md:items-end justify-between gap-4 mb-10">
            <div>
                <h1 class="text-3xl md:text-4xl font-black text-ink dark:text-white mb-2">Solicitudes de Adopción 🏠</h1>
                <p class="text-lg text-ink-light dark:text-gray-400">Gestiona las familias que quieren dar amor.</p>
            </div>
            
            <div class="flex gap-4">
                <div class="bg-surface-card dark:bg-surface-cardDark px-5 py-3 rounded-2xl border border-border-light dark:border-border-dark shadow-sm flex flex-col items-center">
                    <span class="text-xs font-bold uppercase text-ink-light dark:text-gray-400">Pendientes</span>
                    <span class="text-2xl font-black text-orange-500"><%= pendientes %></span>
                </div>
                <div class="bg-surface-card dark:bg-surface-cardDark px-5 py-3 rounded-2xl border border-border-light dark:border-border-dark shadow-sm flex flex-col items-center">
                    <span class="text-xs font-bold uppercase text-ink-light dark:text-gray-400">Aceptadas</span>
                    <span class="text-2xl font-black text-green-500"><%= aceptadas %></span>
                </div>
            </div>
        </header>

        <div class="flex flex-col gap-6">
            
            <% if (lista == null || lista.isEmpty()) { %>
                <div class="flex flex-col items-center justify-center py-20 bg-surface-card dark:bg-surface-cardDark rounded-3xl border-2 border-dashed border-border-light dark:border-border-dark">
                    <div class="bg-gray-50 dark:bg-gray-800 p-6 rounded-full mb-4">
                        <span class="material-symbols-outlined text-4xl text-gray-300">inbox</span>
                    </div>
                    <p class="text-ink dark:text-white font-bold text-lg">Todo al día</p>
                    <p class="text-ink-light dark:text-gray-400">No hay solicitudes pendientes de revisión.</p>
                </div>
            <% } else { 
                for(Postulacion p : lista) {
                    int progreso = 10;
                    String estadoTexto = "Recibido";
                    String colorBarra = "bg-primary";
                    String bgCard = "bg-surface-card dark:bg-surface-cardDark";
                    String borderCard = "border-border-light dark:border-border-dark";
                    boolean esPendiente = false;

                    if(p.getEstado() == EstadoPostulacion.PENDIENTE) { 
                        progreso = 35; 
                        estadoTexto = "Pendiente de Revisión"; 
                        esPendiente = true;
                    }
                    else if(p.getEstado() == EstadoPostulacion.ACEPTADA) { 
                        progreso = 100; 
                        estadoTexto = "¡Aprobada!"; 
                        colorBarra = "bg-green-500"; 
                        bgCard = "bg-green-50/50 dark:bg-green-900/20";
                        borderCard = "border-green-100 dark:border-green-800";
                    }
                    else if(p.getEstado() == EstadoPostulacion.RECHAZADA) { 
                        progreso = 100; 
                        estadoTexto = "No aprobada"; 
                        colorBarra = "bg-red-500"; 
                        bgCard = "bg-gray-50 dark:bg-gray-900 opacity-75";
                    }
            %>
            
            <article class="<%= bgCard %> border <%= borderCard %> rounded-2xl p-6 shadow-lg shadow-gray-200/50 dark:shadow-none transition-all hover:shadow-xl hover:shadow-primary/5 flex flex-col lg:flex-row gap-8 relative overflow-hidden group">
                
                <div class="absolute top-0 right-0 p-12 bg-gradient-to-br from-primary/5 to-transparent rounded-bl-full -mr-10 -mt-10 pointer-events-none"></div>

                <div class="flex lg:flex-col items-center gap-4 lg:w-48 shrink-0">
                    <div class="relative w-24 h-24 lg:w-32 lg:h-32 rounded-2xl overflow-hidden shadow-md group-hover:scale-105 transition-transform duration-500">
                        <% if(p.getGato().getFotografia() != null) { %>
                            <img src="<%= p.getGato().getFotografia() %>" class="w-full h-full object-cover">
                        <% } else { %>
                            <div class="w-full h-full bg-gray-100 dark:bg-gray-800 flex items-center justify-center text-gray-400">
                                <span class="material-symbols-outlined text-4xl">pets</span>
                            </div>
                        <% } %>
                    </div>
                    <div class="text-left lg:text-center">
                        <p class="text-xs font-bold text-ink-light dark:text-gray-400 uppercase tracking-wide mb-1">Interés por</p>
                        <a href="GatoServlet?accion=verDetalle&id=<%= p.getGato().getIdGato() %>" class="text-xl font-black text-ink dark:text-white hover:text-primary transition-colors">
                            <%= p.getGato().getNombre() %>
                        </a>
                    </div>
                </div>

                <div class="flex-1 flex flex-col justify-center border-l border-border-light dark:border-border-dark lg:pl-8 border-0 lg:border-l space-y-5">
                    
                    <div class="flex justify-between items-start">
                        <div>
                            <div class="flex items-center gap-2 mb-1">
                                <h3 class="font-bold text-xl text-ink dark:text-white">Familia <%= p.getFamiliaPostulante().getCodigoFamilia() %></h3>
                                <span class="px-2 py-0.5 rounded bg-gray-100 dark:bg-gray-700 text-xs font-bold text-ink-light dark:text-gray-300 border border-gray-200 dark:border-gray-600">
                                    <%= p.getTipoAdopcion().toString().replace("_", " ") %>
                                </span>
                            </div>
                            <p class="text-sm text-ink-light dark:text-gray-400">
                                Solicitado por <span class="font-bold text-ink dark:text-white"><%= p.getMiembroPostulante().getNombre() %></span> • <%= p.getFecha().format(formatter) %>
                            </p>
                        </div>
                    </div>

                    <div class="space-y-2">
                        <div class="flex justify-between text-xs font-bold tracking-wide">
                            <span class="text-ink dark:text-white"><%= estadoTexto %></span>
                            <span class="<%= colorBarra.replace("bg-", "text-") %>"><%= progreso %>%</span>
                        </div>
                        <div class="h-3 w-full rounded-full bg-gray-100 dark:bg-gray-700 overflow-hidden">
                            <div class="h-full rounded-full <%= colorBarra %> transition-all duration-1000 relative" style="width: <%= progreso %>%;">
                                <div class="absolute inset-0 bg-white/20 animate-pulse"></div>
                            </div>
                        </div>
                    </div>

                    <div class="bg-white/60 dark:bg-black/20 p-4 rounded-xl border border-border-light/50 dark:border-border-dark/50">
                        <p class="text-xs font-bold text-primary uppercase mb-1 flex items-center gap-1">
                            <span class="material-symbols-outlined text-sm">format_quote</span> Mensaje de la familia
                        </p>
                        <p class="text-sm text-ink-light dark:text-gray-300 italic line-clamp-2 hover:line-clamp-none transition-all">
                            "<%= p.getObservacion() != null ? p.getObservacion() : "Sin mensaje adjunto." %>"
                        </p>
                    </div>
                </div>

                <% if(esPendiente) { %>
                <div class="flex lg:flex-col flex-row gap-3 lg:w-48 shrink-0 justify-center">
                    <a href="PostulacionServlet?accion=verDetalle&id=<%= p.getIdPostulacion() %>" 
                       class="w-full h-12 bg-white dark:bg-surface-cardDark border-2 border-primary text-primary hover:bg-orange-50 dark:hover:bg-primary/10 rounded-xl font-bold text-sm flex items-center justify-center gap-2 transition-all">
                        <span class="material-symbols-outlined">visibility</span> Evaluar
                    </a>
                </div>
                <% } else { %>
                    <div class="flex lg:flex-col items-center justify-center lg:w-48 shrink-0 text-ink-light dark:text-gray-500 opacity-50">
                         <span class="material-symbols-outlined text-4xl mb-2">lock</span>
                         <span class="text-xs font-bold uppercase">Cerrada</span>
                    </div>
                <% } %>

            </article>
            <%  } 
               } %>
            
        </div>
    </main>

</body>
</html>