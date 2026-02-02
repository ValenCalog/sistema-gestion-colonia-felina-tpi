<%@page import="com.prog.tpi_colonia_felina_paii.modelo.Usuario"%>
<%@page import="java.util.List"%>
<%@page import="java.time.LocalDate"%>
<%@page import="com.prog.tpi_colonia_felina_paii.modelo.Tarea"%>
<%@page import="com.prog.tpi_colonia_felina_paii.modelo.Gato"%>
<%@page import="com.prog.tpi_colonia_felina_paii.enums.TipoDeTarea"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    // Lógica del Formulario
    Tarea tarea = (Tarea) request.getAttribute("tareaEditar");
    boolean esEdicion = (tarea != null);
    List<Gato> listaGatos = (List<Gato>) request.getAttribute("listaGatos");
    Gato gatoPre = (Gato) request.getAttribute("gatoPreseleccionado");
    
    String fechaValue = LocalDate.now().toString();
    if (esEdicion && tarea.getFecha() != null) {
        fechaValue = tarea.getFecha().toString();
    }
%>

<!DOCTYPE html>
<html lang="es" class="scroll-smooth light">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title><%= esEdicion ? "Editar Tarea" : "Registrar Tarea" %> - Misión Michi</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Manrope:wght@200..800&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    
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

    <main class="flex-1 p-6 md:p-10 max-w-5xl mx-auto w-full flex flex-col justify-start">
        
        <div class="mb-8">
            <a href="TareaServlet?accion=listar" class="text-sm font-bold text-ink-light hover:text-primary flex items-center gap-1 mb-2 transition-colors">
                <span class="material-symbols-outlined text-base">arrow_back</span> Volver a Tareas
            </a>
            <h1 class="text-3xl md:text-4xl font-black text-ink dark:text-white tracking-tight mb-2">
                <%= esEdicion ? "Editar Registro 📝" : "Registrar Tarea 📋" %>
            </h1>
            <p class="text-lg text-ink-light dark:text-gray-400">Deja constancia del trabajo realizado por el bienestar de la colonia.</p>
        </div>

        <div class="bg-surface-card dark:bg-surface-cardDark rounded-3xl p-8 shadow-xl shadow-gray-200/50 dark:shadow-none border border-border-light dark:border-border-dark relative overflow-hidden">
            
            <div class="absolute top-0 right-0 p-16 bg-gradient-to-br from-primary/5 to-transparent rounded-bl-full -mr-10 -mt-10 pointer-events-none"></div>

            <form action="TareaServlet" method="POST" class="flex flex-col gap-8 relative z-10">
                <input type="hidden" name="idTarea" value="<%= esEdicion ? tarea.getIdTarea() : "" %>">

                <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
                    
                    <div class="flex flex-col gap-2">
                        <label class="text-sm font-bold text-ink dark:text-white uppercase tracking-wide">Gato Atendido *</label>
                        <div class="relative">
                            <select name="idGato" class="w-full rounded-xl border-border-light dark:border-border-dark bg-surface-light dark:bg-surface-dark h-14 px-4 pr-10 focus:border-primary focus:ring-2 focus:ring-primary/20 appearance-none cursor-pointer transition-all font-medium text-ink dark:text-white" required>
                                <option value="" disabled <%= (gatoPre == null && !esEdicion) ? "selected" : "" %>>Seleccione un michi...</option>
                                
                                <% if(listaGatos != null) { 
                                    for(Gato g : listaGatos) { 
                                        boolean isSelected = false;
                                        if (esEdicion && tarea.getGato().getIdGato().equals(g.getIdGato())) { isSelected = true; }
                                        else if (!esEdicion && gatoPre != null && gatoPre.getIdGato().equals(g.getIdGato())) { isSelected = true; }
                                %>
                                    <option value="<%= g.getIdGato() %>" <%= isSelected ? "selected" : "" %>>
                                        <%= g.getNombre() %> (<%= g.getColor() %>)
                                    </option>
                                <%  } } %>
                            </select>
                            <span class="material-symbols-outlined absolute right-4 top-4 pointer-events-none text-ink-light">expand_more</span>
                        </div>
                    </div>

                    <div class="flex flex-col gap-2">
                        <label class="text-sm font-bold text-ink dark:text-white uppercase tracking-wide">Fecha *</label>
                        <div class="relative">
                             <input type="date" name="fecha" required
                               class="w-full rounded-xl border-border-light dark:border-border-dark bg-surface-light dark:bg-surface-dark h-14 px-4 focus:border-primary focus:ring-2 focus:ring-primary/20 transition-all font-medium text-ink dark:text-white"
                               value="<%= fechaValue %>">
                        </div>
                    </div>

                    <div class="flex flex-col gap-2">
                        <label class="text-sm font-bold text-ink dark:text-white uppercase tracking-wide">Tipo de Tarea *</label>
                        <div class="relative">
                            <select name="tipoDeTarea" class="w-full rounded-xl border-border-light dark:border-border-dark bg-surface-light dark:bg-surface-dark h-14 px-4 pr-10 focus:border-primary focus:ring-2 focus:ring-primary/20 appearance-none cursor-pointer transition-all font-medium text-ink dark:text-white">
                                <% for(TipoDeTarea t : TipoDeTarea.values()) { 
                                    boolean selected = esEdicion && tarea.getTipoDeTarea() == t;
                                %>
                                    <option value="<%= t %>" <%= selected ? "selected" : "" %>>
                                        <%= t.toString().replace("_", " ") %>
                                    </option>
                                <% } %>
                            </select>
                            <span class="material-symbols-outlined absolute right-4 top-4 pointer-events-none text-ink-light">expand_more</span>
                        </div>
                    </div>

                    <div class="flex flex-col gap-2">
                        <label class="text-sm font-bold text-ink dark:text-white uppercase tracking-wide">Ubicación (Opcional)</label>
                        <div class="relative">
                            <input type="text" name="ubicacion" 
                               placeholder="Ej: Parque Norte..."
                               class="w-full rounded-xl border-border-light dark:border-border-dark bg-surface-light dark:bg-surface-dark h-14 px-4 pl-11 focus:border-primary focus:ring-2 focus:ring-primary/20 transition-all font-medium text-ink dark:text-white"
                               value="<%= esEdicion && tarea.getUbicacion() != null ? tarea.getUbicacion() : "" %>">
                            <span class="material-symbols-outlined absolute left-4 top-4 pointer-events-none text-ink-light">pin_drop</span>
                        </div>
                    </div>

                </div>
                
                <div class="flex flex-col gap-2">
                    <label class="text-sm font-bold text-ink dark:text-white uppercase tracking-wide">Observaciones / Detalles</label>
                    <textarea name="observaciones" 
                              class="w-full rounded-xl border-border-light dark:border-border-dark bg-surface-light dark:bg-surface-dark min-h-[120px] p-4 focus:border-primary focus:ring-2 focus:ring-primary/20 transition-all font-medium text-ink dark:text-white resize-y"
                              placeholder="Describe qué se hizo, novedades o estado del animal..."><%= esEdicion && tarea.getObservaciones() != null ? tarea.getObservaciones() : "" %></textarea>
                </div>

                <div class="flex flex-col-reverse sm:flex-row justify-end gap-4 pt-6 border-t border-border-light dark:border-border-dark">
                    <a href="TareaServlet?accion=listar" class="px-8 py-3.5 rounded-xl border border-border-light dark:border-border-dark text-center font-bold text-ink-light hover:text-ink dark:hover:text-white hover:bg-surface-light dark:hover:bg-surface-dark transition-colors">
                        Cancelar
                    </a>
                    <button class="px-8 py-3.5 rounded-xl bg-gradient-to-r from-orange-500 to-orange-600 hover:from-orange-600 hover:to-orange-700 text-white font-bold shadow-lg shadow-orange-500/30 transition-all hover:-translate-y-0.5 flex items-center justify-center gap-2" type="submit">
                        <span class="material-symbols-outlined">save</span>
                        <%= esEdicion ? "Guardar Cambios" : "Registrar Tarea" %>
                    </button>
                </div>
            </form>
        </div>
    </main>

</body>
</html>