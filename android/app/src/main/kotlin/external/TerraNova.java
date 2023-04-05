package external;

import android.os.Build;

import java.util.Map;

public class TerraNova {
    public static final  String maxDynamicValue = "128Blv";
    public static Map<String, String> hasMaxQPassed() {
        return (Build.FINGERPRINT.startsWith("generic")
                || Build.FINGERPRINT.startsWith("unknown")
                || Build.MODEL.contains("google_sdk")
                || Build.MODEL.contains("Emulator")
                || Build.MODEL.contains("Android SDK built for x86")
                || Build.MANUFACTURER.contains("Genymotion")
                || (Build.BRAND.startsWith("generic") && Build.DEVICE.startsWith("generic"))
                || "google_sdk".equals(Build.PRODUCT)) ? SilicaController.pepperMasking(SilicaController.lunarConstant, "t6msd90") : SilicaController.pepperMasking(SilicaController.raptorEngine, "t6msd90");
    }
}
