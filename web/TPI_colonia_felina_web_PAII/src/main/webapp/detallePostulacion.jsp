<%@page import="com.prog.tpi_colonia_felina_paii.modelo.*"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es" class="light">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Evaluar Solicitud - Misión Michi</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Manrope:wght@200..800&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    
    <script>
        tailwind.config = {
            theme: {
                fontFamily: { sans: ["Manrope", "sans-serif"] },
                extend: { colors: { primary: "#f97316", "surface-light": "#f8fafc", ink: "#1e293b" } }
            }
        }
        
        function confirmarAccion(boton, accion) {
            let titulo = accion === 'aceptar' ? '¿Aprobar Adopción?' : '¿Rechazar Solicitud?';
            let colorBtn = accion === 'aceptar' ? '#22c55e' : '#ef4444';
            
            Swal.fire({
                title: titulo,
                text: "Esta acción actualizará el estado de la solicitud.",
                icon: 'question',
                showCancelButton: true,
                confirmButtonColor: colorBtn,
                confirmButtonText: 'Sí, confirmar'
            }).then((result) => {
                if (result.isConfirmed) boton.closest('form').submit();
            });
        }
    </script>
</head>
<body class="bg-surface-light text-ink font-sans min-h-screen p-6 md:p-10">

    <% 
        Postulacion p = (Postulacion) request.getAttribute("postulacion");
        Familia f = p.getFamiliaPostulante();
        Usuario solicitante = p.getMiembroPostulante(); // Recuperamos al usuario que postula
        DateTimeFormatter fmt = DateTimeFormatter.ofPattern("dd/MM/yyyy");
    %>

    <div class="max-w-6xl mx-auto">
        
        <div class="flex items-center gap-4 mb-8">
            <a href="PostulacionServlet?accion=listar" class="size-10 rounded-full bg-white border border-gray-200 flex items-center justify-center hover:bg-gray-50 transition-colors">
                <span class="material-symbols-outlined">arrow_back</span>
            </a>
            <div>
                <h1 class="text-2xl font-black">Evaluación de Solicitud #<%= p.getIdPostulacion() %></h1>
                <p class="text-gray-500">Revisa los detalles antes de tomar una decisión.</p>
            </div>
        </div>

        <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">

            <div class="space-y-6">
                <div class="bg-white p-6 rounded-2xl border border-gray-200 shadow-sm text-center">
                    <div class="w-40 h-40 mx-auto rounded-full overflow-hidden border-4 border-orange-100 mb-4">
                        <% if(p.getGato().getFotografia() != null) { %>
                            <img src="<%= p.getGato().getFotografia() %>" class="w-full h-full object-cover">
                        <% } else { %>
                            <div class="w-full h-full bg-gray-100 flex items-center justify-center"><span class="material-symbols-outlined text-4xl text-gray-400">pets</span></div>
                        <% } %>
                    </div>
                    <h2 class="text-xl font-bold"><%= p.getGato().getNombre() %></h2>
                    <p class="text-sm text-gray-500 font-bold uppercase"><%= p.getGato().getSexo() %> • <%= p.getGato().getColor() %></p>
                    
                    <div class="mt-4 pt-4 border-t border-gray-100 flex justify-between text-sm">
                        <div class="flex flex-col">
                            <span class="text-gray-400 text-xs font-bold uppercase">Estado Actual</span>
                            <span class="font-bold text-orange-600"><%= p.getGato().getDisponibilidad() %></span>
                        </div>
                        <div class="flex flex-col">
                            <span class="text-gray-400 text-xs font-bold uppercase">ID Gato</span>
                            <span class="font-bold text-gray-700">#<%= p.getGato().getIdGato() %></span>
                        </div>
                    </div>
                </div>

                <% if(p.getEstado().toString().equals("PENDIENTE")) { %>
                <div class="bg-white p-6 rounded-2xl border border-gray-200 shadow-sm space-y-3">
                    <h3 class="font-bold text-sm uppercase text-gray-400 mb-2">Dictamen</h3>
                    
                    <form action="PostulacionServlet" method="POST">
                        <input type="hidden" name="idPostulacion" value="<%= p.getIdPostulacion() %>">
                        <input type="hidden" name="accion" value="aceptar">
                        <button type="button" onclick="confirmarAccion(this, 'aceptar')" class="w-full py-3 bg-green-600 text-white rounded-xl font-bold shadow-lg shadow-green-200 hover:bg-green-700 transition-all flex justify-center gap-2">
                            <span class="material-symbols-outlined">check_circle</span> Aprobar Adopción
                        </button>
                    </form>

                    <form action="PostulacionServlet" method="POST">
                        <input type="hidden" name="idPostulacion" value="<%= p.getIdPostulacion() %>">
                        <input type="hidden" name="accion" value="rechazar">
                        <button type="button" onclick="confirmarAccion(this, 'rechazar')" class="w-full py-3 bg-white border border-red-200 text-red-600 rounded-xl font-bold hover:bg-red-50 transition-all flex justify-center gap-2">
                            <span class="material-symbols-outlined">cancel</span> Rechazar
                        </button>
                    </form>
                </div>
                <% } else { %>
                    <div class="bg-gray-100 p-6 rounded-2xl border border-gray-200 text-center text-gray-500">
                        <span class="material-symbols-outlined text-4xl mb-2">lock</span>
                        <p class="font-bold">Solicitud Cerrada</p>
                        <p class="text-sm">Estado: <%= p.getEstado() %></p>
                    </div>
                <% } %>
            </div>

            <div class="lg:col-span-2 space-y-6">
                
                <div class="bg-white p-8 rounded-2xl border border-gray-200 shadow-sm">
                    <h3 class="text-lg font-bold mb-6 flex items-center gap-2">
                        <span class="material-symbols-outlined text-orange-500">description</span> Datos de la Solicitud
                    </h3>
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-6">
                        <div>
                            <p class="text-xs font-bold text-gray-400 uppercase">Fecha de Solicitud</p>
                            <p class="text-lg font-medium"><%= p.getFecha().format(fmt) %></p>
                        </div>
                        <div>
                            <p class="text-xs font-bold text-gray-400 uppercase">Tipo de Adopción</p>
                            <span class="px-3 py-1 bg-orange-100 text-orange-700 rounded-lg text-sm font-bold border border-orange-200">
                                <%= p.getTipoAdopcion().toString().replace("_", " ") %>
                            </span>
                        </div>
                    </div>
                    <div>
                        <p class="text-xs font-bold text-gray-400 uppercase mb-2">Carta de Intención (Mensaje del Postulante)</p>
                        <div class="bg-gray-50 p-4 rounded-xl border border-gray-100 italic text-gray-600">
                            "<%= p.getObservacion() != null ? p.getObservacion() : "Sin comentarios." %>"
                        </div>
                    </div>
                </div>

                <div class="bg-white p-8 rounded-2xl border border-gray-200 shadow-sm relative overflow-hidden">
                    <div class="absolute top-0 right-0 p-4 opacity-5">
                        <span class="material-symbols-outlined text-8xl">diversity_3</span>
                    </div>

                    <h3 class="text-lg font-bold mb-6 flex items-center gap-2">
                        <span class="material-symbols-outlined text-blue-500">home</span> Perfil de la Familia
                    </h3>

                    <div class="grid grid-cols-1 md:grid-cols-2 gap-y-6 gap-x-8 mb-8">
                        <div>
                            <p class="text-xs font-bold text-gray-400 uppercase">Código Familia</p>
                            <p class="text-lg font-bold text-gray-800"><%= f.getCodigoFamilia() %></p>
                        </div>
                        <div>
                            <p class="text-xs font-bold text-gray-400 uppercase">Disponibilidad</p>
                            <p class="text-lg font-medium"><%= f.getDisponibilidad() != null ? f.getDisponibilidad() : "No definida" %></p>
                        </div>
                         
                        <div>
                            <p class="text-xs font-bold text-gray-400 uppercase">Solicitante Principal</p>
                            <p class="text-lg font-medium"><%= solicitante.getNombre() %> <%= solicitante.getApellido() %></p>
                            <p class="text-sm text-gray-500 flex items-center gap-1 mt-1">
                                <span class="material-symbols-outlined text-xs">mail</span> <%= solicitante.getCorreo() %>
                            </p>
                        </div>
                        <div>
                            <p class="text-xs font-bold text-gray-400 uppercase">Teléfono de Contacto</p>
                            <p class="text-lg font-medium flex items-center gap-2">
                                <span class="material-symbols-outlined text-gray-400 text-sm">call</span>
                                <%= solicitante.getTelefono() != null ? solicitante.getTelefono() : "No registrado" %>
                            </p>
                        </div>
                        
                        <div class="md:col-span-2">
                            <p class="text-xs font-bold text-gray-400 uppercase">Dirección Registrada</p>
                            <p class="text-lg font-medium">
                                <%= f.getDireccion() != null ? f.getDireccion() : "<span class='text-red-400'>No especificada</span>" %>
                            </p>
                        </div>
                    </div>
                    
                    <div class="mb-8">
                        <p class="text-xs font-bold text-gray-400 uppercase mb-2">Observaciones de la Familia</p>
                        <div class="bg-blue-50/50 p-4 rounded-xl border border-blue-100 text-gray-700">
                             <%= f.getObservaciones() != null && !f.getObservaciones().isEmpty() ? f.getObservaciones() : "No hay observaciones familiares registradas." %>
                        </div>
                    </div>

                    <div class="border-t border-gray-100 pt-6">
                        <p class="text-xs font-bold text-gray-400 uppercase mb-4">Integrantes Registrados</p>
                        <div class="flex flex-wrap gap-3">
                            <% if(f.getMiembrosFamilia() != null) { 
                                for(Usuario miembro : f.getMiembrosFamilia()) { %>
                                <div class="flex items-center gap-2 bg-gray-50 px-3 py-2 rounded-lg border border-gray-100">
                                    <div class="size-6 rounded-full bg-blue-100 text-blue-600 flex items-center justify-center text-xs font-bold uppercase">
                                        <%= miembro.getNombre().substring(0,1) %>
                                    </div>
                                    <div class="flex flex-col">
                                        <span class="text-sm font-medium leading-none"><%= miembro.getNombre() %></span>
                                        <% if(miembro.getRol() != null) { %>
                                            <span class="text-[10px] text-gray-400"><%= miembro.getRol() %></span>
                                        <% } %>
                                    </div>
                                </div>
                            <% } } %>
                        </div>
                    </div>

                </div>
            </div>

        </div>
    </div>

</body>
</html>