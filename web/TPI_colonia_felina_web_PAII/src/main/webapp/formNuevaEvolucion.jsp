<%@page import="java.time.LocalDate"%>
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
    <title>Nueva Diagnóstico y Tratamientos - <%= g.getNombre() %></title>
    <jsp:include page="/WEB-INF/fragmentos/cabecera-estilos.jsp" />
</head>

<body class="bg-gray-50 dark:bg-black/20 font-sans text-ink dark:text-white antialiased flex flex-col min-h-screen">

    <jsp:include page="/WEB-INF/fragmentos/navbar-veterinario.jsp" />

    <main class="flex-grow p-4 md:p-8">
        <div class="max-w-4xl mx-auto">
            
            <div class="flex items-center gap-4 mb-6">
                <a href="VeterinarioServlet?accion=consultorio&idGato=<%= g.getIdGato() %>" class="size-10 rounded-full bg-white border border-gray-200 flex items-center justify-center hover:text-primary transition-colors shadow-sm">
                    <span class="material-symbols-outlined">arrow_back</span>
                </a>
                <div>
                    <h1 class="text-2xl font-black text-ink dark:text-white">Registrar Evolución Clínica</h1>
                    <p class="text-sm text-ink-light">Paciente: <strong><%= g.getNombre() %></strong> (ID: <%= g.getIdGato() %>)</p>
                </div>
            </div>

            <form action="HistoriaClinicaServlet" method="POST" class="space-y-8">
                <input type="hidden" name="accion" value="guardarEvolucionCompleta">
                <input type="hidden" name="idGato" value="<%= g.getIdGato() %>">

                <div class="bg-white dark:bg-surface-cardDark p-6 rounded-2xl shadow-sm border border-border-light dark:border-border-dark">
                    <h2 class="font-bold text-lg mb-4 flex items-center gap-2 pb-2 border-b border-gray-100 dark:border-gray-800 text-primary">
                        <span class="material-symbols-outlined">clinical_notes</span>
                        Datos del Diagnóstico
                    </h2>
                    
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-4">
                        <div>
                            <label class="block text-xs font-bold uppercase text-ink-light mb-1">Descripción Detallada *</label>
                            <input type="text" name="descDetallada" required placeholder="Ej: Rinotraqueítis viral felina" 
                                   class="w-full rounded-xl border-gray-200 bg-gray-50 dark:bg-black/20 focus:ring-primary text-sm p-3">
                        </div>
                        <div>
                            <label class="block text-xs font-bold uppercase text-ink-light mb-1">Fecha Diagnóstico</label>
                            <input type="date" name="fechaDiagnostico" value="<%= LocalDate.now() %>" required
                                   class="w-full rounded-xl border-gray-200 bg-gray-50 dark:bg-black/20 focus:ring-primary text-sm p-3">
                        </div>
                    </div>

                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-4">
                        <div>
                            <label class="block text-xs font-bold uppercase text-ink-light mb-1">Estado Clínico Actual</label>
                            <select name="estadoClinico" class="w-full rounded-xl border-gray-200 bg-gray-50 dark:bg-black/20 focus:ring-primary text-sm p-3">
                                <option value="EN_TRATAMIENTO" <%= g.getEstadoSalud().toString().equals("EN_TRATAMIENTO") ? "selected" : "" %>>En Tratamiento</option>
                                <option value="ENFERMO" <%= g.getEstadoSalud().toString().equals("ENFERMO") ? "selected" : "" %>>Enfermo (Crítico)</option>
                                <option value="SANO">Sano (Alta Médica)</option>
                            </select>
                        </div>
                        <div>
                            <label class="block text-xs font-bold uppercase text-ink-light mb-1">Veterinario Responsable</label>
                            <input type="text" value="Dr. <%= ((com.prog.tpi_colonia_felina_paii.modelo.Usuario)session.getAttribute("usuarioLogueado")).getNombre() %>" disabled
                                   class="w-full rounded-xl border-gray-200 bg-gray-100 dark:bg-white/5 text-gray-500 text-sm p-3 cursor-not-allowed">
                        </div>
                    </div>

                    <div>
                        <label class="block text-xs font-bold uppercase text-ink-light mb-1">Observaciones Generales</label>
                        <textarea name="observacionesDiagnostico" rows="3" placeholder="Detalle de síntomas, temperatura, peso, estado de ánimo..." 
                                  class="w-full rounded-xl border-gray-200 bg-gray-50 dark:bg-black/20 focus:ring-primary text-sm p-3"></textarea>
                    </div>
                </div>

                <div class="bg-white dark:bg-surface-cardDark p-6 rounded-2xl shadow-sm border border-border-light dark:border-border-dark relative overflow-hidden">
                    <div class="flex justify-between items-center mb-4 pb-2 border-b border-gray-100 dark:border-gray-800">
                        <h2 class="font-bold text-lg flex items-center gap-2 text-amber-600">
                            <span class="material-symbols-outlined">pill</span>
                            Tratamientos e Indicaciones
                        </h2>
                        <button type="button" onclick="agregarTratamiento()" class="text-xs font-bold bg-amber-50 text-amber-700 px-3 py-2 rounded-lg hover:bg-amber-100 transition-colors flex items-center gap-1 border border-amber-200">
                            <span class="material-symbols-outlined text-sm">add</span> Agregar Item
                        </button>
                    </div>

                    <div id="lista-tratamientos" class="space-y-3">
                        <div class="tratamiento-row grid grid-cols-1 md:grid-cols-12 gap-3 p-4 bg-gray-50 dark:bg-black/20 rounded-xl border border-gray-200 dark:border-gray-700 relative group">
                            
                            <div class="md:col-span-4">
                                <label class="text-[10px] font-bold uppercase text-gray-400">Descripción *</label>
                                <input type="text" name="tratamientoDescripcion[]" placeholder="Ej: Inyección antibiótico" required
                                       class="w-full text-sm rounded-lg border-gray-200 focus:ring-amber-500 mt-1">
                            </div>
                            <div class="md:col-span-4">
                                <label class="text-[10px] font-bold uppercase text-gray-400">Medicación (Droga)</label>
                                <input type="text" name="tratamientoMedicacion[]" placeholder="Ej: Amoxicilina 50mg" 
                                       class="w-full text-sm rounded-lg border-gray-200 focus:ring-amber-500 mt-1">
                            </div>
                            <div class="md:col-span-3">
                                <label class="text-[10px] font-bold uppercase text-gray-400">Observaciones</label>
                                <input type="text" name="tratamientoObservaciones[]" placeholder="Dosis / Vía" 
                                       class="w-full text-sm rounded-lg border-gray-200 focus:ring-amber-500 mt-1">
                            </div>
                            
                            <div class="md:col-span-1 flex items-end justify-center pb-1">
                                <button type="button" onclick="eliminarFila(this)" class="text-gray-400 hover:text-red-500 p-2 rounded-lg hover:bg-red-50 transition-colors" title="Quitar fila">
                                    <span class="material-symbols-outlined">delete</span>
                                </button>
                            </div>
                        </div>
                    </div>
                    
                    <p class="text-xs text-ink-light mt-4 italic">* Puede agregar múltiples tratamientos o procedimientos asociados a este diagnóstico.</p>
                </div>

                <div class="flex justify-end pt-4">
                    <button type="submit" class="bg-primary hover:bg-blue-600 text-white font-bold py-3 px-8 rounded-xl shadow-lg shadow-primary/30 flex items-center gap-2 transition-all transform hover:scale-105">
                        <span class="material-symbols-outlined">save</span>
                        Guardar Historia Clínica Completa
                    </button>
                </div>

            </form>
        </div>
    </main>

    <script>
        function agregarTratamiento() {
            const container = document.getElementById('lista-tratamientos');
            // clonamos la primera fila (plantilla)
            const firstRow = container.querySelector('.tratamiento-row');
            const clone = firstRow.cloneNode(true);
            
            // limpiamos los valores de los inputs del clon
            const inputs = clone.querySelectorAll('input');
            inputs.forEach(input => input.value = '');
            
            // agregamos al final
            container.appendChild(clone);
        }

        function eliminarFila(btn) {
            const container = document.getElementById('lista-tratamientos');
            const rows = container.querySelectorAll('.tratamiento-row');
            
            if (rows.length > 1) {
                // si hay más de una fila, permitimos borrar
                btn.closest('.tratamiento-row').remove();
            } else {
                alert("Debe haber al menos un tratamiento o procedimiento registrado.");
            }
        }
    </script>

</body>
</html>