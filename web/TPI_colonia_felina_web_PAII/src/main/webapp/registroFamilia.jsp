<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Registro de Familia</title>
    
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

    <main class="flex-grow flex justify-center py-8 lg:py-12 px-4 lg:px-8">
        <div class="w-full max-w-6xl grid grid-cols-1 lg:grid-cols-12 gap-8">
            
            <div class="lg:col-span-8 flex flex-col gap-6">
                
                <div class="flex flex-col gap-2">
                    <h1 class="heading-xl !text-3xl lg:!text-4xl">Registro de Familia Adoptante</h1>
                    <p class="text-body text-lg">Únete a nuestra red y ayuda a dar un hogar a los michis de la colonia.</p>
                </div>

                <div class="card p-0 overflow-hidden border-none shadow-lg">
                    <div class="px-6 py-4 border-b border-border-light dark:border-border-dark bg-gray-50 dark:bg-white/5">
                        <h3 class="text-lg font-bold flex items-center gap-2">
                            <span class="material-symbols-outlined text-primary">person_add</span>
                            Datos de la Cuenta
                        </h3>
                    </div>
                    
                    <form action="RegistroFamiliaServlet" method="POST" class="p-6 lg:p-8 flex flex-col gap-6">
                        
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <label class="flex flex-col gap-2">
                                <span class="text-sm font-bold">Nombre *</span>
                                <div class="relative group">
                                    <span class="material-symbols-outlined input-icon">person</span>
                                    <input class="input-field" name="nombre" placeholder="Ej. María" type="text" required />
                                </div>
                            </label>
                            <label class="flex flex-col gap-2">
                                <span class="text-sm font-bold">Apellido *</span>
                                <div class="relative group">
                                    <span class="material-symbols-outlined input-icon">person</span>
                                    <input class="input-field" name="apellido" placeholder="Ej. Gómez" type="text" required />
                                </div>
                            </label>
                        </div>

                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
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
                                    <input class="input-field" name="telefono" placeholder="Ej. 3764..." type="tel" required />
                                </div>
                            </label>
                        </div>

                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <label class="flex flex-col gap-2">
                                <span class="text-sm font-bold">Email (Usuario) *</span>
                                <div class="relative group">
                                    <span class="material-symbols-outlined input-icon">mail</span>
                                    <input class="input-field" name="correo" placeholder="maria@email.com" type="email" required />
                                </div>
                            </label>
                            <label class="flex flex-col gap-2">
                                <span class="text-sm font-bold">Contraseña *</span>
                                <div class="relative group">
                                    <span class="material-symbols-outlined input-icon">lock</span>
                                    <input class="input-field" name="contrasenia" placeholder="••••••••" type="password" required />
                                </div>
                            </label>
                        </div>

                        <hr class="border-border-light dark:border-border-dark" />

                        <h4 class="text-md font-bold text-primary -mb-2">Información del Hogar</h4>
                        
                        <label class="flex flex-col gap-2">
                            <span class="text-sm font-bold">Dirección Completa *</span>
                            <div class="relative group">
                                <span class="material-symbols-outlined input-icon">home_pin</span>
                                <input class="input-field" name="direccion" placeholder="Calle 123, Barrio Centro, Posadas" type="text" required />
                            </div>
                        </label>

                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <label class="flex flex-col gap-2">
                                <span class="text-sm font-bold">Tipo de Disponibilidad *</span>
                                <div class="relative group">
                                    <span class="material-symbols-outlined input-icon">volunteer_activism</span>
                                    <select name="disponibilidad" class="input-field appearance-none cursor-pointer">
                                        <option value="TRANSITO">Hogar de Tránsito (Temporal)</option>
                                        <option value="ADOPCION_DEFINITIVA">Adopción Definitiva</option>
                                        <option value="AMBOS">Ambos</option>
                                    </select>
                                    <span class="material-symbols-outlined absolute right-4 top-1/2 -translate-y-1/2 pointer-events-none text-gray-400">expand_more</span>
                                </div>
                            </label>
                            
                            <label class="flex flex-col gap-2">
                                <span class="text-sm font-bold">Observaciones / Mascotas</span>
                                <div class="relative group">
                                    <span class="material-symbols-outlined input-icon top-4 translate-y-0">pets</span>
                                    <textarea name="observaciones" class="input-field min-h-[50px] pt-3" placeholder="Ej. Tengo 2 gatos y patio cerrado..."></textarea>
                                </div>
                            </label>
                        </div>

                        <div class="flex justify-end gap-4 mt-4 pt-6 border-t border-border-light dark:border-border-dark">
                            <a href="seleccionRol.jsp" class="btn btn-secondary">
                                Cancelar
                            </a>
                            <button type="submit" class="btn btn-primary shadow-lg shadow-primary/20">
                                Completar Registro
                            </button>
                        </div>
                    </form>
                </div>
            </div>

            <div class="lg:col-span-4 flex flex-col gap-6">

                <div class="rounded-xl border border-primary/20 bg-primary/5 p-5">
                    <h4 class="text-lg font-bold text-ink dark:text-white mb-3">¿Por qué registrarse?</h4>
                    <ul class="flex flex-col gap-3">
                        <li class="flex items-start gap-3 text-sm text-ink-light">
                            <span class="material-symbols-outlined text-primary text-xl">check_circle</span>
                            <span>Podrás postularte a adopciones con un solo clic.</span>
                        </li>
                        <li class="flex items-start gap-3 text-sm text-ink-light">
                            <span class="material-symbols-outlined text-primary text-xl">check_circle</span>
                            <span>Seguimiento en tiempo real de tus solicitudes.</span>
                        </li>
                        <li class="flex items-start gap-3 text-sm text-ink-light">
                            <span class="material-symbols-outlined text-primary text-xl">check_circle</span>
                            <span>Generación automática de tu código de familia.</span>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </main>
</body>
</html>