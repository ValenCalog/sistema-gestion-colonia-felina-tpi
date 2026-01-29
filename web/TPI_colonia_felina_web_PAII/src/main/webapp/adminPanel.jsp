<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>GatoGestion - Panel de Administración</title>
    
    <jsp:include page="/WEB-INF/fragmentos/cabecera-estilos.jsp" />
    
    <style>
        /* Personalización de scrollbar para que sea sutil */
        ::-webkit-scrollbar { width: 8px; height: 8px; }
        ::-webkit-scrollbar-track { background: transparent; }
        ::-webkit-scrollbar-thumb { background: #cbd5e1; border-radius: 4px; }
        ::-webkit-scrollbar-thumb:hover { background: #94a3b8; }
    </style>
</head>
<body class="font-sans bg-surface-light dark:bg-surface-dark text-ink dark:text-white overflow-hidden">
    
    <div class="flex h-screen w-full">
        
        <aside class="flex w-72 flex-col border-r border-border-light dark:border-border-dark bg-surface-card dark:bg-surface-cardDark transition-all duration-300">
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
                    <a class="sidebar-link-active" href="#">
                        <span class="material-symbols-outlined">dashboard</span>
                        <span class="text-sm">Dashboard</span>
                    </a>
                    <a class="sidebar-link" href="AdminServlet">
                        <span class="material-symbols-outlined">group</span>
                        <span class="text-sm font-medium">Usuarios</span>
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
                            <img alt="Admin Avatar" class="w-full h-full object-cover" 
                                 src="https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?q=80&w=100&auto=format&fit=crop"/>
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
            
            <header class="flex-none px-8 py-6 bg-surface-card dark:bg-surface-cardDark border-b border-border-light dark:border-border-dark flex flex-wrap items-center justify-between gap-4 z-10">
                <div class="flex flex-col">
                    <h2 class="text-2xl font-black leading-tight">Analíticas</h2>
                    <p class="text-sm text-ink-light font-medium">Resumen general del sistema</p>
                </div>
                
                <div class="flex items-center gap-3">
                    <div class="relative">
                        <select class="appearance-none h-10 pl-4 pr-10 rounded-lg border border-border-light dark:border-border-dark bg-surface-card dark:bg-surface-cardDark text-sm font-medium focus:outline-none focus:ring-2 focus:ring-primary/50 cursor-pointer">
                            <option>Últimos 30 días</option>
                            <option>Último Trimestre</option>
                            <option>Este Año</option>
                        </select>
                        <span class="material-symbols-outlined absolute right-3 top-1/2 -translate-y-1/2 text-ink-light pointer-events-none text-lg">calendar_today</span>
                    </div>
                    
                    <button class="flex h-10 items-center gap-2 px-4 rounded-lg bg-gray-100 dark:bg-gray-800 hover:bg-gray-200 transition-colors text-sm font-bold">
                        <span class="material-symbols-outlined text-[18px]">download</span>
                        <span>Exportar</span>
                    </button>
                </div>
            </header>

            <div class="flex-1 overflow-y-auto p-8">
                <div class="max-w-[1280px] mx-auto flex flex-col gap-6">
                    
                    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
                        <div class="stat-card">
                            <div class="flex items-center justify-between mb-4">
                                <p class="text-ink-light text-sm font-semibold">Total Gatos</p>
                                <span class="material-symbols-outlined text-primary bg-primary/10 p-1.5 rounded-lg text-xl">pets</span>
                            </div>
                            <p class="text-3xl font-black mb-1">142</p>
                            <div class="flex items-center gap-1 text-green-600 text-xs font-bold">
                                <span class="material-symbols-outlined text-sm">trending_up</span>
                                <span>+2% vs mes anterior</span>
                            </div>
                        </div>

                        <div class="stat-card">
                            <div class="flex items-center justify-between mb-4">
                                <p class="text-ink-light text-sm font-semibold">Voluntarios Activos</p>
                                <span class="material-symbols-outlined text-primary bg-primary/10 p-1.5 rounded-lg text-xl">diversity_1</span>
                            </div>
                            <p class="text-3xl font-black mb-1">24</p>
                            <div class="flex items-center gap-1 text-green-600 text-xs font-bold">
                                <span class="material-symbols-outlined text-sm">person_add</span>
                                <span>+1 esta semana</span>
                            </div>
                        </div>

                        <div class="stat-card">
                            <div class="flex items-center justify-between mb-4">
                                <p class="text-ink-light text-sm font-semibold">Adopciones Exitosas</p>
                                <span class="material-symbols-outlined text-primary bg-primary/10 p-1.5 rounded-lg text-xl">home</span>
                            </div>
                            <p class="text-3xl font-black mb-1">12</p>
                            <div class="flex items-center gap-1 text-green-600 text-xs font-bold">
                                <span class="material-symbols-outlined text-sm">trending_up</span>
                                <span>+5% vs mes anterior</span>
                            </div>
                        </div>

                        <div class="stat-card">
                            <div class="flex items-center justify-between mb-4">
                                <p class="text-ink-light text-sm font-semibold">Tasa Esterilización</p>
                                <span class="material-symbols-outlined text-primary bg-primary/10 p-1.5 rounded-lg text-xl">medical_services</span>
                            </div>
                            <p class="text-3xl font-black mb-1">78%</p>
                            <div class="flex items-center gap-1 text-blue-600 text-xs font-bold">
                                <span class="material-symbols-outlined text-sm">target</span>
                                <span>Meta: 85%</span>
                            </div>
                        </div>
                    </div>

                    <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
                        
                        <div class="lg:col-span-2 stat-card p-6">
                            <div class="flex items-center justify-between mb-6">
                                <h3 class="font-bold">Avistamientos en el Tiempo</h3>
                                <button class="text-ink-light hover:text-primary"><span class="material-symbols-outlined">more_horiz</span></button>
                            </div>
                            <div class="relative h-[250px] w-full">
                                <svg class="w-full h-full" viewBox="0 0 100 50" preserveAspectRatio="none">
                                    <defs>
                                        <linearGradient id="grad" x1="0" x2="0" y1="0" y2="1">
                                            <stop offset="0%" stop-color="#ee8c2b" stop-opacity="0.2"/> <stop offset="100%" stop-color="#ee8c2b" stop-opacity="0"/>
                                        </linearGradient>
                                    </defs>
                                    <path d="M0,40 Q10,35 20,30 T40,25 T60,32 T80,20 T100,25 V50 H0 Z" fill="url(#grad)" />
                                    <path d="M0,40 Q10,35 20,30 T40,25 T60,32 T80,20 T100,25" fill="none" stroke="#ee8c2b" stroke-width="0.5" />
                                </svg>
                                <div class="flex justify-between text-xs text-ink-light mt-2">
                                    <span>Ene 01</span><span>Ene 10</span><span>Ene 20</span><span>Ene 30</span>
                                </div>
                            </div>
                        </div>

                        <div class="stat-card p-6 flex flex-col items-center justify-center">
                            <h3 class="font-bold w-full text-left mb-4">Estado de Salud</h3>
                            
                            <div class="relative w-48 h-48 rounded-full" 
                                 style="background: conic-gradient(#ee8c2b 0% 65%, #ef4444 65% 75%, #f59e0b 75% 85%, #10b981 85% 100%);">
                                <div class="absolute inset-4 bg-surface-card dark:bg-surface-cardDark rounded-full flex flex-col items-center justify-center">
                                    <p class="text-3xl font-black">142</p>
                                    <p class="text-xs text-ink-light">Total</p>
                                </div>
                            </div>
                            
                            <div class="grid grid-cols-2 gap-x-4 gap-y-2 mt-6 w-full text-xs">
                                <div class="flex items-center gap-2"><div class="w-3 h-3 rounded-full bg-primary"></div><span>Sanos (65%)</span></div>
                                <div class="flex items-center gap-2"><div class="w-3 h-3 rounded-full bg-green-500"></div><span>Esterilizados (15%)</span></div>
                                <div class="flex items-center gap-2"><div class="w-3 h-3 rounded-full bg-red-500"></div><span>Heridos (10%)</span></div>
                                <div class="flex items-center gap-2"><div class="w-3 h-3 rounded-full bg-yellow-500"></div><span>Enfermos (10%)</span></div>
                            </div>
                        </div>
                    </div>

                    <div class="stat-card p-0 overflow-hidden">
                        <div class="p-6 border-b border-border-light dark:border-border-dark flex justify-between items-center">
                            <h3 class="font-bold">Actividad Reciente del Sistema</h3>
                            <button class="text-sm text-primary font-bold hover:underline">Ver Todo</button>
                        </div>
                        <div class="overflow-x-auto">
                            <table class="w-full text-sm">
                                <thead class="bg-gray-50 dark:bg-gray-800/50 text-ink-light font-semibold border-b border-border-light dark:border-border-dark">
                                    <tr>
                                        <th class="table-header">Fecha/Hora</th>
                                        <th class="table-header">Usuario</th>
                                        <th class="table-header">Acción</th>
                                        <th class="table-header">Detalles</th>
                                    </tr>
                                </thead>
                                <tbody class="divide-y divide-border-light dark:divide-border-dark">
                                    <tr class="hover:bg-gray-50 dark:hover:bg-gray-800/30 transition-colors">
                                        <td class="table-cell font-medium">Hoy, 10:45 AM</td>
                                        <td class="table-cell font-bold">Maria Garcia</td>
                                        <td class="table-cell">
                                            <span class="badge bg-blue-100 text-blue-800">Actualización</span>
                                        </td>
                                        <td class="table-cell">Historial médico actualizado: Gato #402</td>
                                    </tr>
                                    <tr class="hover:bg-gray-50 dark:hover:bg-gray-800/30 transition-colors">
                                        <td class="table-cell font-medium">Hoy, 09:12 AM</td>
                                        <td class="table-cell font-bold">Juan Perez</td>
                                        <td class="table-cell">
                                            <span class="badge bg-green-100 text-green-800">Tarea</span>
                                        </td>
                                        <td class="table-cell">Alimentación completada en Zona B</td>
                                    </tr>
                                    </tbody>
                            </table>
                        </div>
                    </div>

                </div>
            </div>
        </main>
    </div>
</body>
</html>