 tailwind.config = {
            darkMode: 'media', 
            theme: {
                extend: {
                    fontFamily: {
                        sans: ['"Plus Jakarta Sans"', 'sans-serif'],
                    },
                    colors: {
                        primary: {
                            DEFAULT: "#ee8c2b", // naranja
                            hover: "#D6A424"
                        },
                        
                        ink: {
                            DEFAULT: "#121811", // Texto oscuro principal
                            light: "#51614f",   // Texto secundario
                            dark: "#ffffff"     // Texto en modo oscuro
                        },
                        surface: {
                            light: "#f6f8f6",   // Fondo pagina claro
                            dark: "#221910",    // Fondo pagina oscuro
                            card: "#ffffff",    // Fondo tarjetas
                            cardDark: "#2E2418" // Fondo tarjetas oscuro
                        },
                        border: {
                            light: "#e0e6e0",
                            dark: "#735630"
                        }
                    }
                }
            }
}
