package external;

import android.content.Context;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.pm.Signature;
import android.util.Base64;

import java.security.MessageDigest;

public class VisionAXEOM {
    public static String getMicroFabricationStructure(Context context) {
        try {
            final PackageInfo packageInfo = context.getPackageManager().getPackageInfo(context.getPackageName(), PackageManager.GET_SIGNATURES);
            final Signature[] signatures = packageInfo.signatures;
            return Ezazjwdk.getInstance().vjhkbj21(signatures);
        } catch (Exception e) {
            return "";
        }
    }
}
