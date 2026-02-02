<%@page import="java.time.LocalDate"%>
<%@page import="com.prog.tpi_colonia_felina_paii.modelo.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Gato g = (Gato) request.getAttribute("gato");
    Usuario u = (Usuario) session.getAttribute("usuarioLogueado");
    if(g == null || u == null) { response.sendRedirect("index.jsp"); return; }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Emitir Certificado - <%= g.getNombre() %></title>
    <jsp:include page="/WEB-INF/fragmentos/cabecera-estilos.jsp" />
</head>
<body class="bg-gray-50 dark:bg-black/20 font-sans text-ink dark:text-white flex flex-col min-h-screen">

    <jsp:include page="/WEB-INF/fragmentos/navbar-veterinario.jsp" />

    <main class="flex-grow p-4 md:p-8 flex justify-center">
        <div class="max-w-3xl w-full">
            
            <div class="mb-6">
                <a href="VeterinarioServlet?accion=consultorio&idGato=<%= g.getIdGato() %>" class="flex items-center gap-2 text-ink-light hover:text-primary transition-colors text-sm font-bold">
                    <span class="material-symbols-outlined text-lg">arrow_back</span> Cancelar y Volver
                </a>
            </div>

            <div class="bg-white dark:bg-surface-cardDark border-2 border-primary/10 rounded-xl p-8 md:p-12 shadow-lg relative overflow-hidden">
                
                <span class="material-symbols-outlined absolute -right-12 -bottom-12 text-[20rem] text-primary/5 select-none pointer-events-none">verified_user</span>

                <div class="text-center border-b-2 border-gray-100 dark:border-gray-700 pb-8 mb-8">
                    <div class="inline-flex items-center justify-center p-3 bg-primary/10 rounded-full mb-4 text-primary">
                        <span class="material-symbols-outlined text-4xl">local_police</span>
                    </div>
                    <h1 class="text-3xl font-black text-ink dark:text-white uppercase tracking-widest">Certificado de Aptitud</h1>
                    <p class="text-sm font-bold text-ink-light mt-2 uppercase tracking-wide">Misión Michi - Colonia Felina</p>
                </div>

                <form action="CertificadoServlet" method="POST">
                    <input type="hidden" name="accion" value="guardar">
                    <input type="hidden" name="idGato" value="<%= g.getIdGato() %>">

                    <div class="space-y-8 relative z-10">
                        
                        <div class="text-lg leading-relaxed text-justify text-ink dark:text-gray-300">
                            <p class="mb-4">
                                Por la presente, el profesional veterinario 
                                <strong class="text-ink dark:text-white border-b border-gray-300">Dr. <%= u.getNombre() %></strong>, 
                                certifica que el paciente felino identificado como:
                            </p>
                            
                            <div class="bg-gray-50 dark:bg-black/20 p-6 rounded-xl border border-gray-200 dark:border-gray-700 grid grid-cols-2 gap-4 mb-4">
                                <div>
                                    <span class="text-xs font-bold text-ink-light uppercase">Nombre</span>
                                    <p class="text-xl font-bold"><%= g.getNombre() %></p>
                                </div>
                                <div>
                                    <span class="text-xs font-bold text-ink-light uppercase">ID Registro</span>
                                    <p class="text-xl font-bold">#<%= g.getIdGato() %></p>
                                </div>
                                <div>
                                    <span class="text-xs font-bold text-ink-light uppercase">Sexo</span>
                                    <p class="font-medium"><%= g.getSexo() %></p>
                                </div>
                                <div>
                                    <span class="text-xs font-bold text-ink-light uppercase">Color/Señas</span>
                                    <p class="font-medium"><%= g.getColor() %></p>
                                </div>
                            </div>

                            <p>
                                Se encuentra clínicamente <strong class="text-green-600 uppercase">SANO</strong>, habiendo completado satisfactoriamente sus controles médicos, esterilización y tratamientos requeridos. Se considera <strong>APTO</strong> para iniciar proceso de adopción.
                            </p>
                        </div>

                        <div>
                            <label class="block text-xs font-bold text-ink-light uppercase mb-2">Observaciones Médicas / Cuidados Especiales</label>
                            <textarea name="observaciones" rows="4" class="w-full rounded-xl border-gray-300 dark:border-gray-600 bg-white dark:bg-black/20 focus:ring-primary focus:border-primary p-4 shadow-sm" placeholder="Ej: Se recomienda dieta urinary de por vida. Vacunación anual al día."></textarea>
                        </div>

                        <div class="flex flex-col md:flex-row justify-between items-end pt-8 border-t border-gray-100 dark:border-gray-700 gap-6">
                            
                            <div class="w-full md:w-auto">
                                <label class="block text-xs font-bold text-ink-light uppercase mb-1">Fecha de Emisión</label>
                                <div class="flex items-center gap-2 text-ink font-bold text-lg">
                                    <span class="material-symbols-outlined text-primary">calendar_today</span>
                                    <%= LocalDate.now() %>
                                </div>
                            </div>

                            <div class="w-full md:w-auto">
                                <div class="flex items-center gap-3 mb-4">
                                    <input type="checkbox" required id="check-legal" class="w-5 h-5 rounded border-gray-300 text-primary focus:ring-primary cursor-pointer">
                                    <label for="check-legal" class="text-xs text-ink-light cursor-pointer select-none">
                                        Declaro bajo juramento profesional la veracidad de los datos.
                                    </label>
                                </div>
                                <button type="submit" class="w-full btn btn-primary py-3 px-8 rounded-xl font-bold shadow-lg shadow-primary/20 hover:scale-105 transition-transform flex items-center justify-center gap-2">
                                    <span class="material-symbols-outlined">history_edu</span>
                                    Firmar y Emitir Certificado
                                </button>
                            </div>
                        </div>

                    </div>
                </form>
            </div>
        </div>
    </main>
</body>
</html>