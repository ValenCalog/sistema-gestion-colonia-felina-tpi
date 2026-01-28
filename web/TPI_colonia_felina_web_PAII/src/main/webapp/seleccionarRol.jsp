<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Selección de Rol</title>
    
    <jsp:include page="/WEB-INF/fragmentos/cabecera-estilos.jsp" />
</head>
<body class="bg-surface-light dark:bg-surface-dark font-sans text-ink dark:text-white antialiased flex flex-col min-h-screen">

    <header class="sticky top-0 z-50 flex items-center justify-between border-b border-border-light dark:border-border-dark bg-surface-card/90 dark:bg-surface-dark/90 backdrop-blur-md px-6 lg:px-40 py-3">
        <div class="flex items-center gap-3">
            <div class="size-8 flex items-center justify-center text-primary">
                <span class="material-symbols-outlined text-3xl">pets</span>
            </div>
            <h2 class="text-lg font-bold tracking-tight">Misión Michi</h2>
        </div>
        <a href="login.jsp" class="btn btn-primary h-9 text-sm">
            Iniciar Sesión
        </a>
    </header>

    <main class="flex-grow px-4 md:px-10 lg:px-40 py-10 flex justify-center">
        <div class="w-full max-w-[1200px] flex flex-col gap-10">
            
            <div class="flex flex-col items-center text-center gap-4 animate-fade-in">
                <h1 class="heading-xl">Bienvenido a la Colonia</h1>
                <p class="text-body text-lg max-w-2xl">
                    Selecciona tu rol para continuar. Ya sea que quieras adoptar, ser voluntario o brindar atención médica, nos alegra que estés aquí.
                </p>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-4 gap-6">
                
                <a href="registroFamilia.jsp" class="group flex flex-col rounded-2xl bg-surface-card dark:bg-surface-cardDark shadow-sm hover:shadow-xl hover:shadow-primary/10 border border-border-light dark:border-border-dark hover:border-primary/50 transition-all duration-300 cursor-pointer overflow-hidden h-full">
                    <div class="h-48 bg-cover bg-center relative" style="background-image: url('https://images.unsplash.com/photo-1574158622682-e40e69881006?q=80&w=800&auto=format&fit=crop');">
                        <div class="absolute inset-0 bg-gradient-to-t from-black/70 to-transparent flex items-end p-4">
                            <span class="material-symbols-outlined text-white text-4xl">favorite</span>
                        </div>
                    </div>
                    <div class="flex flex-col justify-between flex-grow p-6 gap-4">
                        <div>
                            <h3 class="text-xl font-bold mb-2">Quiero Adoptar</h3>
                            <p class="text-body text-sm">Crea un perfil de adopción y encuentra a tu compañero ideal en nuestras colonias.</p>
                        </div>
                        <span class="btn btn-secondary w-full group-hover:bg-primary group-hover:text-ink transition-colors">Empezar</span>
                    </div>
                </a>

                <a href="unirseFamilia.jsp" class="group flex flex-col rounded-2xl bg-surface-card dark:bg-surface-cardDark shadow-sm hover:shadow-xl hover:shadow-primary/10 border border-border-light dark:border-border-dark hover:border-primary/50 transition-all duration-300 cursor-pointer overflow-hidden h-full">
                    <div class="h-48 bg-cover bg-center relative" style="background-image: url('https://images.unsplash.com/photo-1761849388996-055bd16740fa?q=80&w=774&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D');">
                        <div class="absolute inset-0 bg-gradient-to-t from-black/70 to-transparent flex items-end p-4">
                            <span class="material-symbols-outlined text-white text-4xl">diversity_3</span>
                        </div>
                    </div>
                    <div class="flex flex-col justify-between flex-grow p-6 gap-4">
                        <div>
                            <h3 class="text-xl font-bold mb-2">Soy Familiar</h3>
                            <p class="text-body text-sm">Vincúlate a un hogar existente para gestionar mascotas en conjunto.</p>
                        </div>
                        <span class="btn btn-secondary w-full group-hover:bg-primary group-hover:text-ink transition-colors">Buscar Familia</span>
                    </div>
                </a>

                <a href="registroVoluntario.jsp" class="group flex flex-col rounded-2xl bg-surface-card dark:bg-surface-cardDark shadow-sm hover:shadow-xl hover:shadow-primary/10 border border-border-light dark:border-border-dark hover:border-primary/50 transition-all duration-300 cursor-pointer overflow-hidden h-full">
                    <div class="h-48 bg-cover bg-center relative" style="background-image: url('https://images.unsplash.com/photo-1469571486292-0ba58a3f068b?q=80&w=800&auto=format&fit=crop');">
                        <div class="absolute inset-0 bg-gradient-to-t from-black/70 to-transparent flex items-end p-4">
                            <span class="material-symbols-outlined text-white text-4xl">volunteer_activism</span>
                        </div>
                    </div>
                    <div class="flex flex-col justify-between flex-grow p-6 gap-4">
                        <div>
                            <h3 class="text-xl font-bold mb-2">Soy Voluntario</h3>
                            <p class="text-body text-sm">Únete al equipo de campo para alimentar y gestionar colonias en tu zona.</p>
                        </div>
                        <span class="btn btn-secondary w-full group-hover:bg-primary group-hover:text-ink transition-colors">Unirme</span>
                    </div>
                </a>

                <a href="registroVeterinario.jsp" class="group flex flex-col rounded-2xl bg-surface-card dark:bg-surface-cardDark shadow-sm hover:shadow-xl hover:shadow-primary/10 border border-border-light dark:border-border-dark hover:border-primary/50 transition-all duration-300 cursor-pointer overflow-hidden h-full">
                    <div class="h-48 bg-cover bg-center relative" style="background-image: url('https://images.unsplash.com/photo-1725409796872-8b41e8eca929?q=80&w=1471&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D');">
                        <div class="absolute inset-0 bg-gradient-to-t from-black/70 to-transparent flex items-end p-4">
                            <span class="material-symbols-outlined text-white text-4xl">medical_services</span>
                        </div>
                    </div>
                    <div class="flex flex-col justify-between flex-grow p-6 gap-4">
                        <div>
                            <h3 class="text-xl font-bold mb-2">Soy Veterinario</h3>
                            <p class="text-body text-sm">Provee soporte médico profesional y actualiza historiales clínicos.</p>
                        </div>
                        <span class="btn btn-secondary w-full group-hover:bg-primary group-hover:text-ink transition-colors">Acceso Profesional</span>
                    </div>
                </a>

            </div>

            <div class="flex flex-col items-center justify-center gap-2 mt-8 text-center text-sm">
                <p class="text-body">
                    ¿Ya tienes una cuenta? <a class="link" href="login.jsp">Inicia sesión aquí</a>
                </p>
            </div>

        </div>
    </main>
    
    <footer class="py-6 text-center text-xs text-ink-light/50 border-t border-border-light dark:border-border-dark">
        © 2026 Misión Michi. Todos los derechos reservados.
    </footer>

</body>
</html>