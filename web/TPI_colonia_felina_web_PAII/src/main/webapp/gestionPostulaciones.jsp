<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.util.List"%>
<%@page import="com.prog.tpi_colonia_felina_paii.modelo.Postulacion"%>
<%@page import="com.prog.tpi_colonia_felina_paii.enums.EstadoPostulacion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html class="light" lang="es">
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>Gestión de Adopciones - Misión Michi</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Manrope:wght@200..800&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        "primary": "#f97316",
                        "primary-hover": "#ea580c",
                    },
                    fontFamily: { "display": ["Manrope", "sans-serif"] },
                },
            },
        }
    </script>
</head>
<body class="bg-gray-50 font-display text-gray-800">

    <%
        List<Postulacion> lista = (List<Postulacion>) request.getAttribute("postulaciones");
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
    %>

    <div class="flex min-h-screen">
        
        <aside class="hidden lg:flex flex-col w-64 bg-white border-r border-gray-200 sticky top-0 h-screen p-4">
            <div class="flex items-center gap-3 mb-8 px-2 text-primary">
                <span class="material-symbols-outlined text-3xl">pets</span>
                <div class="flex flex-col">
                    <h1 class="font-bold text-lg leading-none">Misión Michi</h1>
                    <span class="text-xs text-gray-500">Panel Voluntario</span>
                </div>
            </div>
            <nav class="flex flex-col gap-2">
                <a href="GatoServlet?accion=listar" class="flex items-center gap-3 px-3 py-2 text-gray-600 hover:bg-orange-50 rounded-lg">
                    <span class="material-symbols-outlined">format_list_bulleted</span> Gatos
                </a>
                <a href="TareaServlet?accion=listar" class="flex items-center gap-3 px-3 py-2 text-gray-600 hover:bg-orange-50 rounded-lg">
                    <span class="material-symbols-outlined">assignment</span> Tareas
                </a>
                <a href="#" class="flex items-center gap-3 px-3 py-2 bg-primary/10 text-primary font-bold rounded-lg">
                    <span class="material-symbols-outlined">volunteer_activism</span> Adopciones
                </a>
            </nav>
        </aside>

        <main class="flex-1 p-6 md:p-10">
            
            <div class="flex justify-between items-center mb-8">
                <div>
                    <h1 class="text-3xl font-black text-gray-900">Solicitudes de Adopción</h1>
                    <p class="text-gray-500 mt-1">Revisa y gestiona las postulaciones de las familias.</p>
                </div>
            </div>

            <div class="flex flex-col gap-4">
                
                <% if (lista == null || lista.isEmpty()) { %>
                    <div class="flex flex-col items-center justify-center py-20 bg-white rounded-xl border border-dashed border-gray-300">
                        <span class="material-symbols-outlined text-6xl text-gray-300 mb-4">inbox</span>
                        <p class="text-gray-500 font-medium">No hay solicitudes de adopción pendientes.</p>
                    </div>
                <% } else { 
                    for(Postulacion p : lista) {
                        boolean esPendiente = p.getEstado() == EstadoPostulacion.PENDIENTE;
                        String cardClass = "bg-white border-gray-200";
                        String statusColor = "bg-yellow-100 text-yellow-800";
                        String icon = "hourglass_empty";
                        
                        if(p.getEstado() == EstadoPostulacion.ACEPTADA) {
                            cardClass = "bg-green-50 border-green-200";
                            statusColor = "bg-green-100 text-green-800";
                            icon = "check_circle";
                        } else if(p.getEstado() == EstadoPostulacion.RECHAZADA) {
                            cardClass = "bg-gray-50 border-gray-200 opacity-75";
                            statusColor = "bg-red-100 text-red-800";
                            icon = "cancel";
                        }
                %>
                
                <div class="<%= cardClass %> border rounded-xl p-6 shadow-sm transition-all hover:shadow-md flex flex-col md:flex-row gap-6">
                    
                    <div class="flex flex-row md:flex-col items-center md:items-start gap-4 md:w-1/6 min-w-[120px]">
                        <div class="w-16 h-16 md:w-24 md:h-24 rounded-full bg-gray-200 overflow-hidden flex-shrink-0 border-2 border-white shadow">
                            <% if(p.getGato().getFotografia() != null) { %>
                                <img src="<%= p.getGato().getFotografia() %>" class="w-full h-full object-cover">
                            <% } else { %>
                                <span class="material-symbols-outlined text-4xl text-gray-400 w-full h-full flex items-center justify-center">pets</span>
                            <% } %>
                        </div>
                        <div>
                            <p class="text-xs text-gray-500 uppercase font-bold">Solicitan a:</p>
                            <a href="GatoServlet?accion=verDetalle&id=<%= p.getGato().getIdGato() %>" class="font-bold text-lg hover:underline text-primary hover:text-primary-hover">
                                <%= p.getGato().getNombre() %>
                            </a>
                        </div>
                    </div>

                    <div class="flex-1 flex flex-col gap-3 border-l border-gray-100 md:pl-6 pl-0 border-0 md:border-l">
                        <div class="flex justify-between items-start">
                            <div>
                                <h3 class="font-bold text-gray-900 text-lg">
                                    Familia: <%= p.getFamiliaPostulante().getCodigoFamilia() %>
                                </h3>
                                <p class="text-sm text-gray-500">
                                    Solicitante: <span class="font-medium text-gray-700"><%= p.getMiembroPostulante().getNombre() %> <%= p.getMiembroPostulante().getApellido() %></span>
                                </p>
                            </div>
                            <span class="<%= statusColor %> px-3 py-1 rounded-full text-xs font-bold flex items-center gap-1 uppercase tracking-wide">
                                <span class="material-symbols-outlined text-base"><%= icon %></span>
                                <%= p.getEstado() %>
                            </span>
                        </div>
                        
                        <div class="grid grid-cols-2 gap-4 mt-2">
                            <div>
                                <p class="text-xs text-gray-400 font-bold uppercase">Fecha Solicitud</p>
                                <p class="text-sm font-medium"><%= p.getFecha().format(formatter) %></p>
                            </div>
                            <div>
                                <p class="text-xs text-gray-400 font-bold uppercase">Tipo Adopción</p>
                                <p class="text-sm font-medium"><%= p.getTipoAdopcion() %></p>
                            </div>
                        </div>

                        <div class="bg-white/50 p-3 rounded-lg border border-gray-100 mt-1">
                            <p class="text-xs text-gray-400 font-bold uppercase mb-1">Observaciones</p>
                            <p class="text-sm text-gray-600 italic">"<%= p.getObservacion() != null ? p.getObservacion() : "Sin observaciones." %>"</p>
                        </div>
                    </div>

                    <% if(esPendiente) { %>
                    <div class="flex md:flex-col flex-row gap-2 justify-center border-l border-gray-100 md:pl-6 pl-0 md:w-40 border-0 md:border-l">
                        
                        <form action="PostulacionServlet" method="POST" class="w-full">
                            <input type="hidden" name="idPostulacion" value="<%= p.getIdPostulacion() %>">
                            <input type="hidden" name="accion" value="aceptar">
                            <button type="submit" onclick="return confirm('¿Seguro que deseas ACEPTAR esta solicitud? El gato pasará a estado ADOPTADO.')"
                                    class="w-full px-4 py-2 bg-green-600 hover:bg-green-700 text-white rounded-lg font-bold text-sm flex items-center justify-center gap-2 shadow-sm transition-colors">
                                <span class="material-symbols-outlined text-lg">check</span> Aceptar
                            </button>
                        </form>

                        <form action="PostulacionServlet" method="POST" class="w-full">
                            <input type="hidden" name="idPostulacion" value="<%= p.getIdPostulacion() %>">
                            <input type="hidden" name="accion" value="rechazar">
                            <button type="submit" onclick="return confirm('¿Seguro que deseas RECHAZAR esta solicitud?')"
                                    class="w-full px-4 py-2 bg-white border border-red-200 text-red-600 hover:bg-red-50 rounded-lg font-bold text-sm flex items-center justify-center gap-2 transition-colors">
                                <span class="material-symbols-outlined text-lg">close</span> Rechazar
                            </button>
                        </form>

                    </div>
                    <% } else { %>
                        <div class="md:w-40 flex items-center justify-center md:border-l md:border-gray-100 md:pl-6 text-gray-400 text-xs text-center italic">
                            Solicitud cerrada
                        </div>
                    <% } %>

                </div>
                <%  } 
                   } %>

            </div>
        </main>
    </div>
</body>
</html>