<%@page import="java.time.Year"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDate"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%

    String nombreGato = request.getParameter("nombreGato");
    if (nombreGato == null) nombreGato = "el michi";
    
    String tipo = request.getParameter("tipo"); // TEMPORAL o DEFINITIVA
    if (tipo == null) tipo = "Adopción";
    
    String fechaHoy = LocalDate.now().format(DateTimeFormatter.ofPattern("dd 'de' MMMM, yyyy"));
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <title>¡Postulación Exitosa! - Misión Michi</title>
    <jsp:include page="/WEB-INF/fragmentos/cabecera-estilos.jsp" />
</head>

<body class="bg-surface-light dark:bg-surface-dark font-sans text-ink dark:text-white transition-colors duration-300 flex flex-col min-h-screen">

    <jsp:include page="/WEB-INF/fragmentos/navbar-familia.jsp" />

    <main class="flex-1 flex items-center justify-center py-12 px-4">
        <div class="w-full max-w-2xl animate-fade-in-up">
            
            <div class="bg-white dark:bg-surface-cardDark rounded-3xl shadow-xl border border-border-light dark:border-border-dark overflow-hidden relative">
                
                <div class="absolute top-0 left-0 w-full h-2 bg-gradient-to-r from-primary via-yellow-400 to-blue-500"></div>

                <div class="p-8 sm:p-12 flex flex-col items-center text-center">
                    
                    <div class="mb-8 relative">
                        <div class="size-32 bg-green-100 dark:bg-green-900/30 rounded-full flex items-center justify-center animate-bounce-slow">
                            <span class="material-symbols-outlined text-6xl text-green-600 dark:text-green-400">
                                check_circle
                            </span>
                        </div>
                        <span class="material-symbols-outlined absolute -top-2 -right-2 text-yellow-400 text-4xl animate-pulse">celebration</span>
                        <span class="material-symbols-outlined absolute bottom-0 -left-4 text-primary text-3xl opacity-50 rotate-[-15deg]">pets</span>
                    </div>

                    <h1 class="text-3xl sm:text-4xl font-black text-ink dark:text-white mb-4 tracking-tight">
                        ¡Solicitud Enviada!
                    </h1>
                    
                    <p class="text-lg text-ink-light max-w-md mx-auto mb-10 leading-relaxed">
                        Estamos muy emocionados por tu interés en <span class="font-bold text-primary"><%= nombreGato %></span>. 
                        Un voluntario revisará tu perfil y te contactará en las próximas 48 horas.
                    </p>

                    <div class="w-full bg-surface-light dark:bg-black/20 rounded-2xl p-6 border border-border-light dark:border-border-dark mb-10">
                        <h3 class="text-sm font-bold uppercase tracking-wider text-ink-light mb-4 flex items-center justify-center gap-2">
                            <span class="material-symbols-outlined text-lg">receipt_long</span>
                            Resumen del Trámite
                        </h3>
                        
                        <div class="grid grid-cols-1 md:grid-cols-3 gap-6 text-left md:text-center">
                            
                            <div class="flex flex-col md:items-center gap-1">
                                <span class="text-xs font-bold text-ink-light uppercase">Candidato</span>
                                <span class="text-lg font-bold text-ink dark:text-white flex items-center gap-2">
                                    <span class="material-symbols-outlined text-primary text-sm">pets</span>
                                    <%= nombreGato %>
                                </span>
                            </div>

                            <div class="flex flex-col md:items-center gap-1 border-t md:border-t-0 md:border-l border-border-light dark:border-gray-700 pt-4 md:pt-0">
                                <span class="text-xs font-bold text-ink-light uppercase">Modalidad</span>
                                <span class="font-medium text-ink dark:text-white capitalize">
                                    <%= tipo.toLowerCase() %>
                                </span>
                            </div>

                            <div class="flex flex-col md:items-center gap-1 border-t md:border-t-0 md:border-l border-border-light dark:border-gray-700 pt-4 md:pt-0">
                                <span class="text-xs font-bold text-ink-light uppercase">Fecha</span>
                                <span class="font-medium text-ink dark:text-white">
                                    <%= fechaHoy %>
                                </span>
                            </div>
                        </div>
                    </div>

                    <div class="flex flex-col sm:flex-row gap-4 w-full justify-center">
                        <a href="UsuarioServlet?accion=misPostulaciones" 
                           class="btn bg-white dark:bg-white/5 border border-gray-200 dark:border-gray-700 text-ink dark:text-white font-bold py-3 px-8 rounded-xl hover:border-primary hover:text-primary transition-all w-full sm:w-auto flex items-center justify-center gap-2">
                            <span class="material-symbols-outlined">visibility</span>
                            Ver mis Postulaciones
                        </a>
                        
                        <a href="GatoServlet?accion=catalogo" 
                           class="btn btn-primary py-3 px-8 rounded-xl w-full sm:w-auto flex items-center justify-center gap-2 shadow-lg shadow-primary/20">
                            <span class="material-symbols-outlined">home</span>
                            Volver al Catálogo
                        </a>
                    </div>

                </div>
            </div>

        </div>
    </main>

    <footer class="mt-auto py-12 bg-white dark:bg-surface-cardDark border-t border-border-light dark:border-border-dark transition-colors duration-200">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">

            <div class="grid grid-cols-1 md:grid-cols-4 gap-8 mb-8">

                <div class="col-span-1 md:col-span-2">
                    <div class="flex items-center gap-2 mb-4 text-primary">
                        <span class="material-symbols-outlined text-3xl">pets</span>
                        <span class="font-black text-xl tracking-tight text-ink dark:text-white">Misión Michi</span>
                    </div>
                    <p class="text-sm text-ink-light leading-relaxed max-w-xs">
                        Transformando vidas, un ronroneo a la vez. Ayudamos a gatos en situación de calle a encontrar hogares llenos de amor.
                    </p>
                </div>

                <div>
                    <h3 class="font-bold text-ink dark:text-white mb-4">Explorar</h3>
                    <ul class="space-y-3 text-sm text-ink-light">
                        <li>
                            <a href="index.jsp" class="hover:text-primary transition-colors">Inicio</a>
                        </li>
                        <li>
                            <a href="GatoServlet?accion=listar" class="hover:text-primary transition-colors">Gatos en Adopción</a>
                        </li>
                        <li>
                            <a href="#" class="hover:text-primary transition-colors">Historias de Éxito</a>
                        </li>
                        <li>
                            <a href="#" class="hover:text-primary transition-colors">Cómo Ayudar</a>
                        </li>
                    </ul>
                </div>

                <div>
                    <h3 class="font-bold text-ink dark:text-white mb-4">Contacto</h3>
                    <ul class="space-y-3 text-sm text-ink-light">
                        <li class="flex items-center gap-2">
                            <span class="material-symbols-outlined text-[18px]">mail</span>
                            contacto@misionmichi.com
                        </li>
                        <li class="flex items-center gap-2">
                            <span class="material-symbols-outlined text-[18px]">location_on</span>
                            Posadas, Misiones
                        </li>
                    </ul>

                    <div class="flex gap-4 mt-4">
                        <a href="#" class="size-8 rounded-full bg-gray-100 dark:bg-white/5 flex items-center justify-center text-ink-light hover:bg-primary hover:text-white transition-all">
                            <span class="font-bold text-xs">IG</span>
                        </a>
                        <a href="#" class="size-8 rounded-full bg-gray-100 dark:bg-white/5 flex items-center justify-center text-ink-light hover:bg-primary hover:text-white transition-all">
                            <span class="font-bold text-xs">FB</span>
                        </a>
                    </div>
                </div>
            </div>

            <div class="pt-8 border-t border-gray-100 dark:border-gray-800 flex flex-col md:flex-row justify-between items-center gap-4">
                <p class="text-sm text-ink-light text-center md:text-left">
                    &copy; <%= Year.now().getValue() %> Misión Michi. Todos los derechos reservados.
                </p>
                <div class="flex gap-6 text-sm text-ink-light">
                    <a href="#" class="hover:text-ink dark:hover:text-white transition-colors">Privacidad</a>
                    <a href="#" class="hover:text-ink dark:hover:text-white transition-colors">Términos</a>
                </div>
            </div>
        </div>
    </footer>

</body>
</html>