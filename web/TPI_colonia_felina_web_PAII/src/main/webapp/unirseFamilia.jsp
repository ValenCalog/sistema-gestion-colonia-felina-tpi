<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Unirse a Familia</title>
    
    <jsp:include page="/WEB-INF/fragmentos/cabecera-estilos.jsp" />
</head>
<body class="bg-surface-light dark:bg-surface-dark font-sans text-ink dark:text-white antialiased flex flex-col min-h-screen">

    <header class="sticky top-0 z-50 flex items-center justify-between border-b border-border-light dark:border-border-dark bg-surface-card/90 dark:bg-surface-dark/90 backdrop-blur-md px-6 py-4 shadow-sm">
        <div class="flex items-center gap-4">
            <div class="size-8 text-primary flex items-center justify-center">
                <span class="material-symbols-outlined text-3xl">pets</span>
            </div>
            <h2 class="text-lg font-bold tracking-tight">Misión Michi</h2>
        </div>
        <a href="login.jsp" class="btn btn-ghost text-sm h-9">
            Cancelar
        </a>
    </header>

    <main class="flex-grow flex flex-col items-center justify-center p-4 py-12 md:px-6">
        
        <div class="w-full max-w-[480px] bg-surface-card dark:bg-surface-cardDark rounded-2xl shadow-xl border border-border-light dark:border-border-dark overflow-hidden animate-fade-in-up">
            
            <div class="px-8 pt-10 pb-6 text-center">
                <div class="size-16 bg-primary/10 rounded-full flex items-center justify-center mx-auto mb-6 text-primary ring-4 ring-primary/5">
                    <span class="material-symbols-outlined text-4xl">diversity_1</span>
                </div>
                <h1 class="text-2xl font-bold mb-2">Unirse a una Familia</h1>
                <p class="text-body text-sm">
                    Ingresa el código de invitación de 6 caracteres que te compartió el administrador del grupo.
                </p>
            </div>

            <form action="UnirseFamiliaServlet" method="POST" class="px-8 pb-8">
                
                <% if (request.getAttribute("error") != null) { %>
                    <div class="mb-6 p-3 bg-red-100 border border-red-400 text-red-700 text-sm rounded-lg flex items-center gap-2 justify-center">
                        <span class="material-symbols-outlined text-base">error</span>
                        <span><%= request.getAttribute("error") %></span>
                    </div>
                <% } %>

                <label class="block text-xs font-bold uppercase tracking-wider text-ink-light mb-2 text-center">
                    Código de Invitación
                </label>
                
                <div class="relative max-w-[280px] mx-auto mb-8">
                    <input class="w-full h-14 text-center text-2xl font-mono font-bold tracking-[0.2em] rounded-xl border-2 border-border-light dark:border-border-dark bg-surface-light dark:bg-surface-dark focus:border-primary focus:ring-4 focus:ring-primary/10 transition-all uppercase placeholder:tracking-normal placeholder:text-base placeholder:font-sans placeholder:text-gray-400" 
                           type="text" 
                           name="codigoFamilia" 
                           placeholder="Ej. AB12CD" 
                           maxlength="20"
                           required 
                           autofocus />
                </div>

                <button type="submit" class="btn btn-primary w-full h-12 text-base shadow-lg shadow-primary/20 hover:scale-[1.02] active:scale-[0.98] transition-all">
                    <span>Verificar y Unirme</span>
                    <span class="material-symbols-outlined ml-2">login</span>
                </button>

                <p class="text-xs text-center text-ink-light mt-6">
                    Al unirte, compartirás tu perfil con los miembros del grupo.
                </p>
            </form>

            <div class="bg-surface-light dark:bg-surface-dark px-8 py-5 border-t border-border-light dark:border-border-dark text-center">
                <p class="text-sm font-medium text-ink-light">
                    ¿No tienes un código? 
                    <a href="registroFamilia.jsp" class="text-primary font-bold hover:underline decoration-2 underline-offset-4">
                        Crear nueva familia
                    </a>
                </p>
            </div>
        </div>

        <div class="mt-8 flex gap-6 text-xs text-ink-light font-medium">
            <a class="hover:text-primary transition-colors cursor-pointer">Centro de Ayuda</a>
            <span class="opacity-30">•</span>
            <a class="hover:text-primary transition-colors cursor-pointer">Términos y Condiciones</a>
        </div>

    </main>

</body>
</html>