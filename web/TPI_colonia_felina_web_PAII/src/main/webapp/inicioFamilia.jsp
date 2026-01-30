<%@page import="com.prog.tpi_colonia_felina_paii.modelo.*"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Usuario u = (Usuario) session.getAttribute("usuarioLogueado");
    Familia familia = (Familia) request.getAttribute("familia");
    List<Gato> recomendados = (List<Gato>) request.getAttribute("recomendados");
    
    // Validaciones para evitar NullPointer
    String nombreUser = (u != null) ? u.getNombre() : "Familia";
    String codigoFamilia = (familia != null) ? familia.getCodigoFamilia() : "---";
    List<Postulacion> postulaciones = (familia != null) ? familia.getPostulaciones() : null;
    List<Adopcion> adopciones = (familia != null) ? familia.getAdopciones() : null;
    List<Usuario> miembros = (familia != null) ? familia.getMiembrosFamilia() : null;
%>
<!DOCTYPE html>
<html lang="es" class="scroll-smooth">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Hogar - Misión Michi</title>
    <jsp:include page="/WEB-INF/fragmentos/cabecera-estilos.jsp" />
</head>

<body class="bg-surface-light dark:bg-surface-dark font-sans text-ink dark:text-white antialiased">
    
    <jsp:include page="/WEB-INF/fragmentos/navbar-familia.jsp"/>

    <main class="flex justify-center py-8 px-4 md:px-10">
        <div class="flex flex-col max-w-[1200px] w-full gap-8">
            
            <div class="flex flex-col md:flex-row justify-between items-end gap-6 mb-2">
                <div>
                    <h1 class="heading-xl text-3xl md:text-4xl mb-2">¡Hola, <%= nombreUser %>! 🏠</h1>
                    <p class="text-body text-lg">El viaje para agrandar la familia comienza aquí.</p>
                </div>
                
                <a href="GatoServlet?accion=catalogo" class="btn btn-primary shadow-lg shadow-primary/20 gap-2 h-12 px-6">
                    <span class="material-symbols-outlined">search</span>
                    Explorar Gatos
                </a>
            </div>

            <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
                
                <div class="lg:col-span-2 space-y-8">
                    
                    <section class="card bg-white dark:bg-surface-cardDark p-6 border border-border-light dark:border-border-dark">
                        <div class="flex items-center justify-between mb-6">
                            <h2 class="text-xl font-bold flex items-center gap-2">
                                <span class="material-symbols-outlined text-primary">assignment_ind</span>
                                Solicitudes en Curso
                            </h2>
                            <% if(postulaciones != null && !postulaciones.isEmpty()) { %>
                                <span class="badge bg-primary/10 text-primary"><%= postulaciones.size() %> Activas</span>
                            <% } %>
                        </div>

                        <div class="space-y-4">
                            <% 
                            if (postulaciones != null && !postulaciones.isEmpty()) {
                                for (Postulacion p : postulaciones) {
                                    // Calcular Progreso Visual según Estado
                                    int progreso = 10;
                                    String estadoTexto = "Recibido";
                                    String colorBarra = "bg-primary";
                                    
                                    String est = p.getEstado().toString();
                                    if(est.equals("PENDIENTE")) { progreso = 25; estadoTexto = "Evaluando perfil"; }
                                    else if(est.equals("APROBADA")) { progreso = 100; estadoTexto = "¡Aprobada! Coordinando entrega"; colorBarra = "bg-green-500"; }
                                    else if(est.equals("RECHAZADA")) { progreso = 100; estadoTexto = "No aprobada"; colorBarra = "bg-red-500"; }
                                    
                                    // Foto Gato
                                    String fotoGato = "https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?q=80&w=200";
                                    if(p.getGato().getFotografia() != null) fotoGato = request.getContextPath() + p.getGato().getFotografia();
                            %>
                            
                            <div class="flex flex-col sm:flex-row gap-4 p-4 rounded-xl border border-border-light dark:border-border-dark bg-surface-light dark:bg-white/5">
                                <div class="w-20 h-20 sm:w-24 sm:h-24 rounded-lg bg-gray-200 shrink-0 overflow-hidden">
                                    <img src="<%= fotoGato %>" class="w-full h-full object-cover">
                                </div>
                                
                                <div class="flex-1 flex flex-col justify-center w-full">
                                    <div class="flex justify-between items-start mb-2">
                                        <div>
                                            <p class="text-xs font-bold text-ink-light uppercase">Solicitud #<%= p.getIdPostulacion() %></p>
                                            <h3 class="font-bold text-lg">Interés por <span class="text-primary"><%= p.getGato().getNombre() %></span></h3>
                                        </div>
                                        <span class="text-xs font-bold px-2 py-1 rounded bg-gray-100 dark:bg-white/10"><%= p.getFecha() %></span>
                                    </div>
                                    
                                    <div class="space-y-1">
                                        <div class="flex justify-between text-xs font-medium">
                                            <span>Estado: <%= estadoTexto %></span>
                                            <span><%= progreso %>%</span>
                                        </div>
                                        <div class="h-2 w-full rounded-full bg-gray-200 dark:bg-gray-700 overflow-hidden">
                                            <div class="h-full rounded-full <%= colorBarra %> transition-all duration-1000" style="width: <%= progreso %>%;"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <% 
                                } 
                            } else { 
                            %>
                                <div class="text-center py-8 border-2 border-dashed border-gray-200 rounded-xl">
                                    <p class="text-ink-light mb-2">No tienes solicitudes pendientes.</p>
                                    <a href="GatoServlet?accion=catalogo" class="text-primary font-bold text-sm hover:underline">Buscar un compañero</a>
                                </div>
                            <% } %>
                        </div>
                    </section>

                    <% if (adopciones != null && !adopciones.isEmpty()) { %>
                    <section>
                         <h2 class="text-xl font-bold flex items-center gap-2 mb-4">
                            <span class="material-symbols-outlined text-green-500">home_health</span>
                            Mis Adopciones Felices
                        </h2>
                        <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                            <% for(Adopcion a : adopciones) { 
                                String fotoA = request.getContextPath() + a.getGato().getFotografia();
                            %>
                            <div class="card p-4 flex items-center gap-4 bg-gradient-to-br from-green-50 to-white dark:from-green-900/10 dark:to-surface-cardDark border-green-100 dark:border-green-900/30">
                                <div class="size-16 rounded-full border-2 border-green-200 overflow-hidden">
                                    <img src="<%= fotoA %>" class="w-full h-full object-cover">
                                </div>
                                <div>
                                    <h3 class="font-bold text-lg"><%= a.getGato().getNombre() %></h3>
                                    <p class="text-xs text-green-700 dark:text-green-400 font-bold">Adoptado el <%= a.getFecha() %></p>
                                </div>
                            </div>
                            <% } %>
                        </div>
                    </section>
                    <% } %>

                    <section>
                        <div class="flex items-center justify-between mb-4">
                            <h2 class="text-xl font-bold">Michis buscando hogar</h2>
                        </div>
                        <div class="grid grid-cols-1 sm:grid-cols-3 gap-4">
                            <% 
                            if(recomendados != null) {
                                for(Gato g : recomendados) {
                                    String fotoRec = "https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba";
                                    if(g.getFotografia() != null) fotoRec = request.getContextPath() + g.getFotografia();
                            %>
                                <a href="GatoServlet?accion=verDetalle&id=<%= g.getIdGato() %>" class="group relative aspect-[4/5] rounded-xl overflow-hidden shadow-sm">
                                    <img src="<%= fotoRec %>" class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-500">
                                    <div class="absolute inset-0 bg-gradient-to-t from-black/80 via-transparent to-transparent opacity-80"></div>
                                    <div class="absolute bottom-3 left-3 text-white">
                                        <h3 class="font-bold text-lg"><%= g.getNombre() %></h3>
                                        <p class="text-xs opacity-90"><%= g.getColor() %></p>
                                    </div>
                                </a>
                            <% 
                                } 
                            }
                            %>
                        </div>
                    </section>
                </div>

                <div class="space-y-6">
                    
                    <div class="card bg-gradient-to-br from-primary to-orange-600 text-white border-none p-6 text-center relative overflow-hidden">
                        <div class="absolute top-0 right-0 p-8 opacity-10 transform translate-x-4 -translate-y-4">
                             <span class="material-symbols-outlined text-8xl">group_add</span>
                        </div>
                        
                        <h3 class="text-lg font-bold mb-1 relative z-10">Tu Código Familiar</h3>
                        <p class="text-sm opacity-90 mb-4 relative z-10">Comparte este código para que tu familia se una.</p>
                        
                        <div class="bg-white/20 backdrop-blur-sm rounded-lg p-3 border border-white/30 flex items-center justify-between gap-2 relative z-10">
                            <span class="text-xl font-mono font-black tracking-widest"><%= codigoFamilia %></span>
                            <button onclick="navigator.clipboard.writeText('<%= codigoFamilia %>')" class="p-2 hover:bg-white/20 rounded-md transition-colors" title="Copiar">
                                <span class="material-symbols-outlined text-lg">content_copy</span>
                            </button>
                        </div>
                    </div>

                    <div class="card p-6">
                        <h3 class="font-bold text-lg mb-4 flex items-center gap-2">
                            <span class="material-symbols-outlined text-primary">diversity_3</span>
                            Miembros
                        </h3>
                        <div class="space-y-3">
                            <% if (miembros != null) { 
                                for(Usuario m : miembros) { 
                                    boolean esYo = m.getCorreo().equals(u.getCorreo());
                            %>
                                <div class="flex items-center gap-3">
                                    <div class="size-8 rounded-full bg-gray-100 dark:bg-gray-700 flex items-center justify-center text-xs font-bold">
                                        <%= m.getNombre().substring(0,1) %>
                                    </div>
                                    <div>
                                        <p class="text-sm font-bold flex items-center gap-2">
                                            <%= m.getNombre() %> <%= m.getApellido() %>
                                            <% if(esYo) { %><span class="text-[10px] bg-primary/10 text-primary px-1.5 rounded">TÚ</span><% } %>
                                        </p>
                                        <p class="text-xs text-ink-light"><%= m.getCorreo() %></p>
                                    </div>
                                </div>
                            <% } } %>
                        </div>
                    </div>

                    <div class="card bg-surface-light dark:bg-white/5 border-transparent p-6">
                        <h3 class="font-bold text-sm uppercase text-ink-light mb-4">Guías Útiles</h3>
                        <ul class="space-y-3 text-sm font-medium">
                            <li><a href="#" class="flex items-center gap-2 hover:text-primary transition-colors"><span class="material-symbols-outlined text-lg text-primary">check_circle</span> Preparando tu hogar</a></li>
                            <li><a href="#" class="flex items-center gap-2 hover:text-primary transition-colors"><span class="material-symbols-outlined text-lg text-primary">restaurant</span> Nutrición felina</a></li>
                            <li><a href="#" class="flex items-center gap-2 hover:text-primary transition-colors"><span class="material-symbols-outlined text-lg text-primary">medical_services</span> Primera visita al Vet</a></li>
                        </ul>
                    </div>

                </div>
            </div>
        </div>
    </main>

    <footer class="border-t border-border-light dark:border-border-dark py-6 mt-auto text-center text-sm text-ink-light">
        <p>© 2026 Misión Michi - Adoptar es un acto de amor.</p>
    </footer>

</body>
</html>