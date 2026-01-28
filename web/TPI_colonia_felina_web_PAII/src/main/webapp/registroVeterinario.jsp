<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Registro Profesional</title>
    
    <jsp:include page="/WEB-INF/fragmentos/cabecera-estilos.jsp" />
</head>
<body class="bg-surface-light dark:bg-surface-dark font-sans text-ink dark:text-white antialiased flex flex-col min-h-screen">

    <header class="sticky top-0 z-50 flex items-center justify-between border-b border-border-light dark:border-border-dark bg-surface-card/90 dark:bg-surface-dark/90 backdrop-blur-md px-6 lg:px-10 py-3 shadow-sm">
        <div class="flex items-center gap-4">
            <div class="size-8 text-primary flex items-center justify-center">
                <span class="material-symbols-outlined text-3xl">pets</span>
            </div>
            <h2 class="text-lg font-bold tracking-tight">Misión Michi</h2>
        </div>
        <div class="flex items-center gap-4">
            <span class="text-sm font-medium hidden md:block">¿Ya tienes cuenta?</span>
            <a href="login.jsp" class="btn btn-outline text-primary border-primary/20 hover:bg-primary/10 text-xs h-9">
                Iniciar Sesión
            </a>
        </div>
    </header>

    <main class="flex-grow flex justify-center py-8 lg:py-12 px-4 sm:px-10">
        
        <div class="w-full max-w-[800px] bg-surface-card dark:bg-surface-cardDark rounded-2xl shadow-xl border border-border-light dark:border-border-dark overflow-hidden flex flex-col">
            
            <div class="flex flex-col gap-3 p-8 border-b border-border-light dark:border-border-dark bg-gradient-to-r from-surface-card to-primary/5 dark:from-surface-cardDark dark:to-primary/10">
                <a href="seleccionRol.jsp" class="flex items-center gap-2 text-ink-light text-sm mb-2 hover:text-primary transition-colors w-fit">
                    <span class="material-symbols-outlined text-lg">arrow_back</span>
                    Volver a selección
                </a>
                <div class="flex items-center gap-2 text-primary mb-1">
                    <span class="material-symbols-outlined text-2xl">medical_services</span>
                    <span class="text-xs font-bold tracking-wider uppercase">Portal Profesional</span>
                </div>
                <h1 class="heading-xl !text-3xl sm:!text-4xl">Registro de Veterinario</h1>
                <p class="text-body max-w-2xl">
                    Únete a la red profesional de Misión Michi. Los veterinarios verificados tienen acceso a herramientas de historial clínico y gestión de campañas.
                </p>
            </div>

            <% if (request.getAttribute("error") != null) { %>
                <div class="mx-8 mt-6 p-4 bg-red-100 border border-red-400 text-red-700 rounded-lg flex items-center gap-2">
                    <span class="material-symbols-outlined">error</span>
                    <span><%= request.getAttribute("error") %></span>
                </div>
            <% } %>

            <form action="RegistroVeterinarioServlet" method="POST" class="p-8 flex flex-col gap-8">
                
                <div>
                    <div class="flex items-center gap-2 mb-6">
                        <span class="icon-circle size-6 text-xs font-bold">1</span>
                        <h3 class="text-lg font-bold">Datos Profesionales</h3>
                    </div>
                    
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <label class="flex flex-col gap-2 md:col-span-2">
                            <span class="text-sm font-bold">Número de Matrícula *</span>
                            <div class="relative group">
                                <span class="material-symbols-outlined input-icon text-primary">verified</span>
                                <input class="input-field border-primary/30 focus:border-primary" 
                                       name="matricula" placeholder="Ej. 12345" type="text" required />
                            </div>
                            <p class="text-xs text-ink-light ml-1">Formato oficial del colegio de veterinarios.</p>
                        </label>
                    </div>
                </div>

                <hr class="border-border-light dark:border-border-dark" />

                <div>
                    <div class="flex items-center gap-2 mb-6">
                        <span class="icon-circle size-6 text-xs font-bold">2</span>
                        <h3 class="text-lg font-bold">Información Personal</h3>
                    </div>

                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
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

                <hr class="border-border-light dark:border-border-dark" />

                <div>
                    <div class="flex items-center gap-2 mb-6">
                        <span class="icon-circle size-6 text-xs font-bold">3</span>
                        <h3 class="text-lg font-bold">Credenciales de Acceso</h3>
                    </div>

                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <label class="flex flex-col gap-2">
                            <span class="text-sm font-bold">Correo Electrónico *</span>
                            <div class="relative group">
                                <span class="material-symbols-outlined input-icon">mail</span>
                                <input class="input-field" name="email" placeholder="juan.vet@email.com" type="email" required />
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
                </div>

                <div class="bg-gray-50 dark:bg-white/5 -mx-8 -mb-8 p-8 mt-4 border-t border-border-light dark:border-border-dark flex flex-col sm:flex-row items-center justify-between gap-4">
                    <div class="flex items-center gap-2 text-ink-light text-sm">
                        <span class="material-symbols-outlined text-lg text-primary">security</span>
                        <span>Tus datos pasarán por un proceso de validación.</span>
                    </div>
                    <button type="submit" class="btn btn-primary w-full sm:w-auto min-w-[220px] shadow-lg shadow-primary/20 h-12 text-base">
                        Solicitar Registro
                    </button>
                </div>
            </form>
        </div>
    </main>

</body>
</html>