/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Enum.java to edit this template
 */
package enums;

import java.util.Collections;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;


public enum Classification {
    ALTA("Alta"),
    MEDIA("Média"),
    BAIXA("Baixa");
    
    private String name;

    private static final Map<String,Classification> ENUM_MAP;

    Classification (String name) {
        this.name = name;
    }

    public String getName() {
        return this.name;
    }

    static {
        Map<String,Classification> map = new ConcurrentHashMap<String, Classification>();
        for (Classification instance : Classification.values()) {
            map.put(instance.getName().toLowerCase(),instance);
        }
        ENUM_MAP = Collections.unmodifiableMap(map);
    }

    public static Classification get (String name) {
        return ENUM_MAP.get(name.toLowerCase());
    }
}
