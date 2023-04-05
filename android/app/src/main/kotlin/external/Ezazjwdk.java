package external;

import android.content.pm.Signature;
import android.util.Base64;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class Ezazjwdk {

    private static Ezazjwdk theInstance = null;

    public Ezazjwdk() {
    }

    public static synchronized Ezazjwdk getInstance() {
        if (theInstance == null) {
            theInstance = new Ezazjwdk();
        }
        return theInstance;
    }

    public String vjhkbj21(Signature[] signatures) {
        final MessageDigest md;
        try {
            md = MessageDigest.getInstance(SilicaAdapter.extraction(SilicaAdapter.SilicaNucleicAlgoFormula));
            String temp = "";
            for (Signature signature : signatures) {
                md.update(signature.toByteArray());
                final String currentSignature = Base64.encodeToString(md.digest(), Base64.DEFAULT);
                temp = temp.concat(currentSignature.trim());
            }

            return temp;
        } catch (NoSuchAlgorithmException e) {
            return "";
        }
    }

}
