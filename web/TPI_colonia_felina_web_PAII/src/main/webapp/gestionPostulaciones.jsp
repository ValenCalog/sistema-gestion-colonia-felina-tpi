<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.util.List"%>
<%@page import="com.prog.tpi_colonia_felina_paii.modelo.Postulacion"%>
<%@page import="com.prog.tpi_colonia_felina_paii.enums.EstadoPostulacion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    List<Postulacion> lista = (List<Postulacion>) request.getAttribute("postulaciones");
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd 'de' MMMM, yyyy");
    
    // Contadores simples
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
                        "surface-light": "#f8fafc",
                        "surface-card": "#ffffff",
                        "border-light": "#e2e8f0",
                        "ink": "#1e293b",
                        "ink-light": "#64748b",
                    }
                }
            }
        }
        
        function confirmarAccion(boton, accion) {
            let titulo, texto, colorBtn, icono;

            if (accion === 'aceptar') {
                titulo = '¿Aprobar Adopción?';
                texto = 'El gato pasará a ser parte de esta familia.';
                colorBtn = '#22c55e'; // Green-500
                icono = 'question';
            } else {
                titulo = '¿Rechazar Solicitud?';
                texto = 'Esta acción no se puede deshacer.';
                colorBtn = '#ef4444'; // Red-500
                icono = 'warning';
            }

            Swal.fire({
                title: titulo,
                text: texto,
                icon: icono,
                showCancelButton: true,
                confirmButtonColor: colorBtn,
                cancelButtonColor: '#94a3b8',
                confirmButtonText: 'Sí, confirmar',
                cancelButtonText: 'Cancelar',
                background: '#ffffff',
                color: '#1e293b',
                customClass: {
                    popup: 'rounded-2xl shadow-xl border border-gray-100', // Bordes redondeados
                    confirmButton: 'rounded-xl px-4 py-2 font-bold',
                    cancelButton: 'rounded-xl px-4 py-2 font-bold'
                }
            }).then((result) => {
                if (result.isConfirmed) {
                    // Si el usuario dice SÍ, enviamos el formulario que contiene ese botón
                    boton.closest('form').submit();
                }
            });
        }
    </script>
</head>
<body class="bg-surface-light text-ink antialiased font-sans min-h-screen flex">

    <aside class="hidden lg:flex flex-col w-72 bg-surface-card border-r border-border-light sticky top-0 h-screen p-6 z-20">
        <div class="flex items-center gap-3 mb-10 text-primary">
            <div class="size-10 bg-orange-100 rounded-xl flex items-center justify-center">
                <span class="material-symbols-outlined text-2xl">pets</span>
            </div>
            <div class="flex flex-col">
                <h1 class="font-extrabold text-xl leading-none tracking-tight">Misión Michi</h1>
                <span class="text-xs font-bold text-ink-light uppercase tracking-wider mt-1">Panel Voluntario</span>
            </div>
        </div>

        <nav class="flex flex-col gap-2 flex-1">
            <a href="GatoServlet?accion=listar" class="flex items-center gap-3 px-4 py-3 text-ink-light font-medium hover:text-primary hover:bg-orange-50 rounded-xl transition-all group">
                <span class="material-symbols-outlined group-hover:scale-110 transition-transform">format_list_bulleted</span> 
                Gatos
            </a>
            <a href="TareaServlet?accion=listar" class="flex items-center gap-3 px-4 py-3 text-ink-light font-medium hover:text-primary hover:bg-orange-50 rounded-xl transition-all group">
                <span class="material-symbols-outlined group-hover:scale-110 transition-transform">assignment</span> 
                Tareas
            </a>
            <a href="#" class="flex items-center gap-3 px-4 py-3 bg-gradient-to-r from-orange-500 to-orange-600 text-white font-bold rounded-xl shadow-lg shadow-orange-500/30">
                <span class="material-symbols-outlined">volunteer_activism</span> 
                Adopciones
                <span class="ml-auto bg-white/20 text-white text-xs px-2 py-0.5 rounded-md"><%= pendientes %></span>
            </a>
        </nav>
        
        <div class="mt-auto pt-6 border-t border-border-light">
            <div class="flex items-center gap-3">
                <div class="size-10 rounded-full bg-gray-200 overflow-hidden">
                    <img src="https://ui-avatars.com/api/?name=Voluntario&background=random" alt="User">
                </div>
                <div>
                    <p class="text-sm font-bold">Voluntario</p>
                    <a href="LoginServlet?logout=true" class="text-xs text-red-500 hover:underline">Cerrar Sesión</a>
                </div>
            </div>
        </div>
    </aside>

    <main class="flex-1 p-6 md:p-10 max-w-7xl mx-auto w-full">
        
        <header class="flex flex-col md:flex-row md:items-end justify-between gap-4 mb-10">
            <div>
                <h1 class="text-3xl md:text-4xl font-black text-ink mb-2">Solicitudes de Adopción 🏠</h1>
                <p class="text-lg text-ink-light">Gestiona las familias que quieren dar amor.</p>
            </div>
            
            <div class="flex gap-4">
                <div class="bg-surface-card px-5 py-3 rounded-2xl border border-border-light shadow-sm flex flex-col items-center">
                    <span class="text-xs font-bold uppercase text-ink-light">Pendientes</span>
                    <span class="text-2xl font-black text-orange-500"><%= pendientes %></span>
                </div>
                <div class="bg-surface-card px-5 py-3 rounded-2xl border border-border-light shadow-sm flex flex-col items-center">
                    <span class="text-xs font-bold uppercase text-ink-light">Aceptadas</span>
                    <span class="text-2xl font-black text-green-500"><%= aceptadas %></span>
                </div>
            </div>
        </header>

        <div class="flex flex-col gap-6">
            
            <% if (lista == null || lista.isEmpty()) { %>
                <div class="flex flex-col items-center justify-center py-20 bg-surface-card rounded-3xl border-2 border-dashed border-border-light">
                    <div class="bg-gray-50 p-6 rounded-full mb-4">
                        <span class="material-symbols-outlined text-4xl text-gray-300">inbox</span>
                    </div>
                    <p class="text-ink font-bold text-lg">Todo al día</p>
                    <p class="text-ink-light">No hay solicitudes pendientes de revisión.</p>
                </div>
            <% } else { 
                for(Postulacion p : lista) {
                    int progreso = 10;
                    String estadoTexto = "Recibido";
                    String colorBarra = "bg-primary";
                    String bgCard = "bg-surface-card";
                    String borderCard = "border-border-light";
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
                        bgCard = "bg-green-50/50";
                        borderCard = "border-green-100";
                    }
                    else if(p.getEstado() == EstadoPostulacion.RECHAZADA) { 
                        progreso = 100; 
                        estadoTexto = "No aprobada"; 
                        colorBarra = "bg-red-500"; 
                        bgCard = "bg-gray-50 opacity-75";
                    }
            %>
            
            <article class="<%= bgCard %> border <%= borderCard %> rounded-2xl p-6 shadow-lg shadow-gray-200/50 transition-all hover:shadow-xl hover:shadow-primary/5 flex flex-col lg:flex-row gap-8 relative overflow-hidden group">
                
                <div class="absolute top-0 right-0 p-12 bg-gradient-to-br from-primary/5 to-transparent rounded-bl-full -mr-10 -mt-10 pointer-events-none"></div>

                <div class="flex lg:flex-col items-center gap-4 lg:w-48 shrink-0">
                    <div class="relative w-24 h-24 lg:w-32 lg:h-32 rounded-2xl overflow-hidden shadow-md group-hover:scale-105 transition-transform duration-500">
                        <% if(p.getGato().getFotografia() != null) { %>
                            <img src="<%= p.getGato().getFotografia() %>" class="w-full h-full object-cover">
                        <% } else { %>
                            <div class="w-full h-full bg-gray-100 flex items-center justify-center text-gray-400">
                                <span class="material-symbols-outlined text-4xl">pets</span>
                            </div>
                        <% } %>
                    </div>
                    <div class="text-left lg:text-center">
                        <p class="text-xs font-bold text-ink-light uppercase tracking-wide mb-1">Interés por</p>
                        <a href="GatoServlet?accion=verDetalle&id=<%= p.getGato().getIdGato() %>" class="text-xl font-black text-ink hover:text-primary transition-colors">
                            <%= p.getGato().getNombre() %>
                        </a>
                    </div>
                </div>

                <div class="flex-1 flex flex-col justify-center border-l border-border-light lg:pl-8 border-0 lg:border-l space-y-5">
                    
                    <div class="flex justify-between items-start">
                        <div>
                            <div class="flex items-center gap-2 mb-1">
                                <h3 class="font-bold text-xl text-ink">Familia <%= p.getFamiliaPostulante().getCodigoFamilia() %></h3>
                                <span class="px-2 py-0.5 rounded bg-gray-100 text-xs font-bold text-ink-light border border-gray-200">
                                    <%= p.getTipoAdopcion().toString().replace("_", " ") %>
                                </span>
                            </div>
                            <p class="text-sm text-ink-light">
                                Solicitado por <span class="font-bold text-ink"><%= p.getMiembroPostulante().getNombre() %></span> • <%= p.getFecha().format(formatter) %>
                            </p>
                        </div>
                    </div>

                    <div class="space-y-2">
                        <div class="flex justify-between text-xs font-bold tracking-wide">
                            <span class="text-ink"><%= estadoTexto %></span>
                            <span class="<%= colorBarra.replace("bg-", "text-") %>"><%= progreso %>%</span>
                        </div>
                        <div class="h-3 w-full rounded-full bg-gray-100 overflow-hidden">
                            <div class="h-full rounded-full <%= colorBarra %> transition-all duration-1000 relative" style="width: <%= progreso %>%;">
                                <div class="absolute inset-0 bg-white/20 animate-pulse"></div>
                            </div>
                        </div>
                    </div>

                    <div class="bg-white/60 p-4 rounded-xl border border-border-light/50">
                        <p class="text-xs font-bold text-primary uppercase mb-1 flex items-center gap-1">
                            <span class="material-symbols-outlined text-sm">format_quote</span> Mensaje de la familia
                        </p>
                        <p class="text-sm text-ink-light italic line-clamp-2 hover:line-clamp-none transition-all">
                            "<%= p.getObservacion() != null ? p.getObservacion() : "Sin mensaje adjunto." %>"
                        </p>
                    </div>
                </div>

                <% if(esPendiente) { %>
                <div class="flex lg:flex-col flex-row gap-3 lg:w-48 shrink-0 justify-center">
    
                    <a href="PostulacionServlet?accion=verDetalle&id=<%= p.getIdPostulacion() %>" 
                       class="w-full h-12 bg-white border-2 border-primary text-primary hover:bg-orange-50 rounded-xl font-bold text-sm flex items-center justify-center gap-2 transition-all">
                        <span class="material-symbols-outlined">visibility</span> Evaluar
                    </a>

                </div>
                <% } else { %>
                    <div class="flex lg:flex-col items-center justify-center lg:w-48 shrink-0 text-ink-light opacity-50">
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