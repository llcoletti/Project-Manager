/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Enum.java to edit this template
 */
package enums;

import java.util.Collections;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;


public enum Profile {
    ADMIN("Admin"),
    USER("Usuário");
    
    private String name;

    private static final Map<String,Profile> ENUM_MAP;

    Profile (String name) {
        this.name = name;
    }

    public String getName() {
        return this.name;
    }

    static {
        Map<String,Profile> map = new ConcurrentHashMap<String, Profile>();
        for (Profile instance : Profile.values()) {
            map.put(instance.getName().toLowerCase(),instance);
        }
        ENUM_MAP = Collections.unmodifiableMap(map);
    }

    public static Profile get (String name) {
        return ENUM_MAP.get(name.toLowerCase());
    }
}
