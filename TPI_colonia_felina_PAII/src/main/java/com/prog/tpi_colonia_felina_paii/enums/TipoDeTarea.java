
package com.prog.tpi_colonia_felina_paii.enums;

public enum TipoDeTarea {
    ALIMENTACION("Alimentación"),
    CAPTURA_CASTRACION("Captura para castración"),
    CONTROL_VETERINARIO("Control veterinario"),
    TRANSPORTE_HOGAR_TRANSITORIO("Transporte a hogar transitorio");
    
    private final String descripcion;

    TipoDeTarea(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getDescripcion() {
        return descripcion;
    }
    
    /* Lo de la descripcion es para que se vea mas legible cuando se 
     * muestre en las vistas, podemos hacer:
     *      tarea.getTipoDeTarea().getDescripcion();
    */
}
