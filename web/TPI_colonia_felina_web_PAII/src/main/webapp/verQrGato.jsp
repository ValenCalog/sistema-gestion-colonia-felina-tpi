<%@page import="com.prog.tpi_colonia_felina_paii.modelo.Gato"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Gato gato = (Gato) request.getAttribute("gato");
    if (gato == null) {
        response.sendRedirect("GatoServlet?accion=listar");
        return;
    }
%>
<!DOCTYPE html>
<html lang="es" class="light">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Código QR - <%= gato.getNombre() %></title>
    
    <jsp:include page="/WEB-INF/fragmentos/cabecera-estilos.jsp" />

    <style>
        /* Estilos para impresion */
        @media print {
            body {
                background-color: white !important;
                color: black !important;
            }
            .no-print {
                display: none !important;
            }
            #ficha-qr {
                border: 2px solid black !important;
                box-shadow: none !important;
                width: 100% !important;
                max-width: 400px !important;
                margin: 0 auto !important;
                page-break-inside: avoid;
            }
            /* Centrar contenido en la hoja */
            main {
                display: flex;
                align-items: center;
                justify-content: center;
                height: 100vh;
            }
        }
    </style>
</head>
<body class="bg-surface-light dark:bg-surface-dark font-sans text-ink dark:text-white flex flex-col min-h-screen">

    <div class="no-print">
        <jsp:include page="/WEB-INF/fragmentos/navbar-voluntario.jsp" />
    </div>

    <main class="flex-1 flex flex-col items-center justify-center p-6">
        
        <div class="mb-6 text-center no-print">
            <h1 class="text-2xl font-bold mb-2">Ficha Generada con Éxito 🎉</h1>
            <p class="text-ink-light">Listo para imprimir y colocar.</p>
        </div>

        <div id="ficha-qr" class="bg-white text-ink p-8 rounded-2xl shadow-xl border-2 border-dashed border-gray-300 w-full max-w-sm text-center">
            
            <div class="mb-4">
                <h2 class="text-3xl font-black uppercase tracking-tight"><%= gato.getNombre() %></h2>
                <span class="inline-block bg-black text-white text-sm font-bold px-3 py-1 rounded-full mt-2">
                    ID: #<%= gato.getIdGato() %>
                </span>
            </div>

            <div class="bg-white p-2 inline-block rounded-lg mb-4">
                <% if(gato.getQrCodePath() != null) { %>
                    <img src="<%= request.getContextPath() + gato.getQrCodePath() %>" 
                         alt="QR <%= gato.getNombre() %>" 
                         class="w-64 h-64 object-contain mx-auto border-4 border-white shadow-sm">
                <% } else { %>
                    <div class="w-64 h-64 bg-gray-200 flex items-center justify-center text-gray-500">
                        QR No Disponible
                    </div>
                <% } %>
            </div>

            <div class="text-sm font-bold text-gray-500 uppercase tracking-widest mb-6">
                Misión Michi
            </div>

            <div class="border-t-2 border-gray-100 pt-4 flex justify-between text-left text-sm">
                <div>
                    <p class="text-gray-400 text-xs font-bold uppercase">Sexo</p>
                    <p class="font-bold"><%= gato.getSexo() %></p>
                </div>
                <div class="text-right">
                    <p class="text-gray-400 text-xs font-bold uppercase">Ubicación</p>
                    <p class="font-bold"><%= (gato.getZona() != null) ? gato.getZona().getNombre() : "Sin Zona" %></p>
                </div>
            </div>
        </div>

        <div class="mt-8 flex gap-4 no-print">
            <a href="GatoServlet?accion=listar" class="px-6 py-3 rounded-xl border border-gray-300 dark:border-gray-600 font-bold hover:bg-gray-100 dark:hover:bg-white/5 transition-colors">
                Volver al Listado
            </a>
            <button onclick="window.print()" class="px-6 py-3 rounded-xl bg-primary hover:bg-primary-hover text-white font-bold shadow-lg shadow-primary/30 transition-all flex items-center gap-2">
                <span class="material-symbols-outlined">print</span>
                Imprimir Ficha
            </button>
        </div>

    </main>

</body>
</html>