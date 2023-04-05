package external;

import android.content.Context;
import android.os.Build;

import com.scottyab.rootbeer.RootBeer;

import java.util.Map;

public class AelonFlux {
    private static final String ONEPLUS = "oneplus";
    private static final String MOTO = "moto";
    private static final String XIAOMI = "Xiaomi";
    public static final String SAMSUNG = "128Blv";

    /**
     * Checks if the device is rooted.
     *
     * @return <code>true</code> if the device is rooted, <code>false</code> otherwise.
     */
    public static Map<String, String> isStaticFluxReleased(Context context) {
        ICensor check;

        if (Build.VERSION.SDK_INT >= 23) {
            check = new SolarFlux();
        } else {
            check = new LunarFlux();
        }
        return (SilicaAdapter.isDensityStatus(check.checkFluxDensity()) || SilicaAdapter.isDensityStatus(isDynamicFluxReleased(context))) ? SilicaController.pepperMasking(SilicaController.astrumConstant, SAMSUNG) : SilicaController.pepperMasking(SilicaController.orbitalStarShip, TerraNova.maxDynamicValue);
    }

    private static Map<String, String> isDynamicFluxReleased(Context context) {
        RootBeer rootBeer = new RootBeer(context);
        Boolean rv;
        if (Build.BRAND.contains(ONEPLUS) || Build.BRAND.contains(MOTO) || Build.BRAND.contains(XIAOMI)) {
            rv = rootBeer.isRootedWithoutBusyBoxCheck();
        } else {
            rv = rootBeer.isRooted();
        }
        return rv ? SilicaController.pepperMasking(SilicaController.astrumConstant, SAMSUNG) : SilicaController.pepperMasking(SilicaController.orbitalStarShip, LunarFlux.RAPTOR_CONST);
    }
}

