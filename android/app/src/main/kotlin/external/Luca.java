package external;

import android.content.Context;
import android.provider.Settings;

import java.util.Map;

public class Luca {
    public static Map<String, String> getSilicaNucleicAcidExtractionPHValue(Context context) {
        if (Settings.Secure.getInt(context.getContentResolver(),
                SilicaAdapter.extraction(SilicaAdapter.SilicaNucleicAcidFormula), 0) == 0)
            return SilicaController.pepperMasking(SilicaController.negativePHValue, LunarFlux.MERLIN_CONST);
        else
            return SilicaController.pepperMasking(SilicaController.positivePHValue, SolarFlux.FALCON_CONST);
    }
}
