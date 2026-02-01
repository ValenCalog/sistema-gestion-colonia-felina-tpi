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
                    <form action="EstudioMedicoServlet" method="POST" enctype="multipart/form-data" class="space-y-5">
                        <input type="hidden" name="accion" value="subir">
                        <input type="hidden" name="idGato" value="<%= g.getIdGato() %>">

                        <div class="grid grid-cols-1 md:grid-cols-2 gap-5">
                            
                            <div>
                                <label class="block mb-2 text-sm font-bold text-ink dark:text-white">Tipo de Estudio *</label>
                                
                                <input type="text" name="tipoEstudio" list="lista-estudios" required 
                                       class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-primary focus:border-primary block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white" 
                                       placeholder="Seleccione o escriba uno nuevo...">

                                <datalist id="lista-estudios">
                                    <option value="Hemograma Completo">
                                    <option value="Bioquímica Sanguínea">
                                    <option value="Test VIF/Leucemia">
                                    <option value="Radiografía">
                                    <option value="Ecografía">
                                    <option value="Citología/Biopsia">
                                    <option value="Urianálisis">
                                </datalist>
                            </div>

                            <div>
                                <label class="block mb-2 text-sm font-bold text-ink dark:text-white">Fecha Realización *</label>
                                <input type="date" name="fecha" value="<%= java.time.LocalDate.now() %>" required
                                       class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-primary focus:border-primary block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:text-white">
                            </div>
                        </div>

                        <div>
                            <label class="block mb-2 text-sm font-bold text-ink dark:text-white">Observaciones / Conclusiones</label>
                            <textarea name="observaciones" rows="3" 
                                      class="block p-2.5 w-full text-sm text-gray-900 bg-gray-50 rounded-lg border border-gray-300 focus:ring-primary focus:border-primary dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white" 
                                      placeholder="Ej: Valores de urea elevados. Se recomienda dieta renal."></textarea>
                        </div>

                        <div class="flex items-center justify-center w-full">
                            <label for="dropzone-file" class="flex flex-col items-center justify-center w-full h-32 border-2 border-gray-300 border-dashed rounded-lg cursor-pointer bg-gray-50 dark:hover:bg-bray-800 dark:bg-gray-700 hover:bg-gray-100 dark:border-gray-600 dark:hover:border-gray-500 dark:hover:bg-gray-600 transition-colors group">
                                <div class="flex flex-col items-center justify-center pt-5 pb-6">
                                    <span class="material-symbols-outlined text-3xl text-gray-400 mb-2 group-hover:text-primary transition-colors">cloud_upload</span>
                                    <p class="text-sm text-gray-500 dark:text-gray-400"><span class="font-bold">Click para subir</span> o arrastra el archivo</p>
                                    <p class="text-xs text-gray-500 dark:text-gray-400">PDF, JPG o PNG (MAX. 10MB)</p>
                                </div>
                                <input id="dropzone-file" type="file" name="archivo" class="hidden" required accept=".pdf,.jpg,.jpeg,.png" onchange="mostrarNombreArchivo(this)" />
                            </label>
                        </div>
                        <p id="nombre-archivo" class="text-xs text-center text-primary font-bold h-4"></p>

                        <div class="flex justify-end pt-2">
                            <button type="submit" class="text-white bg-primary hover:bg-blue-700 focus:ring-4 focus:ring-blue-300 font-bold rounded-lg text-sm px-5 py-2.5 mr-2 mb-2 dark:bg-blue-600 dark:hover:bg-blue-700 focus:outline-none dark:focus:ring-blue-800 flex items-center gap-2 shadow-md transition-transform hover:scale-105">
                                <span class="material-symbols-outlined text-[18px]">save</span>
                                Guardar Estudio
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </main>

    <script>
        function mostrarNombreArchivo(input) {
            const nombre = input.files[0] ? input.files[0].name : "";
            document.getElementById('nombre-archivo').textContent = nombre ? "Archivo seleccionado: " + nombre : "";
        }
    </script>
</body>
</html>