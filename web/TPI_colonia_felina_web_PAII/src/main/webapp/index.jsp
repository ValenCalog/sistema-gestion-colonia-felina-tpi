<%-- 
    Document   : index
    Created on : Jan 26, 2026, 11:38:02 PM
    Author     : mvale
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!DOCTYPE html>
<html lang="en" class="scroll-smooth">
<head>
    <meta charset="utf-8" />
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <title>Misión Michi</title>
    
    <jsp:include page="/WEB-INF/fragmentos/cabecera-estilos.jsp" />

</head>

<body class="bg-surface-light dark:bg-surface-dark font-sans text-ink dark:text-white antialiased">
    <div class="relative flex min-h-screen w-full flex-col overflow-x-hidden">
        
        <header class="sticky top-0 z-50 flex items-center justify-between border-b border-border-light dark:border-border-dark bg-white/90 dark:bg-surface-dark/90 backdrop-blur-md px-4 md:px-10 py-3">
            <div class="flex items-center gap-4">
                <div class="size-8 text-primary">
                    <span class="material-symbols-outlined text-4xl">pets</span>
                </div>
                <h2 class="text-lg font-bold leading-tight">Misión Michi</h2>
            </div>
            
            <div class="hidden md:flex flex-1 justify-end gap-8 items-center">
                <nav class="flex gap-9">
                    <a class="text-sm font-medium hover:text-primary transition-colors" href="#">Adoptar</a>
                    <a class="text-sm font-medium hover:text-primary transition-colors" href="#">Acerca De</a>
                    <a class="text-sm font-medium hover:text-primary transition-colors" href="login.jsp">Iniciar Sesión</a>
                </nav>
                <a href="seleccionarRol.jsp" class="btn btn-primary text-sm">
                    Sumate a la Comunidad
                </a>
            </div>

            <div class="md:hidden">
                <span class="material-symbols-outlined cursor-pointer">menu</span>
            </div>
        </header>

        <main class="flex-grow">
            <div class="flex justify-center py-5 px-4 md:px-10">
                <div class="flex flex-col max-w-[1200px] w-full gap-16">
                    
                    <section class="flex flex-col-reverse md:flex-row gap-8 py-10 items-center">
                        <div class="flex flex-col gap-6 flex-1 text-center md:text-left items-center md:items-start">
                            <h1 class="heading-xl">
                                Protegiendo a nuestros vecinos felinos
                            </h1>
                            <p class="text-body text-lg max-w-xl">
                                Misión Michi ayuda a las comunidades a gestionar colonias de gatos callejeros de manera efectiva, ética y compasiva 
                            </p>
                            <div class="flex gap-4 w-full md:w-auto justify-center md:justify-start">
                                <button class="btn btn-primary h-12 w-full md:w-auto">Comenzar</button>
                                <button class="btn btn-secondary h-12 w-full md:w-auto">Más información</button>
                            </div>
                        </div>
                        <div class="w-full flex-1 aspect-[4/3] rounded-2xl overflow-hidden shadow-xl bg-gray-200 relative">
                             <img src="https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?q=80&w=1200&auto=format&fit=crop" 
                                 alt="Ginger cat" 
                                 class="absolute inset-0 w-full h-full object-cover" />
                        </div>
                    </section>

                    <section class="flex flex-col gap-10 py-8">
                        <div class="text-center space-y-4">
                            <h2 class="text-3xl md:text-4xl font-bold">Formas de ayudar</h2>
                            <p class="text-body text-lg max-w-2xl mx-auto">
                                 Elige tu rol en nuestro ecosistema comunitario y marca una verdadera diferencia hoy.
                            </p>
                        </div>
                        
                        <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                            <div class="card group hover:border-primary/50 hover:shadow-lg">
                                <div class="icon-circle group-hover:scale-110 transition-transform">
                                    <span class="material-symbols-outlined text-3xl">sentiment_satisfied</span>
                                </div>
                                <div class="space-y-2">
                                    <h3 class="text-xl font-bold">Adoptantes</h3>
                                    <p class="text-body">Encuentra un amigo. Descubre almas dulces listas para dejar las calles y tener un hogar para siempre.</p>
                                </div>
                                <a class="mt-auto pt-4 text-primary font-bold text-sm hover:underline flex items-center gap-1" href="#">
                                    Ver gatos <span class="material-symbols-outlined text-sm">arrow_forward</span>
                                </a>
                            </div>

                            <div class="card group hover:border-primary/50 hover:shadow-lg">
                                <div class="icon-circle group-hover:scale-110 transition-transform">
                                    <span class="material-symbols-outlined text-3xl">handshake</span>
                                </div>
                                <div class="space-y-2">
                                    <h3 class="text-xl font-bold">Voluntarios</h3>
                                    <p class="text-body">Trabajo en terreno. Ayuda a alimentar, atrapar, transportar y monitorear colonias locales.</p>
                                </div>
                                <a class="mt-auto pt-4 text-primary font-bold text-sm hover:underline flex items-center gap-1" href="registroVoluntario.jsp">
                                    Únete <span class="material-symbols-outlined text-sm">arrow_forward</span>
                                </a>
                            </div>

                            <div class="card group hover:border-primary/50 hover:shadow-lg">
                                <div class="icon-circle group-hover:scale-110 transition-transform">
                                    <span class="material-symbols-outlined text-3xl">favorite</span>
                                </div>
                                <div class="space-y-2">
                                    <h3 class="text-xl font-bold">Veterinarios</h3>
                                    <p class="text-body">Cuidadores expertos. Brinda atención médica esencial a gatos de colonia: esterilizaciones, vacunaciones y tratamientos que mejoran su calidad de vida.</p>
                                </div>
                                <a class="mt-auto pt-4 text-primary font-bold text-sm hover:underline flex items-center gap-1" href="registroVeterinario.jsp">
                                    Colabora como Veterinario <span class="material-symbols-outlined text-sm">arrow_forward</span>
                                </a>
                            </div>
                        </div>
                    </section>

                    <section class="py-16 bg-[#f8fcf8] dark:bg-surface-cardDark/50 rounded-3xl px-6 md:px-12">
                        <h2 class="text-3xl font-bold text-center mb-12">¿Cómo funciona?</h2>
                        <div class="max-w-4xl mx-auto space-y-8 md:space-y-0 md:grid md:grid-cols-[1fr_auto_1fr] gap-x-8">
                            
                            <div class="hidden md:block text-right pt-2">
                                <h3 class="text-xl font-bold"> Identificar Colonia </h3>
                                <p class="text-body text-sm mt-1"> Localizar y registrar grupos de gatos sin gestión.</p>
                            </div>
                            <div class="flex flex-col items-center relative">
                                <div class="size-10 rounded-full bg-primary flex items-center justify-center text-ink z-10 shadow-lg ring-4 ring-white dark:ring-surface-dark font-bold">1</div>
                                <div class="w-0.5 bg-border-light dark:bg-border-dark h-full absolute top-4 -z-0"></div>
                            </div>
                            <div class="md:hidden pt-2 pb-8 pl-4 border-l-2 border-border-light dark:border-border-dark md:border-0 ml-[19px] md:ml-0 -mt-2">
                                <h3 class="text-xl font-bold">Identificar Colonia</h3>
                                <p class="text-body text-sm mt-1"> Localizar y registrar grupos de gatos sin gestión.</p>
                            </div>
                            <div class="hidden md:block"></div>

                            <div class="hidden md:block"></div>
                            <div class="flex flex-col items-center relative">
                                <div class="size-10 rounded-full bg-surface-card dark:bg-surface-cardDark border-2 border-primary flex items-center justify-center text-primary z-10 shadow-md ring-4 ring-white dark:ring-surface-dark">
                                    <span class="material-symbols-outlined">medical_services</span>
                                </div>
                                <div class="w-0.5 bg-border-light dark:bg-border-dark h-full absolute top-0 -z-0"></div>
                            </div>
                            <div class="pt-2 pb-8 pl-4 md:pl-0 border-l-2 border-border-light dark:border-border-dark md:border-0 ml-[19px] md:ml-0 -mt-6 md:mt-0">
                                <h3 class="text-xl font-bold">Castración responsable </h3>
                                <p class="text-body text-sm mt-1">Captura y castración humanitaria para cuidar la salud y bienestar de la colonia.</p>
                            </div>

                            <div class="hidden md:block text-right pt-2">
                                <h3 class="text-xl font-bold">Cuidado continuo</h3>
                                <p class="text-body text-sm mt-1">Alimentación regular y monitoreo de salud.</p>
                            </div>
                            <div class="flex flex-col items-center relative">
                                <div class="size-10 rounded-full bg-surface-card dark:bg-surface-cardDark border-2 border-primary flex items-center justify-center text-primary z-10 shadow-md ring-4 ring-white dark:ring-surface-dark">
                                    <span class="material-symbols-outlined">rice_bowl</span>
                                </div>
                                <div class="w-0.5 bg-border-light dark:bg-border-dark h-full absolute top-0 -z-0"></div>
                            </div>
                            <div class="md:hidden pt-2 pb-8 pl-4 border-l-2 border-border-light dark:border-border-dark md:border-0 ml-[19px] md:ml-0 -mt-6">
                                <h3 class="text-xl font-bold">Cuidado continuo</h3>
                                <p class="text-body text-sm mt-1">Alimentación regular y monitoreo de salud.</p>
                            </div>
                            <div class="hidden md:block"></div>

                            <div class="hidden md:block"></div>
                            <div class="flex flex-col items-center relative">
                                <div class="size-10 rounded-full bg-surface-card dark:bg-surface-cardDark border-2 border-primary flex items-center justify-center text-primary z-10 shadow-md ring-4 ring-white dark:ring-surface-dark">
                                    <span class="material-symbols-outlined">home</span>
                                </div>
                            </div>
                            <div class="pt-2 pl-4 md:pl-0 border-l-2 border-transparent ml-[19px] md:ml-0 -mt-6 md:mt-0">
                                <h3 class="text-xl font-bold">Adopción</h3>
                                <p class="text-body text-sm mt-1">Encontrar hogares para los gatos.</p>
                            </div>

                        </div>
                    </section>

                    <section class="pb-16">
                        <div class="relative overflow-hidden rounded-3xl bg-surface-dark dark:bg-black px-8 py-16 text-center shadow-2xl">
                            <div class="absolute inset-0 opacity-20" style="background-image: radial-gradient(circle at 2px 2px, #3bee2b 1px, transparent 0); background-size: 40px 40px;"></div>
                            
                            <div class="relative z-10 flex flex-col items-center gap-6 max-w-2xl mx-auto">
                                <h2 class="text-white text-3xl md:text-4xl font-black tracking-tight">¿Listo/a para generar un impacto?</h2>
                                <p class="text-gray-300 text-lg">Únete a una comunidad de vecinos compasivos dedicados a mejorar la vida de los gatos callejeros.</p>
                                <div class="flex flex-col sm:flex-row gap-4 mt-2">
                                    <a class="btn btn-primary h-12 w-full sm:w-auto" href="seleccionarRol.jsp">Únete ahora</a>
                                </div>
                            </div>
                        </div>
                    </section>

                </div>
            </div>
        </main>

        <footer class="border-t border-border-light dark:border-border-dark py-8 px-4 md:px-10">
            <div class="flex flex-col md:flex-row justify-between items-center gap-4 text-sm">
                <div class="flex items-center gap-2">
                    <span class="material-symbols-outlined text-primary">pets</span>
                    <span class="font-bold">Misión Michi</span>
                </div>
                <div class="flex gap-6 text-ink-light dark:text-gray-400">
                   
                </div>
                <div class="text-ink-light dark:text-gray-400">
                    © 2026 Misión Michi. Todos los derechos reservados.
                </div>
            </div>
        </footer>

    </div>
</body>
</html>
