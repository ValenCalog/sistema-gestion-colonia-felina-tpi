
package com.prog.tpi_colonia_felina_paii.util;

import org.mindrot.jbcrypt.BCrypt;

public final class PasswordHasher {
    
    private static final int COST = 12;

    private PasswordHasher(){}

    public static String hash(String passwordCruda) {
        if (passwordCruda == null || passwordCruda.isBlank()) {
            throw new IllegalArgumentException("Password vacío");
        }
        return BCrypt.hashpw(passwordCruda, BCrypt.gensalt(COST));
    }

    public static boolean matches(String passwordCruda, String hash) {
        return hash != null && BCrypt.checkpw(passwordCruda, hash);
    }
}
