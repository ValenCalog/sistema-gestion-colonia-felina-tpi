<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Gestión de Usuarios - GatoGestion</title>
    
    <jsp:include page="/WEB-INF/fragmentos/cabecera-estilos.jsp" />
    
    <style>
        ::-webkit-scrollbar { width: 8px; height: 8px; }
        ::-webkit-scrollbar-track { background: transparent; }
        ::-webkit-scrollbar-thumb { background: #cbd5e1; border-radius: 4px; }
        ::-webkit-scrollbar-thumb:hover { background: #94a3b8; }
    </style>
</head>
<body class="font-sans bg-surface-light dark:bg-surface-dark text-ink dark:text-white overflow-hidden">
    
    <div class="flex h-screen w-full">
        
        <aside class="flex w-72 flex-col border-r border-border-light dark:border-border-dark bg-surface-card dark:bg-surface-cardDark transition-all duration-300 hidden lg:flex">
            <div class="flex flex-col h-full p-4">
                <div class="mb-8 px-2 flex items-center gap-3">
                    <div class="flex items-center justify-center w-10 h-10 rounded-xl bg-primary/10 text-primary">
                        <span class="material-symbols-outlined text-2xl">pets</span>
                    </div>
                    <div class="flex flex-col">
                        <h1 class="text-lg font-bold leading-none">Misión Michi</h1>
                        <p class="text-xs text-ink-light font-medium mt-1">Panel Admin</p>
                    </div>
                </div>

                <nav class="flex flex-col gap-2 flex-1">
                    <a class="sidebar-link" href="adminPanel.jsp">
                        <span class="material-symbols-outlined">dashboard</span>
                        <span class="text-sm">Dashboard</span>
                    </a>
                    <a class="sidebar-link-active" href="#">
                        <span class="material-symbols-outlined">group</span>
                        <span class="text-sm">Usuarios</span>
                    </a>
                    <a class="sidebar-link" href="#">
                        <span class="material-symbols-outlined">map</span>
                        <span class="text-sm font-medium">Zonas</span>
                    </a>
                    <a class="sidebar-link" href="#">
                        <span class="material-symbols-outlined">file_present</span>
                        <span class="text-sm font-medium">Reportes</span>
                    </a>
                </nav>

                <div class="mt-auto border-t border-border-light dark:border-border-dark pt-4 px-2">
                    <div class="flex items-center gap-3">
                        <div class="w-10 h-10 rounded-full bg-gray-200 overflow-hidden">
                            <img alt="Admin Avatar" class="w-full h-full object-cover" src="https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?q=80&w=100&auto=format&fit=crop"/>
                        </div>
                        <div class="flex flex-col">
                            <p class="text-sm font-bold">Admin User</p>
                            <p class="text-xs text-ink-light">admin@gatogestion.com</p>
                        </div>
                    </div>
                </div>
            </div>
        </aside>

        <main class="flex-1 flex flex-col h-full overflow-hidden relative">
            
            <header class="lg:hidden flex items-center justify-between px-4 py-3 bg-surface-card dark:bg-surface-cardDark border-b border-border-light dark:border-border-dark">
                <div class="flex items-center gap-2">
                    <span class="material-symbols-outlined">menu</span>
                    <span class="font-bold text-lg">GatoGestion</span>
                </div>
                <div class="w-8 h-8 rounded-full bg-gray-200 overflow-hidden">
                    <img alt="User" class="w-full h-full object-cover" src="https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?q=80&w=100&auto=format&fit=crop"/>
                </div>
            </header>

            <div class="flex-1 overflow-y-auto p-4 md:p-8">
                <div class="max-w-[1200px] mx-auto flex flex-col gap-6">
                    
                    <div class="flex items-center gap-2 text-sm text-ink-light">
                        <a href="#" class="hover:text-primary transition-colors">Inicio</a>
                        <span>/</span>
                        <span class="text-ink dark:text-white font-medium">Usuarios</span>
                    </div>

                    <div class="flex flex-col md:flex-row md:items-end justify-between gap-4">
                        <div class="flex flex-col gap-2">
                            <h1 class="heading-xl !text-3xl md:!text-4xl">Gestión de Usuarios</h1>
                            <p class="text-body max-w-2xl">Administra el acceso y permisos de voluntarios, veterinarios y adoptantes.</p>
                        </div>
                    </div>

                    <div class="card flex flex-col md:flex-row gap-4 p-4 items-center">
                        <div class="relative grow w-full">
                            <span class="material-symbols-outlined input-icon">search</span>
                            <input class="input-field" placeholder="Buscar por nombre o email..." type="text"/>
                        </div>
                        <div class="flex gap-3 w-full md:w-auto">
                            <select class="input-field w-full md:w-40 h-11 py-0 cursor-pointer">
                                <option value="">Todos los Roles</option>
                                <option value="admin">Admin</option>
                                <option value="volunteer">Voluntario</option>
                                <option value="vet">Veterinario</option>
                            </select>
                            <button class="btn btn-secondary px-3">
                                <span class="material-symbols-outlined">filter_list</span>
                            </button>
                        </div>
                    </div>

                    <div class="bg-surface-card dark:bg-surface-cardDark rounded-xl shadow-sm border border-border-light dark:border-border-dark overflow-hidden">
                        <div class="overflow-x-auto">
                            <table class="w-full text-left border-collapse">
                                <thead class="bg-gray-50 dark:bg-gray-900 border-b border-border-light dark:border-border-dark">
                                    <tr>
                                        <th class="table-header text-xs uppercase tracking-wider text-ink-light">Usuario</th>
                                        <th class="table-header text-xs uppercase tracking-wider text-ink-light">Rol</th>
                                        <th class="table-header text-xs uppercase tracking-wider text-ink-light">Zona Asignada</th>
                                        <th class="table-header text-xs uppercase tracking-wider text-ink-light">Estado</th>
                                        <th class="table-header text-right"></th>
                                    </tr>
                                </thead>
                                <tbody class="divide-y divide-border-light dark:divide-border-dark">
                                    <c:forEach items="${usuarios}" var="u">

                                        <tr class="hover:bg-gray-50 dark:hover:bg-gray-900/50 transition-colors">

                                            <td class="table-cell whitespace-nowrap">
                                                <div class="flex items-center gap-3">
                                                    <div class="w-10 h-10 rounded-full bg-primary/10 flex items-center justify-center text-primary font-bold">
                                                        ${u.nombre.charAt(0)}${u.apellido.charAt(0)}
                                                    </div>
                                                    <div class="flex flex-col">
                                                        <p class="text-sm font-bold">${u.nombre} ${u.apellido}</p>
                                                        <p class="text-xs text-ink-light">${u.email}</p>
                                                    </div>
                                                </div>
                                            </td>

                                            <td class="table-cell whitespace-nowrap">
                                                <c:choose>
                                                    <c:when test="${u.rol == 'ADMIN'}">
                                                        <span class="badge badge-admin">
                                                            <span class="material-symbols-outlined text-[14px]">admin_panel_settings</span>
                                                            Administrador
                                                        </span>
                                                    </c:when>
                                                    <c:when test="${u.rol == 'VOLUNTARIO'}">
                                                        <span class="badge badge-volunteer">
                                                            <span class="material-symbols-outlined text-[14px]">volunteer_activism</span>
                                                            Voluntario
                                                        </span>
                                                    </c:when>
                                                    <c:when test="${u.rol == 'VETERINARIO'}">
                                                        <span class="badge badge-vet">
                                                            <span class="material-symbols-outlined text-[14px]">medical_services</span>
                                                            Veterinario
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge badge-adopter">
                                                            <span class="material-symbols-outlined text-[14px]">pets</span>
                                                            ${u.rol}
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>

                                            <td class="table-cell whitespace-nowrap text-sm">
                                                <c:out value="${u.zona != null ? u.zona.nombre : 'Sin Zona Asignada'}" />
                                            </td>

                                            <td class="table-cell whitespace-nowrap">
                                                <div class="flex items-center gap-2 text-sm font-medium">
                                                    <span class="h-2 w-2 rounded-full ${u.activo ? 'bg-emerald-500' : 'bg-gray-400'}"></span> 
                                                    ${u.activo ? 'Activo' : 'Inactivo'}
                                                </div>
                                            </td>

                                            <td class="table-cell text-right">
                                                <a href="UsuarioServlet?accion=editar&id=${u.idUsuario}" class="text-ink-light hover:text-primary transition-colors">
                                                    <span class="material-symbols-outlined">edit</span>
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>

                                    <c:if test="${empty usuarios}">
                                        <tr>
                                            <td colspan="5" class="p-8 text-center text-ink-light">
                                                No hay usuarios registrados en el sistema.
                                            </td>
                                        </tr>
                                    </c:if>

                                </tbody>
                            </table>
                        </div>

                        <div class="flex items-center justify-between px-6 py-4 border-t border-border-light dark:border-border-dark bg-surface-card dark:bg-surface-cardDark">
                            <p class="text-sm text-ink-light">Mostrando <span class="font-bold text-ink dark:text-white">1-5</span> de <span class="font-bold">24</span> resultados</p>
                            <div class="flex items-center gap-2">
                                <button class="w-8 h-8 flex items-center justify-center rounded-lg border border-border-light dark:border-gray-700 hover:bg-gray-100 dark:hover:bg-gray-800 disabled:opacity-50" disabled>
                                    <span class="material-symbols-outlined text-[18px]">chevron_left</span>
                                </button>
                                <button class="w-8 h-8 flex items-center justify-center rounded-lg bg-primary text-white font-bold text-sm shadow-sm">1</button>
                                <button class="w-8 h-8 flex items-center justify-center rounded-lg border border-border-light dark:border-gray-700 hover:bg-gray-100 text-sm">2</button>
                                <button class="w-8 h-8 flex items-center justify-center rounded-lg border border-border-light dark:border-gray-700 hover:bg-gray-100">
                                    <span class="material-symbols-outlined text-[18px]">chevron_right</span>
                                </button>
                            </div>
                        </div>
                    </div>
                    
                </div>
            </div>
        </main>
    </div>
</body>
</html>