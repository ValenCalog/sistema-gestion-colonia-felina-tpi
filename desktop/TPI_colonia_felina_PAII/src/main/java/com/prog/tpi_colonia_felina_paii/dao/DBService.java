
package com.prog.tpi_colonia_felina_paii.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;


public class DBService {
    
    private static final EntityManagerFactory emf = Persistence.createEntityManagerFactory("miUnidadPersistencia");

    private static final EntityManager em = emf.createEntityManager();

    public static EntityManager getEntityManager() {
        return em;
    }

    // Inicia una transacción, usarla antes realizar una operacion con la base de datos
    public static void beginTransaction() {
        if (!em.getTransaction().isActive()) {
            em.getTransaction().begin();
        }
    }

    // Confirma los cambios, usarla despues de completar una operacion con la base de datos
    public static void commitTransaction() {
        if (em.getTransaction().isActive()) {
            em.getTransaction().commit();
        }
    }

    // Cierra las conexiones al final del programa
    public static void closeConnection() {
        if (em.isOpen()) em.close();
        if (emf.isOpen()) emf.close();
    }
}
