<%@page import="com.prog.tpi_colonia_felina_paii.modelo.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Recuperamos datos de sesión para el Avatar
    Usuario uLogueadoNav = (Usuario) session.getAttribute("usuarioLogueado");
    String inicialNav = "V"; 
    String nombreNav = "Voluntario";
    
    if (uLogueadoNav != null && uLogueadoNav.getNombre() != null && !uLogueadoNav.getNombre().isEmpty()) {
        inicialNav = uLogueadoNav.getNombre().substring(0, 1).toUpperCase();
        nombreNav = uLogueadoNav.getNombre();
    }
%>

<header class="sticky top-0 z-50 flex items-center justify-between border-b border-border-light dark:border-border-dark bg-white/90 dark:bg-surface-dark/90 backdrop-blur-md px-4 md:px-10 py-3 transition-all duration-300">
    
    <div class="flex items-center gap-3">
        <div class="size-9 text-primary flex items-center justify-center bg-primary/10 rounded-lg">
            <span class="material-symbols-outlined text-2xl">pets</span>
        </div>
        <h2 class="text-lg font-bold leading-tight tracking-tight text-ink dark:text-white">
            Misión Michi
        </h2>
    </div>
    
    <div class="hidden xl:flex flex-1 justify-center">
        <nav class="flex gap-1 bg-gray-100/50 dark:bg-white/5 p-1 rounded-full border border-gray-200 dark:border-white/10" id="mainNav">
            
            <a href="VoluntarioServlet" class="nav-link px-5 py-1.5 rounded-full text-sm font-medium transition-all text-ink-light dark:text-gray-400 hover:text-primary hover:bg-white/50 dark:hover:bg-white/5">
                Inicio
            </a>
            
            <a href="GatoServlet" class="nav-link px-5 py-1.5 rounded-full text-sm font-medium transition-all text-ink-light dark:text-gray-400 hover:text-primary hover:bg-white/50 dark:hover:bg-white/5">
                Gatos
            </a>
            
            <a href="TareaServlet" class="nav-link px-5 py-1.5 rounded-full text-sm font-medium transition-all text-ink-light dark:text-gray-400 hover:text-primary hover:bg-white/50 dark:hover:bg-white/5">
                Tareas
            </a>
            
            <a href="PostulacionServlet" class="nav-link px-5 py-1.5 rounded-full text-sm font-medium transition-all text-ink-light dark:text-gray-400 hover:text-primary hover:bg-white/50 dark:hover:bg-white/5">
                Adopciones
            </a>
            
            <a href="SeguimientoServlet" class="nav-link px-5 py-1.5 rounded-full text-sm font-medium transition-all text-ink-light dark:text-gray-400 hover:text-primary hover:bg-white/50 dark:hover:bg-white/5">
                Seguimientos
            </a>
            
        </nav>
    </div>

    <div class="hidden md:flex items-center gap-4">
        <div class="flex items-center gap-3 cursor-pointer group relative">
            <div class="text-right hidden lg:block">
                <p class="text-xs font-bold text-ink dark:text-white"><%= nombreNav %></p>
            </div>
            <div class="size-9 rounded-full bg-gradient-to-tr from-primary to-yellow-400 p-[2px]">
                <div class="w-full h-full rounded-full bg-surface-light dark:bg-surface-dark flex items-center justify-center border-2 border-white dark:border-surface-dark">
                    <span class="font-bold text-primary text-sm"><%= inicialNav %></span>
                </div>
            </div>
        </div>

        <div class="h-6 w-px bg-border-light dark:bg-border-dark"></div>
        
        <a href="LogoutServlet" class="flex items-center gap-2 text-sm font-bold text-red-600 hover:bg-red-50 dark:hover:bg-red-900/20 px-3 py-2 rounded-lg transition-colors border border-transparent hover:border-red-100 dark:hover:border-red-900/30">
            <span class="material-symbols-outlined text-[20px]">logout</span>
            <span class="hidden lg:inline">Cerrar sesión</span>
        </a>
    </div>

    <div class="md:hidden text-ink dark:text-white">
        <span class="material-symbols-outlined cursor-pointer text-3xl">menu</span>
    </div>

    <script>
        // Este script se ejecuta en el cliente y busca qué link coincide con la URL actual
        document.addEventListener("DOMContentLoaded", function() {
            const currentPath = window.location.pathname + window.location.search;
            const links = document.querySelectorAll('.nav-link');
            
            // Estilos para el botón activo (Fondo blanco, texto naranja)
            const activeClasses = ['bg-white', 'dark:bg-surface-cardDark', 'text-primary', 'shadow-sm', 'font-bold'];
            // Estilos para botón inactivo (que hay que quitar si está activo)
            const inactiveClasses = ['text-ink-light', 'dark:text-gray-400', 'font-medium'];

            links.forEach(link => {
                // Obtenemos el href del link (ej: "GatoServlet")
                const href = link.getAttribute('href');
                
                // Si la URL actual contiene el href del link (ej: si estamos en GatoServlet?accion=editar coincide con GatoServlet)
                if (currentPath.includes(href)) {
                    link.classList.add(...activeClasses);
                    link.classList.remove(...inactiveClasses);
                }
            });
        });
    </script>
</header>