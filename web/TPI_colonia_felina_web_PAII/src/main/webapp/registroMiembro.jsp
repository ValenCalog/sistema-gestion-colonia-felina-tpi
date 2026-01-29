<%@page import="com.prog.tpi_colonia_felina_paii.modelo.Usuario"%>
<%@page import="java.util.List"%>
<%@page import="com.prog.tpi_colonia_felina_paii.modelo.Familia"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Recuperamos la familia que encontramos en el paso anterior (Servlet Unirse)
    Familia familiaDestino = (Familia) request.getAttribute("familiaDestino");
    
    // Si por error alguien entra directo aquí sin pasar por la validación, lo sacamos
    if (familiaDestino == null) {
        response.sendRedirect("unirseFamilia.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Completar Registro</title>
    
    <jsp:include page="/WEB-INF/fragmentos/cabecera-estilos.jsp" />
</head>
<body class="bg-surface-light dark:bg-surface-dark font-sans text-ink dark:text-white antialiased min-h-screen flex flex-col">

    <header class="sticky top-0 z-50 flex items-center justify-between border-b border-border-light dark:border-border-dark bg-surface-card/90 dark:bg-surface-dark/90 backdrop-blur-md px-6 py-4">
        <div class="flex items-center gap-4">
            <div class="size-8 text-primary flex items-center justify-center">
                <span class="material-symbols-outlined text-3xl">pets</span>
            </div>
            <h2 class="text-lg font-bold tracking-tight">Misión Michi</h2>
        </div>
        
        <div class="flex items-center gap-4">
            <span class="text-sm font-medium hidden md:block text-ink-light">Paso 2 de 2</span>
        </div>
    </header>

    <main class="flex-1 flex justify-center py-10 px-4 sm:px-6">
        <div class="max-w-[1100px] w-full flex flex-col gap-8">
            
            <div class="text-center">
                <h1 class="heading-xl !text-3xl sm:!text-4xl mb-2">Únete a la Familia</h1>
                <p class="text-body">Solo un paso más para empezar a colaborar con el grupo.</p>
            </div>

            <div class="w-full bg-surface-card dark:bg-surface-cardDark border border-primary/20 rounded-xl p-6 shadow-sm flex flex-col sm:flex-row items-start sm:items-center justify-between gap-4 animate-fade-in">
                <div class="flex items-center gap-4">
                    <div class="bg-primary/10 p-3 rounded-full text-primary">
                        <span class="material-symbols-outlined block text-2xl">home_health</span>
                    </div>
                    <div class="flex flex-col">
                        <p class="text-lg font-bold text-ink dark:text-white">
                            Familia en: <%= familiaDestino.getDireccion() %>
                        </p>
                        <p class="text-sm text-ink-light">
                            Código validado correctamente.
                        </p>
                    </div>
                </div>
                <div class="flex items-center gap-2 bg-green-100 text-green-700 px-4 py-2 rounded-lg font-bold text-xs border border-green-200">
                    <span class="material-symbols-outlined text-base">verified</span>
                    <span>VERIFICADO</span>
                </div>
            </div>

            <div class="flex flex-col lg:flex-row gap-8">
                
                <div class="flex-1 bg-surface-card dark:bg-surface-cardDark p-8 rounded-xl border border-border-light dark:border-border-dark shadow-sm">
                    <div class="mb-8 border-b border-border-light dark:border-border-dark pb-4">
                        <h2 class="text-xl font-bold mb-1">Información Personal</h2>
                        <p class="text-sm text-ink-light">Completa tu perfil para que tus compañeros te reconozcan.</p>
                    </div>

                    <form action="RegistroMiembroServlet" method="POST" class="flex flex-col gap-6">
                        
                        <input type="hidden" name="idFamilia" value="<%= familiaDestino.getIdFamilia() %>" />

                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <label class="flex flex-col gap-2">
                                <span class="text-sm font-bold">Nombre *</span>
                                <input class="input-field" name="nombre" placeholder="Ej. María" type="text" required />
                            </label>
                            
                            <label class="flex flex-col gap-2">
                                <span class="text-sm font-bold">Apellido *</span>
                                <input class="input-field" name="apellido" placeholder="Ej. Gomez" type="text" required />
                            </label>

                            <label class="flex flex-col gap-2">
                                <span class="text-sm font-bold">DNI *</span>
                                <input class="input-field" name="dni" placeholder="Sin puntos" type="number" required />
                            </label>

                            <label class="flex flex-col gap-2">
                                <span class="text-sm font-bold">Teléfono *</span>
                                <input class="input-field" name="telefono" placeholder="3764..." type="tel" required />
                            </label>

                            <label class="flex flex-col gap-2 md:col-span-2">
                                <span class="text-sm font-bold">Correo Electrónico *</span>
                                <input class="input-field" name="email" placeholder="usuario@email.com" type="email" required />
                            </label>

                            <label class="flex flex-col gap-2 md:col-span-2">
                                <span class="text-sm font-bold">Contraseña *</span>
                                <div class="relative">
                                    <input class="input-field pr-10" name="password" placeholder="••••••••" type="password" required />
                                    <span class="material-symbols-outlined absolute right-3 top-1/2 -translate-y-1/2 text-gray-400">lock</span>
                                </div>
                            </label>
                        </div>

                        <button type="submit" class="mt-4 btn btn-primary w-full h-14 text-base shadow-lg shadow-primary/20">
                            <span>Completar Registro</span>
                            <span class="material-symbols-outlined ml-2">arrow_forward</span>
                        </button>
                    </form>
                </div>

                <div class="w-full lg:w-[320px] flex flex-col gap-6">
                    <div class="bg-surface-card dark:bg-surface-cardDark rounded-xl border border-border-light dark:border-border-dark shadow-sm overflow-hidden">
                        <div class="bg-surface-light dark:bg-surface-dark p-5 border-b border-border-light dark:border-border-dark">
                            <h3 class="font-bold flex items-center gap-2">
                                <span class="material-symbols-outlined text-primary">group</span>
                                Futuros Compañeros
                            </h3>
                            <p class="text-xs text-ink-light mt-1">
                                Te unirás a <%= familiaDestino.getMiembrosFamilia().size() %> personas más.
                            </p>
                        </div>
                        
                        <div class="p-5 flex flex-col gap-5 max-h-[400px] overflow-y-auto">
                            <% 
                                List<Usuario> miembros = familiaDestino.getMiembrosFamilia();
                                if (miembros != null && !miembros.isEmpty()) {
                                    for (Usuario miembro : miembros) {
                            %>
                                <div class="flex items-center gap-3">
                                    <div class="size-10 rounded-full bg-primary/10 flex items-center justify-center text-primary font-bold text-sm border border-primary/20">
                                        <%= miembro.getNombre().substring(0, 1) %><%= miembro.getApellido().substring(0, 1) %>
                                    </div>
                                    <div class="flex flex-col">
                                        <p class="text-sm font-bold"><%= miembro.getNombre() %> <%= miembro.getApellido() %></p>
                                        <p class="text-[10px] text-ink-light uppercase font-bold tracking-wider">
                                            <%= miembro.getRol().toString() %>
                                        </p>
                                    </div>
                                </div>
                            <% 
                                    }
                                } else { 
                            %>
                                <div class="text-center py-4 text-sm text-ink-light">
                                    <p>Esta casa aún no tiene otros miembros.</p>
                                    <p class="text-xs mt-1">¡Serás el primero después del admin!</p>
                                </div>
                            <% } %>
                        </div>
                    </div>

                    <div class="bg-surface-dark p-5 rounded-xl text-white relative overflow-hidden">
                        <div class="absolute -right-4 -top-4 text-white/5">
                            <span class="material-symbols-outlined text-[100px]">help</span>
                        </div>
                        
                        <h4 class="font-bold mb-2 flex items-center gap-2 relative z-10">
                            <span class="material-symbols-outlined text-primary">support_agent</span>
                            ¿Código incorrecto?
                        </h4>
                        <p class="text-xs text-gray-400 leading-relaxed relative z-10">
                            Si esta no es la familia que esperabas (Dirección: <%= familiaDestino.getDireccion() %>), vuelve atrás y pide el código nuevamente.
                        </p>
                        <a href="unirseFamilia.jsp" class="inline-block mt-4 text-xs font-bold text-primary hover:underline relative z-10">
                            ← Volver a ingresar código
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </main>

</body>
</html>