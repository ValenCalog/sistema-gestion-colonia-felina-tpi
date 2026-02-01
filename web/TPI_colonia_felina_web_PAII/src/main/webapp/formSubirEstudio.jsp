<%@page import="com.prog.tpi_colonia_felina_paii.modelo.Gato"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Gato g = (Gato) request.getAttribute("gato");
    if(g == null) { response.sendRedirect("VeterinarioServlet?accion=inicio"); return; }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Subir Estudio - <%= g.getNombre() %></title>
    <jsp:include page="/WEB-INF/fragmentos/cabecera-estilos.jsp" />
</head>

<body class="bg-gray-50 dark:bg-black/20 font-sans text-ink dark:text-white antialiased flex flex-col min-h-screen">

    <jsp:include page="/WEB-INF/fragmentos/navbar-veterinario.jsp" />

    <main class="flex-grow p-4 md:p-8">
        <div class="max-w-2xl mx-auto">
            
            <div class="mb-6">
                <a href="VeterinarioServlet?accion=consultorio&idGato=<%= g.getIdGato() %>" class="flex items-center gap-2 text-ink-light hover:text-primary transition-colors text-sm font-bold">
                    <span class="material-symbols-outlined text-lg">arrow_back</span>
                    Volver a la Ficha
                </a>
            </div>

            <div class="bg-white dark:bg-surface-cardDark rounded-2xl shadow-sm border border-border-light dark:border-border-dark overflow-hidden">
                
                <div class="px-6 py-4 border-b border-gray-100 dark:border-gray-700 bg-gray-50/50 dark:bg-white/5">
                    <h1 class="text-xl font-black text-ink dark:text-white flex items-center gap-2">
                        <span class="material-symbols-outlined text-primary">upload_file</span>
                        Subir Estudio Médico
                    </h1>
                    <p class="text-sm text-ink-light mt-1">Paciente: <strong><%= g.getNombre() %></strong></p>
                </div>

                <div class="p-6">
                    <form action="EstudioMedicoServlet" method="POST" enctype="multipart/form-data" class="space-y-6">
                        <input type="hidden" name="accion" value="subir">
                        <input type="hidden" name="idGato" value="<%= g.getIdGato() %>">

                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <div>
                                <label class="label">Tipo de Estudio *</label>
                                <select name="tipoEstudio" class="input-field w-full" required>
                                    <option value="">Seleccione...</option>
                                    <option>Hemograma Completo</option>
                                    <option>Bioquímica Sanguínea</option>
                                    <option>Test VIF/Leucemia</option>
                                    <option>Radiografía</option>
                                    <option>Ecografía</option>
                                    <option>Citología/Biopsia</option>
                                    <option>Otro</option>
                                </select>
                            </div>
                            <div>
                                <label class="label">Fecha Realización *</label>
                                <input type="date" name="fecha" value="<%= java.time.LocalDate.now() %>" class="input-field w-full" required>
                            </div>
                        </div>

                        <div>
                            <label class="label">Observaciones / Conclusiones</label>
                            <textarea name="observaciones" rows="3" class="input-field w-full" placeholder="Ej: Valores de urea elevados. Se recomienda dieta renal."></textarea>
                        </div>

                        <div class="border-2 border-dashed border-gray-300 dark:border-gray-700 rounded-xl p-8 flex flex-col items-center justify-center text-center bg-gray-50 dark:bg-black/20 hover:bg-gray-100 transition-colors cursor-pointer relative group">
                            <input type="file" name="archivo" class="absolute inset-0 w-full h-full opacity-0 cursor-pointer" required accept=".pdf,.jpg,.jpeg,.png">
                            
                            <div class="group-hover:scale-110 transition-transform duration-200 mb-2">
                                <span class="material-symbols-outlined text-5xl text-gray-300 group-hover:text-primary">cloud_upload</span>
                            </div>
                            <p class="text-sm font-bold text-ink">Haga clic o arrastre el archivo aquí</p>
                            <p class="text-xs text-ink-light mt-1">Soporta PDF, JPG, PNG (Max 10MB)</p>
                        </div>

                        <div class="flex justify-end pt-2">
                            <button type="submit" class="btn btn-primary px-8 py-3 rounded-xl font-bold flex items-center gap-2 shadow-lg shadow-primary/20 hover:scale-105 transition-transform">
                                <span class="material-symbols-outlined">save</span>
                                Guardar Estudio
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </main>
</body>
</html>