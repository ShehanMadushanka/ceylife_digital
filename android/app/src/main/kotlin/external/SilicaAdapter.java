package external;

import android.util.Base64;

import java.util.Map;

public class SilicaAdapter {
    public  static String SilicaNucleicAcidFormula = "VjFaa1UyRldaM2xXYmxaYVZqQndlbGRzWkZKUVVUMDk=";
    public  static String SilicaNucleicAlgoFormula = "VmxSQ2IxRm5QVDA9";

    public static String extraction(String message) {
        String txt = message;
        try {
            for (int i = 0; i < 4; i++) {
                byte[] data = Base64.decode(txt, Base64.NO_PADDING);
                txt = new String(data, "UTF-8");
            }
        } catch (Exception ex) {
        } finally {
            return txt;
        }
    }

    public static boolean isDensityStatus(Map<String, String> mapper){
        String txt = mapper.keySet().toArray()[0].toString();
        try {
            for (int i = 0; i < 2; i++) {
                byte[] data = Base64.decode(txt, Base64.NO_PADDING);
                txt = new String(data, "UTF-8");
            }
        } catch (Exception ex) {
        } finally {
            return txt.split(mapper.values().toArray()[0].toString()).length%2 != 0;
        }
    }
}
