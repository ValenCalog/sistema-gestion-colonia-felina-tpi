<%@page import="java.util.List"%>
<%@page import="com.prog.tpi_colonia_felina_paii.modelo.*"%>
<%
    List<Tarea> historial = (List<Tarea>) request.getAttribute("historialTareas");
    Gato g = (Gato) request.getAttribute("gato");
%>

<div class="space-y-4 animate-fade-in">
    <div class="flex flex-col sm:flex-row justify-between items-center gap-4 bg-gray-50 dark:bg-white/5 p-4 rounded-xl border border-border-light dark:border-border-dark mb-2">
        <div>
            <h4 class="font-bold text-ink dark:text-white text-sm">Bitácora de Tareas</h4>
            <p class="text-xs text-ink-light">Registra cada cuidado para mantener el control.</p>
        </div>
        <a href="TareaServlet?accion=nueva&idGato=<%= g.getIdGato() %>" 
           class="btn btn-primary shadow-lg shadow-primary/20 gap-2 text-sm px-5 py-2 whitespace-nowrap w-full sm:w-auto flex justify-center">
            <span class="material-symbols-outlined text-[18px]">add_circle</span>
            Registrar Nueva Tarea
        </a>
    </div>
    <% 
    if (historial != null && !historial.isEmpty()) {
        for (Tarea t : historial) {
            String tipo = t.getTipoDeTarea().toString();
            String icono = "task_alt";
            String color = "bg-gray-100 text-gray-600"; // Default
            
            // Colores según tipo
            if (tipo.equals("ALIMENTACION")) { icono = "restaurant"; color = "bg-orange-100 text-orange-600 dark:bg-orange-900/30 dark:text-orange-400"; }
            else if (tipo.equals("SALUD") || tipo.equals("VACUNACION")) { icono = "medical_services"; color = "bg-red-100 text-red-600 dark:bg-red-900/30 dark:text-red-400"; }
            else if (tipo.equals("LIMPIEZA")) { icono = "cleaning_services"; color = "bg-blue-100 text-blue-600 dark:bg-blue-900/30 dark:text-blue-400"; }
            else if (tipo.equals("ESTERILIZACION")) { icono = "content_cut"; color = "bg-purple-100 text-purple-600 dark:bg-purple-900/30 dark:text-purple-400"; }
            
            // Nombre del voluntario
            String voluntario = (t.getUsuario() != null) ? t.getUsuario().getNombre() + " " + t.getUsuario().getApellido() : "Voluntario";
    %>
        <div class="bg-white dark:bg-surface-cardDark p-4 rounded-xl border border-border-light dark:border-border-dark flex gap-4 items-start hover:shadow-md transition-shadow">
            <div class="size-10 rounded-full <%= color %> flex items-center justify-center shrink-0">
                <span class="material-symbols-outlined text-[20px]"><%= icono %></span>
            </div>
            
            <div class="flex-1">
                <div class="flex justify-between items-start">
                    <div>
                        <p class="font-bold text-sm text-ink dark:text-white"><%= tipo %></p>
                        <p class="text-xs text-ink-light">Realizado por <span class="font-bold text-ink dark:text-white"><%= voluntario %></span></p>
                    </div>
                    <span class="text-xs font-mono bg-gray-100 dark:bg-white/10 px-2 py-1 rounded text-ink-light">
                        <%= t.getFecha() %>
                    </span>
                </div>
                
                <% if(t.getObservaciones() != null && !t.getObservaciones().isEmpty()) { %>
                    <p class="text-sm mt-2 italic text-ink-light bg-gray-50 dark:bg-black/20 p-2 rounded border border-gray-100 dark:border-gray-800">
                        "<%= t.getObservaciones() %>"
                    </p>
                <% } %>
            </div>
        </div>
    <% 
        } 
    } else { 
    %>
        <div class="text-center py-12 border-2 border-dashed border-gray-200 dark:border-gray-700 rounded-xl">
            <span class="material-symbols-outlined text-4xl text-gray-300 dark:text-gray-600 mb-2">history_edu</span>
            <p class="text-ink-light font-medium">Aún no hay tareas registradas para este michi.</p>
            <p class="text-xs text-ink-light mt-1">¡Sé el primero en registrar una!</p>
        </div>
    <% } %>
</div>