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
        /* --- Botones --- */
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

        /* --- Tarjetas --- */
        .card {
            @apply flex flex-col gap-5 rounded-2xl border border-[#dce6db] bg-surface-card p-8 
                   dark:border-border-dark dark:bg-surface-cardDark transition-all duration-300;
        }
        
        /* --- Iconos --- */
        .icon-circle {
            @apply size-14 rounded-full bg-[#f0f4f0] dark:bg-border-dark flex items-center justify-center text-primary;
        }

        /* --- Textos --- */
        .heading-xl {
            @apply text-ink dark:text-white text-4xl font-black leading-tight tracking-tight lg:text-6xl;
        }
        .text-body {
            @apply text-ink-light dark:text-gray-400 text-base font-normal leading-relaxed;
        }

        /* --- FORMULARIOS (NUEVO: Para el Login) --- */
        .input-field {
            @apply flex w-full rounded-lg border border-border-light bg-surface-card 
                   px-4 py-3 pl-11 text-ink focus:border-primary focus:outline-none focus:ring-2 focus:ring-primary/50 
                   dark:border-border-dark dark:bg-surface-dark dark:text-white transition-all duration-200;
        }
        .input-icon {
            @apply absolute left-3 top-1/2 -translate-y-1/2 text-ink-light group-focus-within:text-primary transition-colors;
        }
        .link {
            @apply font-bold text-primary hover:text-primary/80 transition-colors cursor-pointer;
        }
    }
</style>