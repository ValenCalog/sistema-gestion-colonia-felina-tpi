<%-- 
    Document   : cabecera-estilos
    Created on : Jan 27, 2026, 12:14:28 AM
    Author     : mvale
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;700;800&display=swap" rel="stylesheet" />
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0&display=swap" rel="stylesheet" />

<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>

<script src="${pageContext.request.contextPath}/recursos/js/configuracion-tema.js"></script>

<style type="text/tailwindcss">
        @layer components {
            /* Botón Base */
            .btn {
                @apply flex items-center justify-center overflow-hidden rounded-xl h-10 px-6 
                       font-bold transition-colors cursor-pointer whitespace-nowrap;
            }
            .btn-primary {
                @apply bg-primary text-ink hover:bg-primary/90;
            }
            .btn-secondary {
                @apply bg-[#f0f4f0] text-ink hover:bg-[#e2e8e2] 
                       dark:bg-border-dark dark:text-white dark:hover:bg-[#C48C51];
            }
            .btn-outline {
                @apply border border-white/20 text-white hover:bg-white/10;
            }

            /* Tarjetas */
            .card {
                @apply flex flex-col gap-5 rounded-2xl border border-[#dce6db] bg-surface-card p-8 
                       dark:border-border-dark dark:bg-surface-cardDark transition-all duration-300;
            }
            
            /* Iconos */
            .icon-circle {
                @apply size-14 rounded-full bg-[#f0f4f0] dark:bg-border-dark flex items-center justify-center text-primary;
            }

            /* Utilidades de texto comunes */
            .heading-xl {
                @apply text-ink dark:text-white text-4xl font-black leading-tight tracking-tight lg:text-6xl;
            }
            .text-body {
                @apply text-ink-light dark:text-gray-400 text-base font-normal leading-relaxed;
            }
            
            /* ... (Tus estilos anteriores de input-field, btn, etc.) ... */

            /* --- DASHBOARD & ADMIN --- */
            .sidebar-link {
                @apply flex items-center gap-3 px-3 py-3 rounded-lg text-ink-light dark:text-gray-400 
                       hover:bg-gray-100 dark:hover:bg-gray-800 hover:text-ink dark:hover:text-white transition-all cursor-pointer;
            }
            .sidebar-link-active {
                @apply flex items-center gap-3 px-3 py-3 rounded-lg bg-primary text-white shadow-sm shadow-primary/30 font-semibold;
            }

            .stat-card {
                @apply flex flex-col p-5 bg-surface-card dark:bg-surface-cardDark rounded-xl border border-border-light dark:border-border-dark shadow-sm;
            }

            .table-header {
                @apply px-6 py-4 whitespace-nowrap text-left;
            }
            .table-cell {
                @apply px-6 py-4 text-ink dark:text-gray-200;
            }
            .badge {
                @apply inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium;
            }
            
            /* ... Estilos anteriores ... */

            /* --- BADGES (Para Roles y Estados) --- */
            .badge {
                @apply inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full text-xs font-bold border;
            }
            .badge-admin {
                @apply bg-blue-50 text-blue-700 border-blue-100 dark:bg-blue-900/20 dark:text-blue-300 dark:border-blue-900/30;
            }
            .badge-volunteer {
                @apply bg-green-50 text-green-700 border-green-100 dark:bg-green-900/20 dark:text-green-300 dark:border-green-900/30;
            }
            .badge-vet {
                @apply bg-purple-50 text-purple-700 border-purple-100 dark:bg-purple-900/20 dark:text-purple-300 dark:border-purple-900/30;
            }
            .badge-adopter {
                @apply bg-orange-50 text-orange-700 border-orange-100 dark:bg-orange-900/20 dark:text-orange-300 dark:border-orange-900/30;
            }
            
        }
</style>