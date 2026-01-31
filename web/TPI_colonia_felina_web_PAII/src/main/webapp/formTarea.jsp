<%@page import="java.util.List"%>
<%@page import="java.time.LocalDate"%>
<%@page import="com.prog.tpi_colonia_felina_paii.modelo.Tarea"%>
<%@page import="com.prog.tpi_colonia_felina_paii.modelo.Gato"%>
<%@page import="com.prog.tpi_colonia_felina_paii.enums.TipoDeTarea"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es" class="scroll-smooth light">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Registro de Tarea - Misión Michi</title>
    
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
                        "surface-light": "#f8fafc",
                        "surface-card": "#ffffff",
                        "border-light": "#e2e8f0",
                        "ink": "#1e293b",
                        "ink-light": "#64748b",
                    }
                }
            }
        }
    </script>
</head>
<body class="bg-surface-light text-ink antialiased font-sans min-h-screen flex">

    <%
        Tarea tarea = (Tarea) request.getAttribute("tareaEditar");
        boolean esEdicion = (tarea != null);
        List<Gato> listaGatos = (List<Gato>) request.getAttribute("listaGatos");
        Gato gatoPre = (Gato) request.getAttribute("gatoPreseleccionado");
        
        String fechaValue = LocalDate.now().toString();
        if (esEdicion && tarea.getFecha() != null) {
            fechaValue = tarea.getFecha().toString();
        }
    %>

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
            <a href="TareaServlet?accion=listar" class="flex items-center gap-3 px-4 py-3 bg-gradient-to-r from-orange-500 to-orange-600 text-white font-bold rounded-xl shadow-lg shadow-orange-500/30">
                <span class="material-symbols-outlined">assignment</span> 
                Tareas
            </a>
            <a href="PostulacionServlet" class="flex items-center gap-3 px-4 py-3 text-ink-light font-medium hover:text-primary hover:bg-orange-50 rounded-xl transition-all group">
                <span class="material-symbols-outlined group-hover:scale-110 transition-transform">volunteer_activism</span> 
                Adopciones
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

    <main class="flex-1 p-6 md:p-10 max-w-5xl mx-auto w-full flex flex-col justify-center">
        
        <div class="mb-8">
            <a href="TareaServlet?accion=listar" class="text-sm font-bold text-ink-light hover:text-primary flex items-center gap-1 mb-2">
                <span class="material-symbols-outlined text-base">arrow_back</span> Volver a Tareas
            </a>
            <h1 class="text-3xl md:text-4xl font-black text-ink tracking-tight mb-2">
                <%= esEdicion ? "Editar Registro 📝" : "Registrar Tarea 📋" %>
            </h1>
            <p class="text-lg text-ink-light">Deja constancia del trabajo realizado por el bienestar de la colonia.</p>
        </div>

        <div class="bg-surface-card rounded-3xl p-8 shadow-xl shadow-gray-200/50 border border-border-light relative overflow-hidden">
            
            <div class="absolute top-0 right-0 p-16 bg-gradient-to-br from-primary/5 to-transparent rounded-bl-full -mr-10 -mt-10 pointer-events-none"></div>

            <form action="TareaServlet" method="POST" class="flex flex-col gap-8 relative z-10">
                <input type="hidden" name="idTarea" value="<%= esEdicion ? tarea.getIdTarea() : "" %>">

                <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
                    
                    <div class="flex flex-col gap-2">
                        <label class="text-sm font-bold text-ink uppercase tracking-wide">Gato Atendido *</label>
                        <div class="relative">
                            <select name="idGato" class="w-full rounded-xl border-border-light bg-surface-light h-14 px-4 pr-10 focus:border-primary focus:ring-2 focus:ring-primary/20 appearance-none cursor-pointer transition-all font-medium text-ink" required>
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
                        <label class="text-sm font-bold text-ink uppercase tracking-wide">Fecha *</label>
                        <div class="relative">
                             <input type="date" name="fecha" required
                               class="w-full rounded-xl border-border-light bg-surface-light h-14 px-4 focus:border-primary focus:ring-2 focus:ring-primary/20 transition-all font-medium text-ink"
                               value="<%= fechaValue %>">
                        </div>
                    </div>

                    <div class="flex flex-col gap-2">
                        <label class="text-sm font-bold text-ink uppercase tracking-wide">Tipo de Tarea *</label>
                        <div class="relative">
                            <select name="tipoDeTarea" class="w-full rounded-xl border-border-light bg-surface-light h-14 px-4 pr-10 focus:border-primary focus:ring-2 focus:ring-primary/20 appearance-none cursor-pointer transition-all font-medium text-ink">
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
                        <label class="text-sm font-bold text-ink uppercase tracking-wide">Ubicación (Opcional)</label>
                        <div class="relative">
                            <input type="text" name="ubicacion" 
                               placeholder="Ej: Parque Norte..."
                               class="w-full rounded-xl border-border-light bg-surface-light h-14 px-4 pl-11 focus:border-primary focus:ring-2 focus:ring-primary/20 transition-all font-medium text-ink"
                               value="<%= esEdicion && tarea.getUbicacion() != null ? tarea.getUbicacion() : "" %>">
                            <span class="material-symbols-outlined absolute left-4 top-4 pointer-events-none text-ink-light">pin_drop</span>
                        </div>
                    </div>

                </div>
                
                <div class="flex flex-col gap-2">
                    <label class="text-sm font-bold text-ink uppercase tracking-wide">Observaciones / Detalles</label>
                    <textarea name="observaciones" 
                              class="w-full rounded-xl border-border-light bg-surface-light min-h-[120px] p-4 focus:border-primary focus:ring-2 focus:ring-primary/20 transition-all font-medium text-ink resize-y"
                              placeholder="Describe qué se hizo, novedades o estado del animal..."><%= esEdicion && tarea.getObservaciones() != null ? tarea.getObservaciones() : "" %></textarea>
                </div>

                <div class="flex flex-col-reverse sm:flex-row justify-end gap-4 pt-6 border-t border-border-light">
                    <a href="TareaServlet?accion=listar" class="px-8 py-3.5 rounded-xl border border-border-light text-center font-bold text-ink-light hover:text-ink hover:bg-surface-light transition-colors">
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
</div>
</body>
</html>