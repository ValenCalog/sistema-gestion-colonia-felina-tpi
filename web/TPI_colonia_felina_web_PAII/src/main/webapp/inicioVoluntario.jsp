<%@page import="com.prog.tpi_colonia_felina_paii.modelo.Tarea"%>
<%@page import="com.prog.tpi_colonia_felina_paii.modelo.Postulacion"%>
<%@page import="com.prog.tpi_colonia_felina_paii.modelo.Gato"%>
<%@page import="com.prog.tpi_colonia_felina_paii.modelo.Usuario"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // recuperar listas del Servlet
    List<Tarea> tareasRecientes = (List<Tarea>) request.getAttribute("tareas");
    List<Postulacion> postulaciones = (List<Postulacion>) request.getAttribute("postulaciones");
    
    // recuperar usuario para el saludo
    Usuario u = (Usuario) session.getAttribute("usuarioLogueado");
    String nombreUser = (u != null) ? u.getNombre() : "Voluntario";
%>
<!DOCTYPE html>
<html lang="es" class="scroll-smooth">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Panel Voluntario - Misión Michi</title>
    <jsp:include page="/WEB-INF/fragmentos/cabecera-estilos.jsp" />
</head>

<body class="bg-surface-light dark:bg-surface-dark font-sans text-ink dark:text-white antialiased">
    
    <jsp:include page="/WEB-INF/fragmentos/navbar-voluntario.jsp" />

    <main class="flex-grow">
        <div class="flex justify-center py-8 px-4 md:px-10">
            <div class="flex flex-col max-w-[1200px] w-full gap-8">
                
                <div class="flex flex-col md:flex-row justify-between items-end gap-4 pb-6 border-b border-border-light dark:border-border-dark">
                    <div>
                        <h1 class="heading-xl text-3xl md:text-4xl mb-2">Hola, <%= nombreUser %> 👋</h1>
                        <p class="text-body text-lg">Aquí está el resumen de actividad de la colonia.</p>
                    </div>
                    <div class="flex gap-3 w-full md:w-auto">
                        <a href="GatoServlet?accion=crear" class="btn btn-secondary flex-1 md:flex-none gap-2">
                            <span class="material-symbols-outlined">add_circle</span> Nuevo Gato
                        </a>
                     
                        <a href="TareaServlet?accion=nueva" class="btn btn-primary flex-1 md:flex-none gap-2 shadow-lg shadow-primary/20">
                            <span class="material-symbols-outlined">edit_square</span> Registrar Tarea
                        </a>
                    </div>
                </div>

                <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
                    
                    <div class="lg:col-span-2 flex flex-col gap-6">
                        <div class="flex items-center justify-between">
                            <h2 class="text-xl font-bold flex items-center gap-2">
                                <span class="material-symbols-outlined text-primary">assignment</span>
                                Últimas Tareas Realizadas
                            </h2>
                            <a href="TareaServlet" class="text-sm font-bold text-primary hover:underline">Ver todas</a>
                        </div>

                        <div class="space-y-4">
                            <% 
                            if (tareasRecientes != null && !tareasRecientes.isEmpty()) {
                                for (Tarea t : tareasRecientes) {
                                    String inicialVol = "V";
                                    if(t.getUsuario() != null && t.getUsuario().getNombre() != null) {
                                        inicialVol = t.getUsuario().getNombre().substring(0, 1).toUpperCase();
                                    }
                                    
                                    String iconoTarea = "task_alt";
                                    String colorBg = "bg-blue-50 text-blue-600 dark:bg-blue-900/20";
                                    if(t.getTipoDeTarea() != null && t.getTipoDeTarea().toString().equals("ALIMENTACION")) {
                                        iconoTarea = "rice_bowl";
                                        colorBg = "bg-orange-50 text-orange-600 dark:bg-orange-900/20";
                                    } else if (t.getTipoDeTarea() != null && t.getTipoDeTarea().toString().equals("SALUD")) {
                                        iconoTarea = "medical_services";
                                        colorBg = "bg-red-50 text-red-600 dark:bg-red-900/20";
                                    }
                            %>
                            
                            <div class="card p-5 flex flex-row gap-4 items-start hover:border-primary/30 transition-colors group">
                                <div class="size-12 rounded-xl <%= colorBg %> flex items-center justify-center shrink-0">
                                    <span class="material-symbols-outlined"><%= iconoTarea %></span>
                                </div>
                                <div class="flex-1">
                                    <div class="flex justify-between items-start">
                                        <h3 class="font-bold text-lg group-hover:text-primary transition-colors">
                                            <%= t.getTipoDeTarea() %>
                                        </h3>
                                        <span class="text-xs font-bold text-ink-light bg-gray-100 dark:bg-white/10 px-2 py-1 rounded">
                                            <%= t.getFecha() %>
                                        </span>
                                    </div>
                                    <p class="text-sm text-ink-light mt-1">
                                        Aplicada a <strong class="text-ink dark:text-white"><%= t.getGato().getNombre() %></strong>. 
                                        <%= (t.getObservaciones() != null) ? t.getObservaciones() : "" %>
                                    </p>
                                    
                                    <div class="flex items-center gap-4 mt-3 text-xs font-medium text-ink-light">
                                        <div class="flex items-center gap-2">
                                            <div class="size-5 rounded-full bg-gray-200 dark:bg-gray-700 flex items-center justify-center text-[10px] font-bold text-ink dark:text-white">
                                                <%= inicialVol %>
                                            </div>
                                            <%= t.getUsuario().getNombre() %>
                                        </div>
                                        <div class="flex items-center gap-1">
                                            <span class="material-symbols-outlined text-[16px]">location_on</span>
                                            <%= (t.getUbicacion() != null) ? t.getUbicacion() : "Sin ubicación" %>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <% 
                                } // Fin for tareas
                            } else { 
                            %>
                                <div class="p-8 text-center border-2 border-dashed border-gray-200 rounded-xl">
                                    <p class="text-gray-500">No hay tareas recientes.</p>
                                </div>
                            <% } %>
                        </div>
                    </div>

                    <div class="flex flex-col gap-6">
                         <div class="flex items-center justify-between">
                            <h2 class="text-xl font-bold flex items-center gap-2">
                                <span class="material-symbols-outlined text-red-500">favorite</span>
                                Postulaciones
                            </h2>
                            <span class="badge bg-red-100 text-red-700 border-red-200 px-2 py-0.5">Pendientes</span>
                        </div>

                        <div class="space-y-4">
                            <% 
                            if (postulaciones != null && !postulaciones.isEmpty()) {
                                for (Postulacion p : postulaciones) {
                                    // Inicial del Postulante
                                    String inicialPost = "P";
                                    String nombrePost = "Anónimo";
                                    
                                    if(p.getMiembroPostulante() != null) {
                                        nombrePost = p.getMiembroPostulante().getNombre();
                                        inicialPost = nombrePost.substring(0, 1).toUpperCase();
                                    }
                            %>
                            
                            <div class="card p-4 flex flex-col gap-3 relative overflow-hidden group hover:shadow-md transition-all">
                                <div class="absolute top-0 right-0 w-16 h-16 bg-gradient-to-br from-primary/10 to-transparent rounded-bl-full -mr-4 -mt-4 group-hover:from-primary/20 transition-colors"></div>
                                
                                <div class="flex items-center gap-3">
                                    <div class="size-10 rounded-full bg-surface-light dark:bg-surface-dark border border-border-light dark:border-border-dark flex items-center justify-center text-primary font-bold text-sm shadow-sm">
                                        <%= inicialPost %>
                                    </div>
                                    <div>
                                        <h4 class="font-bold text-sm"><%= nombrePost %></h4>
                                        <p class="text-xs text-ink-light">Interesado en <strong class="text-primary"><%= p.getGato().getNombre() %></strong></p>
                                    </div>
                                </div>
                                
                                <div class="bg-surface-light dark:bg-white/5 p-2 rounded text-xs italic text-ink-light border border-border-light dark:border-border-dark">
                                    "<%= (p.getObservacion() != null) ? p.getObservacion() : "Sin observaciones..." %>"
                                </div>

                                <div class="flex gap-2 mt-1">
                                    <form action="PostulacionServlet" method="POST" class="flex-1">
                                        <input type="hidden" name="id" value="<%= p.getIdPostulacion() %>">
                                        <input type="hidden" name="accion" value="aceptar">
                                        <button class="btn h-8 w-full text-xs bg-green-50 text-green-700 hover:bg-green-100 border border-green-200 font-bold">Aceptar</button>
                                    </form>
                                    <form action="PostulacionServlet" method="POST" class="flex-1">
                                        <input type="hidden" name="id" value="<%= p.getIdPostulacion() %>">
                                        <input type="hidden" name="accion" value="rechazar">
                                        <button class="btn h-8 w-full text-xs bg-red-50 text-red-700 hover:bg-red-100 border border-red-200">Rechazar</button>
                                    </form>
                                </div>
                            </div>
                            
                            <% 
                                } // Fin for postulaciones
                            } else { 
                            %>
                                <div class="p-6 text-center text-sm text-gray-500 card">
                                    No hay postulaciones pendientes.
                                </div>
                            <% } %>

                        </div>

                    </div> </div> </div>
        </div>
    </main>
</body>
</html>