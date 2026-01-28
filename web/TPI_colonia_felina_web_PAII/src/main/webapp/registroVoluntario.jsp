<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Registro de Voluntarios</title>
    
    <jsp:include page="/WEB-INF/fragmentos/cabecera-estilos.jsp" />
    
    <style>
        /* Estilo extra para el panel izquierdo fijo */
        .sticky-left-panel {
            position: sticky;
            top: 0;
            height: 100vh;
        }
    </style>
</head>
<body class="bg-surface-light dark:bg-surface-dark font-sans text-ink dark:text-white antialiased overflow-hidden">

    <div class="flex min-h-screen w-full flex-row">
        
        <div class="hidden lg:flex lg:w-5/12 xl:w-1/2 relative flex-col justify-end p-12 sticky-left-panel">
            <div class="absolute inset-0 z-0 bg-cover bg-center" 
                 style="background-image: url('https://images.unsplash.com/photo-1718278107548-5558a3a8379a?q=80&w=735&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D');">
            </div>
            <div class="absolute inset-0 z-10 bg-gradient-to-t from-black/90 via-black/40 to-transparent"></div>
            
            <div class="relative z-20 flex flex-col gap-6 text-white max-w-lg animate-fade-in">
                <div class="flex items-center gap-3 text-primary mb-2">
                    <span class="material-symbols-outlined filled text-4xl">volunteer_activism</span>
                    <h3 class="text-xl font-bold tracking-wide uppercase">Voluntariado</h3>
                </div>
                <h1 class="text-5xl font-black leading-tight tracking-tight text-white shadow-black drop-shadow-lg">
                    Sé el héroe <br/>que necesitan.
                </h1>
                <p class="text-lg text-gray-200 font-medium leading-relaxed opacity-90">
                    Tu tiempo transforma vidas. Únete a nuestra comunidad de cuidadores y marca una diferencia real en tu barrio.
                </p>
                
                <div class="flex gap-4 mt-4">
                    <div class="flex items-center gap-2 bg-white/10 backdrop-blur-md px-4 py-2 rounded-full border border-white/20">
                        <span class="material-symbols-outlined text-primary text-sm">location_on</span>
                        <span class="text-sm font-semibold">Posadas, Misiones</span>
                    </div>
                </div>
            </div>
        </div>

        <div class="flex-1 h-screen overflow-y-auto bg-surface-card dark:bg-surface-dark relative">
            
            <div class="lg:hidden h-48 relative w-full bg-cover bg-center" 
                 style="background-image: url('https://images.unsplash.com/photo-1469571486292-0ba58a3f068b?q=80&w=800&auto=format&fit=crop');">
                <div class="absolute inset-0 bg-gradient-to-t from-black/80 to-transparent flex flex-col justify-end p-6">
                    <h1 class="text-3xl font-black text-white leading-tight">Únete al equipo.</h1>
                </div>
            </div>

            <div class="flex flex-col items-center w-full py-10 px-4 md:px-12 lg:px-16 xl:px-24">
                <div class="max-w-[640px] w-full flex flex-col gap-8">
                    
                    <div class="flex flex-col gap-2 border-b border-border-light dark:border-border-dark pb-6">
                        <a href="seleccionRol.jsp" class="flex items-center gap-2 text-primary lg:hidden mb-2 font-bold text-sm">
                            <span class="material-symbols-outlined text-lg">arrow_back</span>
                            Volver
                        </a>
                        <h2 class="heading-xl text-3xl">Registro de Voluntario</h2>
                        <p class="text-body">Completa tus datos para ser un cuidador verificado.</p>
                    </div>

                    <% if (request.getAttribute("error") != null) { %>
                        <div class="p-4 bg-red-100 border border-red-400 text-red-700 rounded-lg flex items-center gap-2">
                            <span class="material-symbols-outlined">error</span>
                            <span><%= request.getAttribute("error") %></span>
                        </div>
                    <% } %>

                    <form action="RegistroVoluntarioServlet" method="POST" class="flex flex-col gap-6">
                        
                        <div class="flex flex-col gap-5">
                            <div class="flex items-center gap-3">
                                <div class="icon-circle size-8 text-sm font-bold">1</div>
                                <h3 class="text-lg font-bold">¿Quién eres?</h3>
                            </div>
                            
                            <div class="grid grid-cols-1 md:grid-cols-2 gap-5">
                                <label class="flex flex-col gap-2">
                                    <span class="text-sm font-bold">Nombre *</span>
                                    <div class="relative group">
                                        <span class="material-symbols-outlined input-icon">person</span>
                                        <input class="input-field" name="nombre" placeholder="Juan" type="text" required />
                                    </div>
                                </label>
                                <label class="flex flex-col gap-2">
                                    <span class="text-sm font-bold">Apellido *</span>
                                    <div class="relative group">
                                        <span class="material-symbols-outlined input-icon">person</span>
                                        <input class="input-field" name="apellido" placeholder="Pérez" type="text" required />
                                    </div>
                                </label>
                            </div>

                            <div class="grid grid-cols-1 md:grid-cols-2 gap-5">
                                <label class="flex flex-col gap-2">
                                    <span class="text-sm font-bold">DNI *</span>
                                    <div class="relative group">
                                        <span class="material-symbols-outlined input-icon">badge</span>
                                        <input class="input-field" name="dni" placeholder="Sin puntos" type="number" required />
                                    </div>
                                </label>
                                <label class="flex flex-col gap-2">
                                    <span class="text-sm font-bold">Teléfono *</span>
                                    <div class="relative group">
                                        <span class="material-symbols-outlined input-icon">call</span>
                                        <input class="input-field" name="telefono" placeholder="3764..." type="tel" required />
                                    </div>
                                </label>
                            </div>
                        </div>

                        <div class="flex flex-col gap-5 border-t border-border-light dark:border-border-dark pt-6">
                            <div class="flex items-center gap-3">
                                <div class="icon-circle size-8 text-sm font-bold">2</div>
                                <h3 class="text-lg font-bold">Datos de Acceso</h3>
                            </div>

                            <label class="flex flex-col gap-2">
                                <span class="text-sm font-bold">Correo Electrónico *</span>
                                <div class="relative group">
                                    <span class="material-symbols-outlined input-icon">mail</span>
                                    <input class="input-field" name="email" placeholder="juan@ejemplo.com" type="email" required />
                                </div>
                            </label>

                            <label class="flex flex-col gap-2">
                                <span class="text-sm font-bold">Contraseña *</span>
                                <div class="relative group">
                                    <span class="material-symbols-outlined input-icon">lock</span>
                                    <input class="input-field" name="password" placeholder="Mínimo 6 caracteres" type="password" required />
                                </div>
                            </label>
                        </div>

                        <div class="pt-4 pb-12">
                            <button type="submit" class="btn btn-primary w-full h-14 text-base shadow-lg shadow-primary/20">
                                <span>Unirme a la Colonia</span>
                                <span class="material-symbols-outlined ml-2">arrow_forward</span>
                            </button>
                            
                            <p class="text-center text-xs text-ink-light mt-4">
                                ¿Ya tienes cuenta? <a href="login.jsp" class="link">Inicia sesión</a>
                            </p>
                        </div>
                    </form>
                    
                </div>
            </div>
        </div>
    </div>

</body>
</html>