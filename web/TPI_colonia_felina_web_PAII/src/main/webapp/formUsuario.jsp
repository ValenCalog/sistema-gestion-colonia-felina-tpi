<%@page import="com.prog.tpi_colonia_felina_paii.modelo.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Gestión Usuario - GatoGestion</title>
    
    <jsp:include page="/WEB-INF/fragmentos/cabecera-estilos.jsp" />
    
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body class="bg-surface-light dark:bg-surface-dark min-h-screen flex items-center justify-center p-4">

    <div class="card w-full max-w-2xl bg-white dark:bg-[#1a2632]">
        
        <% 
            Usuario u = (Usuario) request.getAttribute("usuarioEditar");
            boolean esEdicion = (u != null);
        %>

        <div class="flex items-center justify-between border-b border-border-light pb-4 mb-4">
            <h1 class="text-2xl font-bold text-ink dark:text-white">
                <%= esEdicion ? "Editar Usuario" : "Nuevo Usuario" %>
            </h1>
            <a href="AdminServlet" class="btn btn-secondary text-xs">Cancelar</a>
        </div>

        <form action="AdminServlet" method="POST" class="flex flex-col gap-6">
            
            <input type="hidden" name="idUsuario" value="<%= esEdicion ? u.getIdUsuario() : "" %>">

            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                
                <div class="flex flex-col gap-2">
                    <label class="text-sm font-bold text-ink">Nombre</label>
                    <input class="input-field" type="text" name="nombre" 
                           value="<%= esEdicion ? u.getNombre() : "" %>" required>
                </div>
                
                <div class="flex flex-col gap-2">
                    <label class="text-sm font-bold text-ink">Apellido</label>
                    <input class="input-field" type="text" name="apellido" 
                           value="<%= esEdicion ? u.getApellido() : "" %>" required>
                </div>
                
                <div class="flex flex-col gap-2">
                    <label class="text-sm font-bold text-ink">DNI</label>
                    <input class="input-field" type="text" name="dni" 
                           value="<%= esEdicion ? u.getDNI() : "" %>" required>
                </div>
                
                <div class="flex flex-col gap-2">
                    <label class="text-sm font-bold text-ink">Correo</label>
                    <input class="input-field" type="email" name="correo" 
                           value="<%= esEdicion ? u.getCorreo() : "" %>" required>
                </div>
                
                 <div class="flex flex-col gap-2">
                    <label class="text-sm font-bold text-ink">Teléfono</label>
                    <input class="input-field" type="text" name="telefono" 
                           value="<%= esEdicion ? u.getTelefono() : "" %>">
                </div>
                
                <div class="flex flex-col gap-2">
                    <label class="text-sm font-bold text-ink">
                        Contraseña 
                        <% if(esEdicion) { %> 
                            <span class="text-xs font-normal text-gray-500">(Dejar en blanco para mantener la actual)</span>
                        <% } else { %>
                            <span class="text-red-500">*</span>
                        <% } %>
                    </label>
                    <input class="input-field" type="password" name="contrasenia" 
                           placeholder="<%= esEdicion ? "••••••••" : "Ingrese contraseña" %>"
                           <%= !esEdicion ? "required" : "" %>>
                </div>
                
                <div class="flex flex-col gap-2">
                    <label class="text-sm font-bold text-ink">Rol</label>
                    <select name="rol" id="selectRol" class="input-field h-12 cursor-pointer">
                        <% for(com.prog.tpi_colonia_felina_paii.enums.Rol r : com.prog.tpi_colonia_felina_paii.enums.Rol.values()) { 
                            String selected = (esEdicion && u.getRol() == r) ? "selected" : "";
                        %>
                            <option value="<%= r %>" <%= selected %>>
                                <%= r %>
                            </option>
                        <% } %>
                    </select>
                </div>
                
                <script>
                    document.addEventListener('DOMContentLoaded', function() {
                        const selectRol = document.getElementById('selectRol');
                        
                        // Convertimos el booleano de Java a booleano de JS correctamente
                        const esEdicionJS = <%= esEdicion %>; 

                        selectRol.addEventListener('change', function() {
                            // Si elige VETERINARIO y NO estamos editando (es creación nueva)
                            if (this.value === 'VETERINARIO' && !esEdicionJS) {
                                
                                Swal.fire({
                                    title: 'Acción no permitida aquí',
                                    text: "El alta de Veterinarios requiere datos específicos (Matrícula, Especialidad). Por favor, usa el formulario de registro público.",
                                    icon: 'info',
                                    showCancelButton: true,
                                    confirmButtonColor: '#f97316',
                                    confirmButtonText: 'Ir al Registro Veterinario',
                                    cancelButtonText: 'Entendido, cambiaré el rol'
                                }).then((result) => {
                                    if (result.isConfirmed) {
                                        window.location.href = 'registroVeterinario.jsp'; 
                                    } else {
                                        // Si cancela, volvemos a poner VOLUNTARIO
                                        this.value = 'VOLUNTARIO'; 
                                    }
                                });
                            }
                        });
                    });
                </script>

                <div class="flex flex-col gap-2">
                    <label class="text-sm font-bold text-ink">Estado</label>
                    <select name="estado" class="input-field h-12 cursor-pointer bg-orange-50 border-orange-200">
                        <% for(com.prog.tpi_colonia_felina_paii.enums.EstadoUsuario e : com.prog.tpi_colonia_felina_paii.enums.EstadoUsuario.values()) { 
                            String selected = (esEdicion && u.getEstado() == e) ? "selected" : "";
                        %>
                            <option value="<%= e %>" <%= selected %>>
                                <%= e %>
                            </option>
                        <% } %>
                    </select>
                </div>
            </div>

            <div class="flex justify-end gap-3 mt-4 pt-4 border-t border-border-light">
                <button type="submit" class="btn btn-primary w-full md:w-auto shadow-lg shadow-primary/20">
                    <%= esEdicion ? "Guardar Cambios" : "Crear Usuario" %>
                </button>
            </div>
            
        </form>
    </div>

</body>
</html>