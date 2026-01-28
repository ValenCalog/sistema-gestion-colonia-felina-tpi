<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Iniciar Sesión</title>
    
    <jsp:include page="/WEB-INF/fragmentos/cabecera-estilos.jsp" />
</head>
<body class="bg-surface-light dark:bg-surface-dark min-h-screen flex flex-col items-center justify-center p-4">

    <main class="flex-1 w-full max-w-[1000px] mx-auto bg-surface-card dark:bg-surface-cardDark rounded-2xl shadow-xl overflow-hidden flex flex-col md:flex-row min-h-[600px]">
        
        <div class="w-full md:w-1/2 relative bg-gray-100 flex items-center justify-center overflow-hidden">
            <img src="https://images.unsplash.com/photo-1513360371669-4adf3dd7dff8?q=80&w=870&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" 
                 alt="Gato mirando curiosamente" 
                 class="absolute inset-0 w-full h-full object-cover" />
            
            <div class="absolute inset-0 bg-gradient-to-t from-black/80 via-transparent to-transparent z-10"></div>
            
            <div class="relative z-20 p-10 text-white self-end w-full">
                <p class="text-white/90 font-medium">
                    Gestionando colonias y asegurando que cada gato callejero tenga una oportunidad.
                </p>
            </div>
        </div>

        <div class="w-full md:w-1/2 p-8 md:p-12 lg:p-16 flex flex-col justify-center">
            
            <div class="mb-8">
                <div class="flex items-center gap-2 mb-6 text-primary">
                    <span class="material-symbols-outlined text-4xl">pets</span>
                    <span class="text-ink dark:text-white font-bold text-xl">Misión Michi</span>
                </div>
                <h1 class="heading-xl text-3xl mb-2">Bienvenido</h1>
                <p class="text-body">Ingresa tus credenciales para acceder.</p>
            </div>
            
            <% if (request.getAttribute("error") != null) { %>
                <div class="mb-4 p-4 bg-red-100 border border-red-400 text-red-700 rounded-lg flex items-center gap-2">
                    <span class="material-symbols-outlined">error</span>
                    <span><%= request.getAttribute("error") %></span>
                </div>
            <% } %>
            
            <% 
                String mensaje = request.getParameter("registro");
                
                if(mensaje != null && mensaje.equals("exito")){
            %>
                <div class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded relative mb-4">
                    <strong class="font-bold">¡Registro exitoso!</strong>
                    <span class="block sm:inline">Ya puedes iniciar sesión con tu cuenta.</span>
                </div>    
            <%
                }
            %>
            
            <% 
            // Mensaje de PENDIENTE de aprobación (Voluntario)
            if ("pendiente".equals(mensaje)) { 
            %>
                <div class="bg-yellow-50 border border-yellow-200 text-yellow-800 px-4 py-3 rounded-lg relative mb-4 flex gap-3 shadow-sm">
                    <span class="material-symbols-outlined text-yellow-600">hourglass_top</span>
                    <div>
                        <strong class="font-bold block">¡Solicitud Recibida!</strong>
                        <span class="text-sm">Tu cuenta debe ser verificada por un administrador. Cuando sea verificada podrás acceder</span>
                    </div>
                </div>
            <% } %>

            <form action="LoginServlet" method="POST" class="flex flex-col gap-5">
                
                <div class="flex flex-col gap-2">
                    <label class="text-sm font-bold text-ink dark:text-gray-200" for="email">Email</label>
                    <div class="relative group">
                        <span class="material-symbols-outlined input-icon">mail</span>
                        <input class="input-field" id="email" name="email" placeholder="nombre@ejemplo.com" type="email" required />
                    </div>
                </div>

                <div class="flex flex-col gap-2">
                    <div class="flex justify-between items-center">
                        <label class="text-sm font-bold text-ink dark:text-gray-200" for="password">Contraseña</label>
                    </div>
                    <div class="relative group">
                        <span class="material-symbols-outlined input-icon">lock</span>
                        <input class="input-field" id="password" name="password" placeholder="••••••••" type="password" required />
                    </div>
                </div>

                <button type="submit" class="btn btn-primary w-full mt-2 shadow-lg shadow-primary/20">
                    Iniciar Sesión
                </button>
            </form>

            <div class="relative my-8">
                <div aria-hidden="true" class="absolute inset-0 flex items-center">
                    <div class="w-full border-t border-border-light dark:border-border-dark"></div>
                </div>
                <div class="relative flex justify-center">
                    <span class="bg-surface-card dark:bg-surface-cardDark px-2 text-sm text-ink-light">o</span>
                </div>
            </div>

            <div class="text-center">
                <p class="text-body text-sm">
                    ¿Eres nuevo aquí? 
                    <a class="link ml-1" href="seleccionarRol.jsp">Regístrate</a>
                </p>
            </div>
        </div>
    </main>
    
    <footer>
        <div class="w-full text-center p-4">
            © 2026 Misión Michi. Todos los derechos reservados.
        </div>
    </footer>

</body>
</html>