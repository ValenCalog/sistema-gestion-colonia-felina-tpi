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
    
    String telefonoFamilia = "Sin teléfono registrado";
    String nombreContacto = "Familia";
    String direccionFamilia = "Sin dirección";
    
    if (adopcionSeleccionada != null && adopcionSeleccionada.getFamiliaAdoptante() != null) {
        if(adopcionSeleccionada.getFamiliaAdoptante().getDireccion() != null){
            direccionFamilia = adopcionSeleccionada.getFamiliaAdoptante().getDireccion();
        }
        
        List<Usuario> miembros = adopcionSeleccionada.getFamiliaAdoptante().getMiembrosFamilia();
        if (miembros != null && !miembros.isEmpty()) {
            for (Usuario miembro : miembros) {
                if (miembro.getTelefono() != null && !miembro.getTelefono().trim().isEmpty()) {
                    telefonoFamilia = miembro.getTelefono();
                    nombreContacto = miembro.getNombre();
                    break;
                }
            }

            if(nombreContacto.equals("Familia") && !miembros.isEmpty()){
                nombreContacto = miembros.get(0).getNombre();
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
            <div class="p-5 border-b border-border-light bg-white dark:bg-surface-cardDark">
                <h2 class="text-xl font-bold flex items-center gap-2">
                    <span class="material-symbols-outlined text-primary">folder_shared</span>
                    Adopciones Activas
                </h2>
                <p class="text-xs text-ink-light mt-1">Selecciona para ver detalles y contacto.</p>
            </div>

            <div class="flex-1 overflow-y-auto p-3 space-y-2 custom-scrollbar bg-gray-50/50 dark:bg-transparent">
                <% if (listaAdopciones != null && !listaAdopciones.isEmpty()) { 
                    for (Adopcion a : listaAdopciones) {
                        boolean isSelected = (adopcionSeleccionada != null && adopcionSeleccionada.getIdAdopcion().equals(a.getIdAdopcion()));
                        
                        String containerClass = isSelected 
                            ? "bg-white dark:bg-surface-cardDark border-primary ring-1 ring-primary/20 shadow-md transform scale-[1.02]" 
                            : "bg-white dark:bg-surface-cardDark border-transparent hover:border-gray-200 dark:hover:border-gray-700 hover:shadow-sm";
                            
                        String textClass = isSelected ? "text-primary" : "text-ink dark:text-white";
                %>
                <a href="SeguimientoServlet?accion=historial&idAdopcion=<%= a.getIdAdopcion() %>" class="block transition-all duration-200">
                    <div class="p-4 rounded-xl border <%= containerClass %> flex items-center gap-4">
                        
                        <div class="size-12 rounded-full overflow-hidden shrink-0 border border-gray-100 dark:border-gray-700 bg-gray-100 relative">
                            <% if(a.getGato().getFotografia() != null) { %>
                                <img src="<%= request.getContextPath() + a.getGato().getFotografia() %>" class="w-full h-full object-cover">
                            <% } else { %>
                                <div class="w-full h-full flex items-center justify-center text-gray-400">
                                    <span class="material-symbols-outlined text-xl">pets</span>
                                </div>
                            <% } %>
                        </div>

                        <div class="flex-1 min-w-0">
                            <div class="flex justify-between items-start">
                                <h3 class="font-bold text-sm truncate <%= textClass %>"><%= a.getGato().getNombre() %></h3>
                                <span class="text-[10px] font-medium text-ink-light bg-gray-100 dark:bg-white/10 px-1.5 py-0.5 rounded">
                                    <%= a.getFecha() != null ? a.getFecha().toString() : "-" %>
                                </span>
                            </div>
                            <p class="text-xs text-ink-light truncate mt-0.5">
                                <span class="font-semibold">Fam. <%= a.getFamiliaAdoptante().getCodigoFamilia() %></span>
                            </p>
                            <p class="text-[10px] text-ink-light truncate mt-1 flex items-center gap-1">
                                <span class="material-symbols-outlined text-[10px]">location_on</span>
                                <%= a.getFamiliaAdoptante().getDireccion() != null ? a.getFamiliaAdoptante().getDireccion() : "Sin dirección" %>
                            </p>
                        </div>
                        
                        <% if(isSelected) { %>
                            <span class="material-symbols-outlined text-primary text-lg">chevron_right</span>
                        <% } %>
                    </div>
                </a>
                <% } } else { %>
                    <div class="flex flex-col items-center justify-center py-10 opacity-50 px-4 text-center">
                        <span class="material-symbols-outlined text-4xl mb-2 text-gray-300">folder_off</span>
                        <p class="text-sm font-medium">No hay adopciones activas.</p>
                    </div>
                <% } %>
            </div>
        </aside>

        <section class="flex-1 flex flex-col bg-surface-light dark:bg-background-dark overflow-hidden relative">
            
            <% if (adopcionSeleccionada != null) { %>
                
                <div class="p-6 bg-white dark:bg-surface-cardDark border-b border-border-light dark:border-border-dark shadow-sm z-10">
                    <div class="flex flex-col md:flex-row justify-between items-start md:items-center gap-4">
                        
                        <div class="flex items-center gap-4">
                            <div class="size-16 md:size-20 rounded-2xl overflow-hidden border-2 border-white dark:border-gray-700 shadow-md bg-gray-100 shrink-0">
                                <% if(adopcionSeleccionada.getGato().getFotografia() != null) { %>
                                    <img src="<%= request.getContextPath() + adopcionSeleccionada.getGato().getFotografia() %>" class="w-full h-full object-cover">
                                <% } else { %>
                                    <div class="w-full h-full flex items-center justify-center text-gray-400">
                                        <span class="material-symbols-outlined text-3xl">pets</span>
                                    </div>
                                <% } %>
                            </div>
                            
                            <div>
                                <h1 class="text-2xl md:text-3xl font-black text-ink dark:text-white flex items-center gap-2">
                                    <%= adopcionSeleccionada.getGato().getNombre() %>
                                    <span class="px-2 py-0.5 rounded-full bg-green-100 text-green-700 text-xs font-bold border border-green-200 uppercase tracking-wide">Adoptado</span>
                                </h1>
                                
                                <div class="flex flex-wrap items-center gap-3 mt-2 text-sm text-ink-light">
                                    <div class="flex items-center gap-1 bg-gray-50 dark:bg-white/5 px-2 py-1 rounded-lg border border-gray-100 dark:border-gray-700">
                                        <span class="material-symbols-outlined text-base text-gray-500">person</span>
                                        <span class="font-semibold text-ink dark:text-white"><%= nombreContacto %></span>
                                    </div>
                                    <div class="flex items-center gap-1 bg-gray-50 dark:bg-white/5 px-2 py-1 rounded-lg border border-gray-100 dark:border-gray-700">
                                        <span class="material-symbols-outlined text-base text-gray-500">call</span>
                                        <span><%= telefonoFamilia %></span>
                                    </div>
                                    <div class="flex items-center gap-1 bg-gray-50 dark:bg-white/5 px-2 py-1 rounded-lg border border-gray-100 dark:border-gray-700 hidden lg:flex">
                                        <span class="material-symbols-outlined text-base text-gray-500">home</span>
                                        <span class="truncate max-w-[200px]"><%= direccionFamilia %></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <a href="SeguimientoServlet?accion=nuevo&idAdopcion=<%= adopcionSeleccionada.getIdAdopcion() %>" 
                           class="btn btn-primary shadow-lg shadow-primary/20 hover:-translate-y-0.5 transition-all flex items-center gap-2 px-6 py-3 rounded-xl font-bold">
                            <span class="material-symbols-outlined">edit_square</span>
                            Nuevo Registro
                        </a>
                    </div>
                </div>

                <div class="flex-1 overflow-y-auto px-6 md:px-10 pb-10 custom-scrollbar bg-gray-50/50 dark:bg-transparent">
                    <div class="max-w-3xl mx-auto py-8">
                        
                        <h3 class="text-sm font-bold text-ink-light uppercase tracking-widest mb-6 flex items-center gap-2">
                            <span class="w-8 h-px bg-gray-300 dark:bg-gray-700"></span>
                            Historial de Seguimientos
                            <span class="flex-1 h-px bg-gray-300 dark:bg-gray-700"></span>
                        </h3>

                        <% if (historial != null && !historial.isEmpty()) { %>
                            <div class="relative border-l-2 border-gray-200 dark:border-gray-700 ml-3 space-y-8">
                                <% for (Seguimiento s : historial) { 
                                    // Icono según tipo
                                    String icon = "chat";
                                    String colorClass = "bg-blue-100 text-blue-600";
                                    if(s.getTipoDeContacto() == TipoContacto.VISITA_PRESENCIAL) { icon = "home_pin"; colorClass = "bg-purple-100 text-purple-600"; }
                                    else if(s.getTipoDeContacto() == TipoContacto.LLAMADA) { icon = "call"; colorClass = "bg-orange-100 text-orange-600"; }
                                %>
                                <div class="relative pl-8 group">
                                    <div class="absolute -left-[9px] top-0 size-[18px] rounded-full bg-white dark:bg-background-dark border-4 border-primary group-hover:scale-110 transition-transform"></div>
                                    
                                    <div class="bg-white dark:bg-surface-cardDark p-5 rounded-2xl border border-border-light dark:border-border-dark shadow-sm hover:shadow-md transition-shadow">
                                        <div class="flex justify-between items-start mb-3">
                                            <div class="flex items-center gap-2">
                                                <span class="<%= colorClass %> p-1.5 rounded-lg">
                                                    <span class="material-symbols-outlined text-sm block"><%= icon %></span>
                                                </span>
                                                <span class="font-bold text-sm text-ink dark:text-white">
                                                    <%= s.getTipoDeContacto().toString().replace("_", " ") %>
                                                </span>
                                            </div>
                                            <span class="text-xs font-bold text-ink-light bg-gray-100 dark:bg-white/5 px-2 py-1 rounded">
                                                <%= s.getFecha().format(fmtFecha) %>
                                            </span>
                                        </div>
                                        
                                        <p class="text-ink dark:text-gray-300 text-sm leading-relaxed whitespace-pre-wrap"><%= s.getObservaciones() %></p>
                                        
                                        <div class="mt-4 pt-3 border-t border-gray-100 dark:border-gray-700 flex items-center gap-2">
                                            <div class="size-6 rounded-full bg-gray-200 dark:bg-gray-600 flex items-center justify-center text-[10px] font-bold text-gray-600 dark:text-gray-300">
                                                <%= s.getVoluntario().getNombre().substring(0,1) %>
                                            </div>
                                            <span class="text-xs text-ink-light dark:text-gray-500">
                                                Registrado por <strong class="text-ink dark:text-gray-300"><%= s.getVoluntario().getNombre() %></strong>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                <% } %>
                            </div>
                        <% } else { %>
                            <div class="flex flex-col items-center justify-center py-16 opacity-60">
                                <div class="bg-white dark:bg-surface-cardDark p-4 rounded-full mb-3 shadow-sm">
                                    <span class="material-symbols-outlined text-3xl text-gray-300">history_edu</span>
                                </div>
                                <p class="text-sm font-bold text-ink dark:text-white">Sin historial registrado</p>
                                <p class="text-xs text-ink-light">Sé el primero en contactar a la familia.</p>
                            </div>
                        <% } %>
                    </div>
                </div>

            <% } else { %>
                <div class="flex flex-col items-center justify-center h-full text-center p-6 relative">
                    <div class="bg-gradient-to-tr from-primary/10 to-transparent p-10 rounded-full mb-6 animate-pulse">
                        <span class="material-symbols-outlined text-6xl text-primary">manage_search</span>
                    </div>
                    <h2 class="text-2xl font-black text-ink dark:text-white mb-2">Detalle de Seguimiento</h2>
                    <p class="text-ink-light dark:text-gray-400 max-w-sm">
                        Selecciona una adopción de la lista izquierda para ver los datos de contacto y registrar visitas o llamadas.
                    </p>
                </div>
            <% } %>
        </section>
    </main>
</body>
</html>