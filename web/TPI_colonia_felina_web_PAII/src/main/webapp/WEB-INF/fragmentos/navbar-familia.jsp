<%@page import="com.prog.tpi_colonia_felina_paii.modelo.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Usuario u = (Usuario) session.getAttribute("usuarioLogueado");
    String nombreUser = (u != null) ? u.getNombre() : "Familia";
    String inicial = (u != null && u.getNombre().length() > 0) ? u.getNombre().substring(0, 1) : "F";
%>
<header class="sticky top-0 z-50 flex items-center justify-between border-b border-border-light dark:border-border-dark bg-white/90 dark:bg-surface-dark/90 backdrop-blur-md px-4 md:px-10 py-3 transition-all">
    
    <a href="FamiliaServlet" class="flex items-center gap-3 group">
        <div class="size-9 text-primary flex items-center justify-center bg-primary/10 rounded-lg group-hover:bg-primary group-hover:text-white transition-colors">
            <span class="material-symbols-outlined text-2xl">pets</span>
        </div>
        <h2 class="text-lg font-bold text-ink dark:text-white">Misión Michi</span></h2>
    </a>
    
    <nav class="hidden md:flex gap-1 bg-gray-100/50 dark:bg-white/5 p-1 rounded-full border border-gray-200 dark:border-white/10">
        <a href="FamiliaServlet" class="px-5 py-1.5 rounded-full text-sm font-bold text-primary bg-white dark:bg-surface-cardDark shadow-sm">
            Inicio
        </a>
        <a href="GatoServlet?accion=catalogo" class="px-5 py-1.5 rounded-full text-sm font-medium text-ink-light hover:text-primary transition-colors">
            Explorar Gatos
        </a>
    </nav>

    <div class="flex items-center gap-4">
        <div class="hidden md:block text-right">
            <p class="text-xs font-bold text-ink dark:text-white"><%= nombreUser %></p>
            <p class="text-[10px] text-ink-light">Familia Adoptante</p>
        </div>
        <div class="size-9 rounded-full bg-primary/20 flex items-center justify-center text-primary font-bold border-2 border-primary">
            <%= inicial %>
        </div>
        <a href="LogoutServlet" class="text-ink-light hover:text-red-500 transition-colors" title="Cerrar Sesión">
            <span class="material-symbols-outlined">logout</span>
        </a>
    </div>
</header>