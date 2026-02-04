<%@page import="com.prog.tpi_colonia_felina_paii.modelo.Tarea"%>
<%@page import="com.prog.tpi_colonia_felina_paii.modelo.Postulacion"%>
<%@page import="com.prog.tpi_colonia_felina_paii.modelo.Gato"%>
<%@page import="com.prog.tpi_colonia_felina_paii.modelo.Usuario"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    List<Tarea> tareasRecientes = (List<Tarea>) request.getAttribute("tareas");
    List<Postulacion> postulaciones = (List<Postulacion>) request.getAttribute("postulaciones");
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
                        </div>
                        <div class="space-y-4">
                            <% if (tareasRecientes != null && !tareasRecientes.isEmpty()) {
                                for (Tarea t : tareasRecientes) { 
                                    String inicialVol = (t.getUsuario() != null && t.getUsuario().getNombre() != null) ? t.getUsuario().getNombre().substring(0,1).toUpperCase() : "V";
                            %>
                            <div class="card p-5 flex flex-row gap-4 items-start hover:border-primary/30 transition-colors group">
                                <div class="size-12 rounded-xl bg-blue-50 text-blue-600 dark:bg-blue-900/20 flex items-center justify-center shrink-0">
                                    <span class="material-symbols-outlined">task_alt</span>
                                </div>
                                <div class="flex-1">
                                    <h3 class="font-bold text-lg"><%= t.getTipoDeTarea() %></h3>
                                    <p class="text-sm text-ink-light"><%= t.getObservaciones() %></p>
                                    <span class="text-xs text-ink-light mt-2 block"><%= t.getFecha() %> • <%= t.getUsuario().getNombre() %></span>
                                </div>
                            </div>
                            <% }} else { %>
                                <div class="p-8 text-center border-2 border-dashed border-gray-200 rounded-xl">No hay tareas recientes.</div>
                            <% } %>
                        </div>
                    </div>

                    <div class="flex flex-col gap-6">
                         <div class="flex items-center justify-between">
                            <h2 class="text-xl font-bold flex items-center gap-2">
                                <span class="material-symbols-outlined text-red-500">favorite</span>
                                Postulaciones
                            </h2>
                        </div>
                        <div class="space-y-4">
                            <% if (postulaciones != null && !postulaciones.isEmpty()) {
                                for (Postulacion p : postulaciones) { %>
                                <div class="card p-4 flex flex-col gap-3">
                                    <h4 class="font-bold"><%= p.getMiembroPostulante().getNombre() %></h4>
                                    <p class="text-xs text-ink-light">Interesado en <%= p.getGato().getNombre() %></p>
                                    <a href="PostulacionServlet?accion=verDetalle&id=<%= p.getIdPostulacion() %>" class="btn btn-sm btn-outline w-full">Revisar</a>
                                </div>
                            <% }} else { %>
                                <div class="card p-6 text-center text-sm text-gray-500">No hay postulaciones.</div>
                            <% } %>
                        </div>
                    </div> 
                </div> 
            </div>
        </div>
    </main>
</body>
</html>