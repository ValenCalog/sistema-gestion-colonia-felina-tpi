<%@page import="com.prog.tpi_colonia_felina_paii.modelo.Usuario"%>
<%@page import="com.prog.tpi_colonia_felina_paii.modelo.Adopcion"%>
<%@page import="com.prog.tpi_colonia_felina_paii.enums.TipoContacto"%>
<%@page import="java.time.LocalDate"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    // Datos del formulario
    Adopcion adopcion = (Adopcion) request.getAttribute("adopcionObjetivo");
    TipoContacto[] tipos = (TipoContacto[]) request.getAttribute("tiposContacto");
    String fechaHoy = LocalDate.now().toString();
%>

<!DOCTYPE html>
<html lang="es" class="light">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Nuevo Seguimiento - Misión Michi</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Manrope:wght@200..800&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
    <script src="https://cdn.tailwindcss.com?plugins=forms"></script>
    
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

    <main class="flex-1 flex flex-col items-center justify-start p-6 md:p-10">
        
        <div class="w-full max-w-xl">
            <a href="SeguimientoServlet?accion=historial&idAdopcion=<%= adopcion.getIdAdopcion() %>" class="text-sm font-bold text-ink-light hover:text-primary flex items-center gap-1 mb-6 transition-colors">
                <span class="material-symbols-outlined text-base">arrow_back</span> Volver al Historial
            </a>

            <div class="bg-surface-card dark:bg-surface-cardDark rounded-3xl shadow-xl shadow-gray-200/50 dark:shadow-none border border-border-light dark:border-border-dark overflow-hidden relative">
                
                <div class="absolute top-0 right-0 p-16 bg-gradient-to-br from-primary/5 to-transparent rounded-bl-full -mr-10 -mt-10 pointer-events-none"></div>

                <div class="p-6 md:p-8 bg-surface-light dark:bg-surface-dark/50 border-b border-border-light dark:border-border-dark relative z-10">
                    <div class="flex items-start justify-between">
                        <div>
                            <h2 class="text-2xl font-black text-ink dark:text-white tracking-tight">Nuevo Seguimiento</h2>
                            <p class="text-sm text-ink-light dark:text-gray-400 mt-1">
                                Registrando actividad para <span class="font-bold text-primary"><%= adopcion.getGato().getNombre() %></span>
                            </p>
                        </div>
                        <div class="size-12 rounded-2xl bg-white dark:bg-surface-dark border border-border-light dark:border-border-dark flex items-center justify-center text-primary shadow-sm">
                            <span class="material-symbols-outlined text-2xl">edit_note</span>
                        </div>
                    </div>
                </div>

                <form action="SeguimientoServlet" method="POST" class="p-6 md:p-8 flex flex-col gap-6 relative z-10">
                    <input type="hidden" name="accion" value="guardar">
                    <input type="hidden" name="idAdopcion" value="<%= adopcion.getIdAdopcion() %>">

                    <div class="space-y-2">
                        <label class="block text-xs font-bold uppercase text-ink-light tracking-wide">Fecha del contacto</label>
                        <input type="date" name="fecha" value="<%= fechaHoy %>" required
                               class="w-full rounded-xl border-border-light dark:border-border-dark bg-surface-light dark:bg-surface-dark py-3 px-4 text-ink dark:text-white focus:ring-2 focus:ring-primary/20 focus:border-primary transition-all">
                    </div>

                    <div class="space-y-2">
                        <label class="block text-xs font-bold uppercase text-ink-light tracking-wide">Tipo de Contacto</label>
                        <div class="relative">
                            <select name="tipoContacto" class="w-full rounded-xl border-border-light dark:border-border-dark bg-surface-light dark:bg-surface-dark py-3 px-4 text-ink dark:text-white focus:ring-2 focus:ring-primary/20 focus:border-primary transition-all cursor-pointer appearance-none">
                                <% for(TipoContacto t : tipos) { %>
                                    <option value="<%= t %>"><%= t.toString().replace("_", " ") %></option>
                                <% } %>
                            </select>
                            <span class="material-symbols-outlined absolute right-4 top-3 pointer-events-none text-ink-light">expand_more</span>
                        </div>
                    </div>

                    <div class="space-y-2">
                        <label class="block text-xs font-bold uppercase text-ink-light tracking-wide">Observaciones / Notas</label>
                        <textarea name="observaciones" required placeholder="Describe cómo encontraste al animal, comentarios de la familia, estado de salud..."
                                  class="w-full rounded-xl border-border-light dark:border-border-dark bg-surface-light dark:bg-surface-dark py-3 px-4 min-h-[140px] text-ink dark:text-white focus:ring-2 focus:ring-primary/20 focus:border-primary transition-all resize-none"></textarea>
                    </div>

                    <div class="flex flex-col-reverse sm:flex-row gap-4 pt-4 border-t border-border-light dark:border-border-dark">
                        <a href="SeguimientoServlet?accion=historial&idAdopcion=<%= adopcion.getIdAdopcion() %>" 
                           class="flex-1 py-3.5 rounded-xl border border-border-light dark:border-border-dark text-center font-bold text-ink-light hover:text-ink dark:hover:text-white hover:bg-surface-light dark:hover:bg-surface-dark transition-colors">
                            Cancelar
                        </a>
                        <button type="submit" class="flex-1 py-3.5 rounded-xl bg-primary hover:bg-primary-hover text-white font-bold shadow-lg shadow-primary/30 transition-all hover:-translate-y-0.5 flex items-center justify-center gap-2">
                            <span class="material-symbols-outlined">save</span>
                            Guardar Nota
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </main>

</body>
</html>