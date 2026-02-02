<%@page import="com.prog.tpi_colonia_felina_paii.modelo.Usuario"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.util.List"%>
<%@page import="com.prog.tpi_colonia_felina_paii.modelo.Adopcion"%>
<%@page import="com.prog.tpi_colonia_felina_paii.modelo.Seguimiento"%>
<%@page import="com.prog.tpi_colonia_felina_paii.enums.TipoContacto"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    List<Adopcion> listaAdopciones = (List<Adopcion>) request.getAttribute("listaAdopciones");
    Adopcion adopcionSeleccionada = (Adopcion) request.getAttribute("adopcionSeleccionada");
    List<Seguimiento> historial = (List<Seguimiento>) request.getAttribute("historialSeguimientos");
    DateTimeFormatter fmtFecha = DateTimeFormatter.ofPattern("dd 'de' MMMM, yyyy");
    
    // Recuperar teléfono de contacto seguro
    String telefonoFamilia = "Sin contacto";
    if (adopcionSeleccionada != null && adopcionSeleccionada.getFamiliaAdoptante() != null) {
        List<Usuario> miembros = adopcionSeleccionada.getFamiliaAdoptante().getMiembrosFamilia();
        if (miembros != null && !miembros.isEmpty()) {
            for (Usuario miembro : miembros) {
                if (miembro.getTelefono() != null && !miembro.getTelefono().trim().isEmpty()) {
                    telefonoFamilia = miembro.getTelefono();
                    break;
                }
            }
        }
    }
%>

<!DOCTYPE html>
<html lang="es" class="scroll-smooth light">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Seguimientos - Misión Michi</title>
    <jsp:include page="/WEB-INF/fragmentos/cabecera-estilos.jsp" />
</head>
<body class="bg-surface-light dark:bg-surface-dark font-sans text-ink dark:text-white h-screen flex flex-col overflow-hidden">

    <jsp:include page="/WEB-INF/fragmentos/navbar-voluntario.jsp" />

    <main class="flex-1 flex overflow-hidden">
        
        <aside class="w-full md:w-1/3 xl:w-1/4 bg-surface-card border-r border-border-light flex flex-col z-10">
            <div class="p-5 border-b border-border-light">
                <h2 class="text-xl font-bold">Adopciones Activas</h2>
                <p class="text-xs text-ink-light mt-1">Selecciona una familia.</p>
            </div>

            <div class="flex-1 overflow-y-auto p-3 space-y-2 custom-scrollbar">
                <% if (listaAdopciones != null && !listaAdopciones.isEmpty()) { 
                    for (Adopcion a : listaAdopciones) {
                        boolean isSelected = (adopcionSeleccionada != null && adopcionSeleccionada.getIdAdopcion().equals(a.getIdAdopcion()));
                        String activeClass = isSelected ? "bg-primary/10 border-primary" : "bg-white border-transparent hover:bg-gray-50";
                %>
                <a href="SeguimientoServlet?accion=historial&idAdopcion=<%= a.getIdAdopcion() %>" class="block">
                    <div class="p-4 rounded-xl border <%= activeClass %> cursor-pointer group flex items-start gap-3 transition-colors">
                        <div class="size-10 rounded-full bg-gray-200 flex items-center justify-center shrink-0">
                            <span class="material-symbols-outlined text-gray-500">pets</span>
                        </div>
                        <div class="flex-1 min-w-0">
                            <h3 class="font-bold text-sm truncate"><%= a.getGato().getNombre() %></h3>
                            <p class="text-xs text-ink-light">Fam. <%= a.getFamiliaAdoptante().getCodigoFamilia() %></p>
                        </div>
                    </div>
                </a>
                <% } } else { %>
                    <div class="text-center py-10 opacity-50 px-4">
                        <p class="text-sm">No hay adopciones finalizadas.</p>
                    </div>
                <% } %>
            </div>
        </aside>

        <section class="flex-1 flex flex-col bg-surface-light overflow-hidden relative">
            
            <% if (adopcionSeleccionada != null) { %>
                
                <div class="p-6 md:p-8 flex justify-between items-center bg-white border-b border-border-light z-10">
                    <div>
                        <h1 class="text-2xl font-bold flex items-center gap-2">
                            <%= adopcionSeleccionada.getGato().getNombre() %>
                            <span class="badge bg-green-100 text-green-700">Adoptado</span>
                        </h1>
                        <p class="text-sm text-ink-light mt-1 flex gap-2">
                            <span class="material-symbols-outlined text-base">call</span> <%= telefonoFamilia %>
                        </p>
                    </div>
                    
                    <a href="SeguimientoServlet?accion=nuevo&idAdopcion=<%= adopcionSeleccionada.getIdAdopcion() %>" 
                       class="btn btn-primary gap-2">
                        <span class="material-symbols-outlined">add_comment</span> Nuevo
                    </a>
                </div>

                <div class="flex-1 overflow-y-auto px-6 md:px-8 pb-10 custom-scrollbar">
                    <div class="max-w-3xl py-8">
                        <% if (historial != null && !historial.isEmpty()) { %>
                            <div class="relative border-l-2 border-gray-200 ml-3 space-y-8">
                                <% for (Seguimiento s : historial) { %>
                                <div class="relative pl-8">
                                    <div class="absolute -left-[9px] top-0 size-[18px] rounded-full bg-white border-4 border-primary"></div>
                                    <div class="card p-5">
                                        <div class="flex justify-between mb-2">
                                            <span class="font-bold text-sm text-ink-light"><%= s.getFecha().format(fmtFecha) %></span>
                                            <span class="badge bg-gray-100"><%= s.getTipoDeContacto() %></span>
                                        </div>
                                        <p class="text-ink text-sm"><%= s.getObservaciones() %></p>
                                        <div class="mt-3 pt-3 border-t border-gray-100 text-xs text-ink-light">
                                            Registrado por: <strong><%= s.getVoluntario().getNombre() %></strong>
                                        </div>
                                    </div>
                                </div>
                                <% } %>
                            </div>
                        <% } else { %>
                            <div class="text-center py-16 opacity-60">
                                <span class="material-symbols-outlined text-4xl mb-2 text-gray-300">history_edu</span>
                                <p class="text-sm font-bold">Sin historial</p>
                            </div>
                        <% } %>
                    </div>
                </div>

            <% } else { %>
                <div class="flex flex-col items-center justify-center h-full text-center p-6 opacity-60">
                    <span class="material-symbols-outlined text-6xl mb-4 text-gray-300">manage_search</span>
                    <h2 class="text-xl font-bold">Detalle de Seguimiento</h2>
                    <p class="text-sm">Selecciona una adopción para ver su historial.</p>
                </div>
            <% } %>
        </section>
    </main>
</body>
</html>