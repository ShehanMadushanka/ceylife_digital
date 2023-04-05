package external;

import android.content.Context;
import android.content.Intent;
import android.provider.Settings;

import androidx.biometric.BiometricManager;

public class BioWPN {
    public static boolean checkAvailability(Context context) {
        BiometricManager biometricManager = BiometricManager.from(context);
        switch (biometricManager.canAuthenticate()) {
            case BiometricManager.BIOMETRIC_SUCCESS:
                return true;
            case BiometricManager.BIOMETRIC_ERROR_NONE_ENROLLED:
            case BiometricManager.BIOMETRIC_ERROR_HW_UNAVAILABLE:
            case BiometricManager.BIOMETRIC_ERROR_NO_HARDWARE:
                return false;
            default:
                return false;
        }
    }
}
