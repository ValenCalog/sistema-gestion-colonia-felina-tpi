<%@page import="java.time.Year"%>
<%@page import="com.prog.tpi_colonia_felina_paii.enums.Sexo"%>
<%@page import="com.prog.tpi_colonia_felina_paii.modelo.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // 1. RECUPERAR DATOS
    Gato g = (Gato) request.getAttribute("gato");
    Usuario u = (Usuario) session.getAttribute("usuarioLogueado");
    
    // Validaciones de Foto
    boolean tieneFoto = (g.getFotografia() != null && !g.getFotografia().isEmpty());
    String fotoUrl = tieneFoto ? request.getContextPath() + g.getFotografia() : "";
    
    // Lógica de Disponibilidad (Para habilitar o no el botón)
    String disponibilidad = (g.getDisponibilidad().toString() != null) ? g.getDisponibilidad().toString() : "NO_DISPONIBLE";
    boolean esAdoptable = disponibilidad.equalsIgnoreCase("DISPONIBLE");
    
    // Textos amigables según sexo
    boolean esMacho = (g.getSexo() == Sexo.MACHO);
    String textoSexo = esMacho ? "Macho" : "Hembra";
    String pronombre = esMacho ? "el" : "ella";
    String interesado = esMacho ? "interesado" : "interesada";
%>
<!DOCTYPE html>
<html lang="es" class="scroll-smooth">
<head>
    <title>Adopta a <%= g.getNombre() %> - Misión Michi</title>
    <jsp:include page="/WEB-INF/fragmentos/cabecera-estilos.jsp" />
</head>

<body class="bg-surface-light dark:bg-surface-dark font-sans text-ink dark:text-white antialiased flex flex-col min-h-screen">
    
    <jsp:include page="/WEB-INF/fragmentos/navbar-familia.jsp" />

    <main class="flex-1 w-full max-w-6xl mx-auto px-4 sm:px-6 lg:px-8 py-10">
        
        <nav class="flex items-center text-sm text-ink-light mb-8 animate-fade-in">
            <a href="index.jsp" class="hover:text-primary transition-colors">Inicio</a>
            <span class="mx-2">/</span>
            <a href="GatoServlet?accion=listar" class="hover:text-primary transition-colors">Gatos en Adopción</a>
            <span class="mx-2">/</span>
            <span class="font-bold text-ink dark:text-white"><%= g.getNombre() %></span>
        </nav>

        <div class="grid grid-cols-1 lg:grid-cols-2 gap-10 lg:gap-16 items-start">
            
            <div class="flex flex-col gap-6 animate-fade-in-up">
                
                <div class="bg-white dark:bg-surface-cardDark p-4 rounded-3xl shadow-xl shadow-gray-200/50 dark:shadow-none border border-white dark:border-gray-800 rotate-1 hover:rotate-0 transition-transform duration-500 ease-out">
                    <div class="aspect-[4/5] w-full bg-gray-100 dark:bg-white/5 rounded-2xl overflow-hidden relative group">
                        <% if (tieneFoto) { %>
                            <img src="<%= fotoUrl %>" class="w-full h-full object-cover transition-transform duration-700 group-hover:scale-105" alt="Foto de <%= g.getNombre() %>">
                        <% } else { %>
                            <div class="flex flex-col items-center justify-center h-full text-gray-300 dark:text-gray-600 bg-gray-50 dark:bg-white/5">
                                <span class="material-symbols-outlined text-8xl mb-4">pets</span>
                                <span class="font-medium text-lg">Foto próximamente</span>
                            </div>
                        <% } %>
                        
                        <% if (esAdoptable) { %>
                            <div class="absolute top-4 left-4 bg-white/90 dark:bg-black/80 backdrop-blur text-green-600 px-3 py-1 rounded-full text-xs font-black tracking-wider uppercase shadow-sm border border-green-100 flex items-center gap-1">
                                <span class="material-symbols-outlined text-[14px]">volunteer_activism</span> Disponible
                            </div>
                        <% } else { %>
                            <div class="absolute top-4 left-4 bg-white/90 dark:bg-black/80 backdrop-blur text-gray-500 px-3 py-1 rounded-full text-xs font-black tracking-wider uppercase shadow-sm flex items-center gap-1">
                                <span class="material-symbols-outlined text-[14px]">lock</span> No Disponible
                            </div>
                        <% } %>
                    </div>
                </div>

            </div>


            <div class="flex flex-col gap-8 animate-fade-in" style="animation-delay: 0.1s;">
                
                <div>
                    <h1 class="text-4xl md:text-5xl font-black text-ink dark:text-white mb-2 tracking-tight">
                        Hola, soy <span class="text-primary"><%= g.getNombre() %></span>
                    </h1>
                    <p class="text-xl text-ink-light font-medium">
                        Buscando un hogar en <span class="text-ink dark:text-white"><%= (g.getZona() != null) ? g.getZona().getNombre() : "Posadas" %></span>
                    </p>
                </div>
                    
                <div class="grid grid-cols-3 gap-4">
                    <div class="bg-white dark:bg-surface-cardDark p-4 rounded-2xl text-center border border-border-light dark:border-border-dark shadow-sm">
                        <div class="mx-auto size-10 rounded-full <%= esMacho ? "bg-blue-100 text-blue-600" : "bg-pink-100 text-pink-600" %> flex items-center justify-center mb-2">
                            <span class="material-symbols-outlined"><%= esMacho ? "male" : "female" %></span>
                        </div>
                        <span class="block text-xs font-bold uppercase text-ink-light">Sexo</span>
                        <span class="font-bold text-ink dark:text-white"><%= textoSexo %></span>
                    </div>

                    <div class="bg-white dark:bg-surface-cardDark p-4 rounded-2xl text-center border border-border-light dark:border-border-dark shadow-sm">
                        <div class="mx-auto size-10 rounded-full <%= g.isEsterilizado() ? "bg-green-100 text-green-600" : "bg-amber-100 text-amber-600" %> flex items-center justify-center mb-2">
                            <span class="material-symbols-outlined"><%= g.isEsterilizado() ? "content_cut" : "medication" %></span>
                        </div>
                        <span class="block text-xs font-bold uppercase text-ink-light">Esterilizado</span>
                        <span class="font-bold text-ink dark:text-white"><%= g.isEsterilizado() ? "Sí" : "No" %></span>
                    </div>

                    <div class="bg-white dark:bg-surface-cardDark p-4 rounded-2xl text-center border border-border-light dark:border-border-dark shadow-sm">
                        <div class="mx-auto size-10 rounded-full bg-purple-100 text-purple-600 flex items-center justify-center mb-2">
                            <span class="material-symbols-outlined">palette</span>
                        </div>
                        <span class="block text-xs font-bold uppercase text-ink-light">Pelaje</span>
                        <span class="font-bold text-ink dark:text-white text-sm leading-tight"><%= g.getColor() %></span>
                    </div>
                </div>

                <div class="prose prose-lg text-ink dark:text-gray-300 leading-relaxed">
                    <p>
                        <%= (g.getCaracteristicas() != null && !g.getCaracteristicas().isEmpty()) 
                            ? g.getCaracteristicas() 
                            : "Aún estamos conociendo a " + g.getNombre() + ", pero seguro tiene mucho amor para dar. ¡Acércate a conocerle!" %>
                    </p>
                    
                </div>

                <div class="border-t border-border-light dark:border-border-dark my-2"></div>

                <div class="bg-surface-light dark:bg-black/20 rounded-3xl p-6 sm:p-8 border-2 border-primary/20 text-center sm:text-left flex flex-col sm:flex-row items-center gap-6 shadow-lg shadow-primary/5">
                    <div class="flex-1">
                        <h3 class="font-bold text-xl text-ink dark:text-white mb-1">¿Te enamoraste?</h3>
                        <p class="text-sm text-ink-light">
                            Si sientes que <%= g.getNombre() %> es el compañero ideal para ti, inicia el proceso de adopción hoy mismo.
                        </p>
                    </div>
                    
                    <% if (esAdoptable) { %>
                        <a href="PostulacionServlet?accion=formulario&idGato=<%= g.getIdGato() %>" 
                           class="btn btn-primary py-4 px-8 text-lg shadow-xl shadow-primary/30 hover:scale-105 transition-transform whitespace-nowrap">
                            ¡Quiero Adoptarlo!
                        </a>
                    <% } else { %>
                        <button disabled class="btn bg-gray-200 text-gray-400 dark:bg-gray-800 dark:text-gray-600 py-4 px-8 cursor-not-allowed font-bold whitespace-nowrap">
                            No Disponible
                        </button>
                    <% } %>
                </div>
                
                <p class="text-center text-xs text-ink-light">
                    Al hacer clic, serás redirigido al formulario de postulación.
                </p>

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