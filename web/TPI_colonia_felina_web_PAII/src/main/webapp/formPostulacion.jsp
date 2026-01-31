<%@page import="com.prog.tpi_colonia_felina_paii.enums.Sexo"%>
<%@page import="java.time.Year"%>
<%@page import="com.prog.tpi_colonia_felina_paii.modelo.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // RECUPERAR DATOS
    Gato g = (Gato) request.getAttribute("gato");
    Usuario u = (Usuario) session.getAttribute("usuarioLogueado");

    boolean tieneFoto = (g != null && g.getFotografia() != null && !g.getFotografia().isEmpty());
    String fotoUrl = tieneFoto ? request.getContextPath() + g.getFotografia() : "";
   
    if (g == null || u == null) {
        response.sendRedirect("GatoServlet?accion=catalogo");
        return;
    }
    boolean esMacho = (g.getSexo() == Sexo.MACHO);
    String textoSexo = esMacho ? "Macho" : "Hembra";
%>
<!DOCTYPE html>
<html lang="es" class="scroll-smooth">
<head>
    <title>Postularse para: <%= g.getNombre() %> - Misión Michi</title>
    <jsp:include page="/WEB-INF/fragmentos/cabecera-estilos.jsp" />
    
    <style>
        .radio-checked-primary:checked {
            border-color: #16a34a;
            background-color: #16a34a;
            background-image: url("data:image/svg+xml,%3csvg viewBox='0 0 16 16' fill='white' xmlns='http://www.w3.org/2000/svg'%3e%3ccircle cx='8' cy='8' r='3'/%3e%3c/svg%3e");
        }
        
        .radio-label:has(.radio-checked-primary:checked) {
            border-color: #16a34a;
            background-color: #f0fdf4;
            box-shadow: 0 0 0 1px #16a34a; 
        }
    </style>
</head>

<body class="bg-surface-light dark:bg-surface-dark font-sans text-ink dark:text-white antialiased">
    
    <jsp:include page="/WEB-INF/fragmentos/navbar-familia.jsp" />

    <main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        
        <div class="mb-8 animate-fade-in-up">
            <h1 class="heading-xl text-3xl mb-2">Solicitud de Adopción</h1>
            <p class="text-ink-light">Estás a un paso de cambiar la vida de <span class="font-bold text-primary"><%= g.getNombre() %></span>.</p>
        </div>

        <div class="flex flex-col lg:flex-row gap-8 items-start">
            
            <aside class="w-full lg:w-1/3 lg:sticky lg:top-24 animate-fade-in">
                <div class="bg-white dark:bg-surface-cardDark rounded-2xl shadow-sm border border-border-light dark:border-border-dark overflow-hidden">
                    
                    <div class="aspect-video w-full bg-gray-100 dark:bg-white/5 relative flex items-center justify-center overflow-hidden">
                        <% if (tieneFoto) { %>
                            <img src="<%= fotoUrl %>" class="w-full h-full object-cover">
                        <% } else { %>
                            <div class="flex flex-col items-center text-gray-400">
                                <span class="material-symbols-outlined text-6xl">pets</span>
                            </div>
                        <% } %>
                    </div>

                    <div class="p-6">
                        <div class="flex justify-between items-center mb-4">
                            <h3 class="text-2xl font-black"><%= g.getNombre() %></h3>
                            <span class="px-3 py-1 bg-primary/10 text-primary text-xs font-bold rounded-full uppercase border border-primary/20">
                                ID: <%= g.getIdGato() %>
                            </span>
                        </div>
                        
                        <div class="space-y-3">
                            <div class="flex items-center gap-2 text-ink-light text-sm">
                                <span class="material-symbols-outlined text-[18px]">palette</span>
                                <span><%= g.getColor() %></span>
                            </div>
                            <div class="flex items-center gap-2 text-ink-light text-sm">
                                <span class="material-symbols-outlined"><%= esMacho ? "male" : "female" %></span>
                                <span><%= textoSexo %></span>
                            </div>
                        </div>

                        <div class="mt-6 pt-6 border-t border-border-light dark:border-border-dark">
                            <p class="text-sm text-ink leading-relaxed italic">
                                "<%= (g.getCaracteristicas() != null) ? g.getCaracteristicas() : "Un michi esperando ser amado." %>"
                            </p>
                        </div>
                    </div>
                </div>
            </aside>

            <section class="w-full lg:w-2/3 animate-fade-in" style="animation-delay: 0.1s;">
                <div class="bg-white dark:bg-surface-cardDark rounded-2xl shadow-sm border border-border-light dark:border-border-dark p-6 sm:p-8">
                    
                    <h2 class="text-xl font-bold mb-6 flex items-center gap-2">
                        <span class="material-symbols-outlined text-primary">edit_document</span>
                        Detalles de la Postulación
                    </h2>

                    <form action="PostulacionServlet" method="POST" class="space-y-8">
                        
                        <input type="hidden" name="accion" value="guardar">
                        <input type="hidden" name="idGato" value="<%= g.getIdGato() %>">
                        
                        <div class="space-y-4">
                            <label class="block text-sm font-bold text-ink dark:text-white">
                                ¿Qué tipo de adopción buscas? <span class="text-red-500">*</span>
                            </label>
                            
                            <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                                <label class="radio-label relative flex cursor-pointer rounded-xl border border-border-light dark:border-border-dark p-4 shadow-sm hover:border-primary transition-all">
                                    <input type="radio" name="tipoAdopcion" value="TEMPORAL" required 
                                           class="radio-checked-primary mt-0.5 h-5 w-5 shrink-0 border-gray-300 text-primary focus:ring-primary appearance-none rounded-full border">
                                    <div class="ml-3 flex flex-col">
                                        <span class="block text-sm font-bold text-ink dark:text-white">Hogar Temporal</span>
                                        <span class="mt-1 text-xs text-ink-light">Cuidarlo por un tiempo limitado hasta que encuentre familia.</span>
                                    </div>
                                </label>
                                
                                <label class="radio-label relative flex cursor-pointer rounded-xl border border-border-light dark:border-border-dark p-4 shadow-sm hover:border-primary transition-all">
                                    <input type="radio" name="tipoAdopcion" value="DEFINITIVA" required
                                           class="radio-checked-primary mt-0.5 h-5 w-5 shrink-0 border-gray-300 text-primary focus:ring-primary appearance-none rounded-full border">
                                    <div class="ml-3 flex flex-col">
                                        <span class="block text-sm font-bold text-ink dark:text-white">Adopción Definitiva</span>
                                        <span class="mt-1 text-xs text-ink-light">Compromiso de por vida. ¡Será parte de la familia!</span>
                                    </div>
                                </label>
                            </div>
                        </div>

                        <div class="space-y-2">
                            <div class="flex justify-between items-end">
                                <label class="block text-sm font-bold text-ink dark:text-white" for="observacion">
                                    Carta de Intención
                                </label>
                                <span class="text-xs text-ink-light">Requerido</span>
                            </div>
                            <textarea id="observacion" name="observacion" rows="5" required
                                      class="block w-full rounded-xl border-border-light dark:border-border-dark bg-gray-50 dark:bg-black/20 focus:border-primary focus:ring-primary sm:text-sm placeholder:text-gray-400 p-3"
                                      placeholder="Cuéntanos por qué quieres adoptar a <%= g.getNombre() %>, si tienes otras mascotas, o cómo es tu hogar..."></textarea>
                            <p class="text-xs text-ink-light flex items-center gap-1">
                                <span class="material-symbols-outlined text-[14px]">info</span>
                                Esta información nos ayuda a saber si son compatibles.
                            </p>
                        </div>

                        <div class="pt-6 border-t border-border-light dark:border-border-dark flex flex-col sm:flex-row items-center gap-4">
                            <button type="submit" class="w-full sm:w-auto flex-1 btn btn-primary py-3 px-8 text-base shadow-lg shadow-primary/20 flex items-center justify-center gap-2">
                                <span class="material-symbols-outlined">send</span>
                                Enviar Postulación
                            </button>
                            
                            <a href="GatoServlet?accion=verDetalle&id=<%= g.getIdGato() %>" class="w-full sm:w-auto px-8 py-3 text-sm font-bold text-ink-light hover:text-ink dark:hover:text-white transition-colors text-center">
                                Cancelar
                            </a>
                        </div>
                        
                    </form>
                </div>

                <div class="mt-6 flex gap-4 p-4 bg-primary/10 rounded-xl border border-primary/20">
                    <span class="material-symbols-outlined text-primary">verified</span>
                    <div class="text-sm text-ink-light">
                        <p class="font-bold text-ink dark:text-white mb-1">¿Qué sucede después?</p>
                        Una vez enviada, revisaremos tu perfil familiar y nos pondremos en contacto contigo. Puedes ver el estado de tu solicitud en "Mis Postulaciones".
                    </div>
                </div>
            </section>
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