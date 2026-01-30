<%@page import="java.util.List"%>
<%@page import="java.time.LocalDate"%>
<%@page import="com.prog.tpi_colonia_felina_paii.modelo.Tarea"%>
<%@page import="com.prog.tpi_colonia_felina_paii.modelo.Gato"%>
<%@page import="com.prog.tpi_colonia_felina_paii.enums.TipoDeTarea"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html class="light" lang="es">
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>Registro de Tarea - Misión Michi</title>
    
    <link href="https://fonts.googleapis.com" rel="preconnect"/>
    <link crossorigin="" href="https://fonts.gstatic.com" rel="preconnect"/>
    <link href="https://fonts.googleapis.com/css2?family=Manrope:wght@200..800&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <script>
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    colors: {
                        "primary": "#f97316", // Naranja
                        "primary-hover": "#ea580c",
                        "background-light": "#fff7ed",
                        "background-dark": "#1a2632",
                    },
                    fontFamily: {
                        "display": ["Manrope", "sans-serif"]
                    },
                },
            },
        }
    </script>
</head>
<body class="bg-gray-50 dark:bg-background-dark font-display text-gray-800 dark:text-white">
    
    <%
        // Recuperamos datos del Servlet
        Tarea tarea = (Tarea) request.getAttribute("tareaEditar");
        boolean esEdicion = (tarea != null);
        
        // Lista de gatos para el desplegable
        List<Gato> listaGatos = (List<Gato>) request.getAttribute("listaGatos");
        
        // NUEVO: Recuperamos el gato preseleccionado (si venimos desde la ficha)
        Gato gatoPre = (Gato) request.getAttribute("gatoPreseleccionado");
        
        // Fecha por defecto: Si es edición usa la fecha de la tarea, si es nuevo usa HOY
        String fechaValue = LocalDate.now().toString();
        if (esEdicion && tarea.getFecha() != null) {
            fechaValue = tarea.getFecha().toString();
        }
    %>

<div class="flex min-h-screen w-full flex-row overflow-hidden">
    
    <aside class="hidden lg:flex flex-col w-64 border-r border-gray-200 dark:border-gray-700 bg-white dark:bg-[#1a2632] shrink-0 sticky top-0 h-screen">
        <div class="flex flex-col h-full justify-between p-4">
            <div class="flex flex-col gap-6">
                <div class="flex items-center gap-3 px-2">
                    <div class="flex items-center justify-center w-10 h-10 rounded-xl bg-primary/10 text-primary">
                        <span class="material-symbols-outlined text-2xl">pets</span>
                    </div>
                    <div class="flex flex-col">
                        <h1 class="text-lg font-bold leading-none">Misión Michi</h1>
                        <p class="text-xs text-gray-500 font-medium mt-1">Panel Voluntario</p>
                    </div>
                </div>
                <nav class="flex flex-col gap-2">
                    <a class="flex items-center gap-3 px-3 py-2.5 rounded-lg text-gray-600 hover:bg-orange-50 transition-colors" href="GatoServlet?accion=listar">
                        <span class="material-symbols-outlined">format_list_bulleted</span> <span class="text-sm font-medium">Gatos</span>
                    </a>
                    <a class="flex items-center gap-3 px-3 py-2.5 rounded-lg bg-primary/10 text-primary font-bold" href="#">
                        <span class="material-symbols-outlined">assignment</span> <span class="text-sm">Registrar Tarea</span>
                    </a>
                </nav>
            </div>
        </div>
    </aside>

    <main class="flex-1 flex flex-col h-full min-h-screen overflow-y-auto">
        
        <div class="px-6 sm:px-10 py-4">
            <div class="flex flex-wrap items-center gap-2 text-sm">
                <a class="text-gray-500 hover:text-primary transition-colors" href="TareaServlet?accion=listar">Tareas</a>
                <span class="text-gray-400">/</span>
                <span class="text-gray-900 dark:text-white font-medium"><%= esEdicion ? "Editar Tarea" : "Nueva Tarea" %></span>
            </div>
        </div>

        <div class="flex flex-col xl:flex-row gap-6 px-6 sm:px-10 pb-10 max-w-[1000px] w-full mx-auto">
            
            <div class="flex-1 flex flex-col gap-6">
                <div class="flex flex-col gap-2">
                    <h1 class="text-3xl md:text-4xl font-black text-gray-900 dark:text-white tracking-tight">
                        <%= esEdicion ? "Editar Registro" : "Registrar Tarea Realizada" %>
                    </h1>
                    <p class="text-gray-500 dark:text-gray-400">Deja constancia de la alimentación, limpieza o cuidados realizados.</p>
                </div>

                <div class="bg-white dark:bg-[#1a2632] rounded-xl p-6 shadow-sm border border-gray-200 dark:border-gray-700">
                    
                    <form action="TareaServlet" method="POST" class="flex flex-col gap-8">
                        
                        <input type="hidden" name="idTarea" value="<%= esEdicion ? tarea.getIdTarea() : "" %>">

                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            
                            <div class="flex flex-col gap-2">
                                <label class="text-sm font-bold text-gray-700 dark:text-gray-300">Gato Atendido *</label>
                                <div class="relative">
                                    <select name="idGato" class="w-full rounded-lg border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-800 h-12 px-4 focus:border-primary focus:ring-primary appearance-none cursor-pointer" required>
                                        <option value="" disabled <%= (gatoPre == null && !esEdicion) ? "selected" : "" %>>Seleccione un michi...</option>
                                        
                                        <% if(listaGatos != null) { 
                                            for(Gato g : listaGatos) { 
                                                // Lógica para marcar como seleccionado
                                                boolean isSelected = false;

                                                if (esEdicion) {
                                                    // Caso A: Estamos editando, respetar el gato de la tarea
                                                    if (tarea.getGato().getIdGato().equals(g.getIdGato())) {
                                                        isSelected = true;
                                                    }
                                                } else {
                                                    // Caso B: Es nueva tarea, verificar si vino preseleccionado por URL
                                                    if (gatoPre != null && gatoPre.getIdGato().equals(g.getIdGato())) {
                                                        isSelected = true;
                                                    }
                                                }
                                        %>
                                            <option value="<%= g.getIdGato() %>" <%= isSelected ? "selected" : "" %>>
                                                <%= g.getNombre() != null ? g.getNombre() : "Gato #" + g.getIdGato() %> (<%= g.getColor() %>)
                                            </option>
                                        <%  } 
                                           } %>
                                    </select>
                                    <span class="material-symbols-outlined absolute right-4 top-3 pointer-events-none text-gray-500">expand_more</span>
                                </div>
                            </div>
                            <div class="flex flex-col gap-2">
                                <label class="text-sm font-bold text-gray-700 dark:text-gray-300">Fecha *</label>
                                <input type="date" name="fecha" required
                                       class="w-full rounded-lg border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-800 h-12 px-4 focus:border-primary focus:ring-primary"
                                       value="<%= fechaValue %>">
                            </div>

                            <div class="flex flex-col gap-2">
                                <label class="text-sm font-bold text-gray-700 dark:text-gray-300">Tipo de Tarea *</label>
                                <div class="relative">
                                    <select name="tipoDeTarea" class="w-full rounded-lg border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-800 h-12 px-4 focus:border-primary focus:ring-primary appearance-none cursor-pointer">
                                        <% for(TipoDeTarea t : TipoDeTarea.values()) { 
                                            boolean selected = esEdicion && tarea.getTipoDeTarea() == t;
                                        %>
                                            <option value="<%= t %>" <%= selected ? "selected" : "" %>>
                                                <%= t.toString().replace("_", " ") %>
                                            </option>
                                        <% } %>
                                    </select>
                                    <span class="material-symbols-outlined absolute right-4 top-3 pointer-events-none text-gray-500">expand_more</span>
                                </div>
                            </div>

                            <div class="flex flex-col gap-2">
                                <label class="text-sm font-bold text-gray-700 dark:text-gray-300">Ubicación (Opcional)</label>
                                <input type="text" name="ubicacion" 
                                       placeholder="Ej: Parque Norte, Zona Comederos..."
                                       class="w-full rounded-lg border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-800 h-12 px-4 focus:border-primary focus:ring-primary"
                                       value="<%= esEdicion && tarea.getUbicacion() != null ? tarea.getUbicacion() : "" %>">
                            </div>

                        </div>
                        
                        <div class="flex flex-col gap-2">
                            <label class="text-sm font-bold text-gray-700 dark:text-gray-300">Observaciones / Detalles</label>
                            <textarea name="observaciones" 
                                      class="w-full rounded-lg border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-800 min-h-[100px] p-4 focus:border-primary focus:ring-primary"
                                      placeholder="Describe qué se hizo, si hubo novedades, estado del animal, etc."><%= esEdicion && tarea.getObservaciones() != null ? tarea.getObservaciones() : "" %></textarea>
                        </div>

                        <div class="flex flex-col-reverse sm:flex-row justify-end gap-3 mt-4 pt-4 border-t border-gray-100 dark:border-gray-700">
                            <a href="TareaServlet?accion=listar" class="px-6 py-3 rounded-lg border border-gray-300 dark:border-gray-600 text-center font-bold text-gray-700 hover:bg-gray-50 transition-colors">
                                Cancelar
                            </a>
                            <button class="px-6 py-3 rounded-lg bg-primary text-white font-bold shadow-lg shadow-primary/30 hover:bg-primary-hover transition-all flex items-center justify-center gap-2" type="submit">
                                <span class="material-symbols-outlined">save</span>
                                <%= esEdicion ? "Guardar Cambios" : "Registrar Tarea" %>
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </main>
</div>
</body>
</html>