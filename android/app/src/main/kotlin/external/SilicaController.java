package external;

import java.util.HashMap;
import java.util.Map;

public class SilicaController {
    public static String positivePHValue = "WXpZNE5qSXlObU5sT1RneU9EY3dNR0ZsTXpjelpUa3hOR1ZqTUdFM1l6VmpaVGs0TWpkallqZzFaR1ZoTnpJNU1tVTJZMlkzWm1abVl6Z3lNemxsTUdZNU9HVTVZak16";
    public static String negativePHValue = "WXpZNFkyVTVPRFl5TWpZeU9EY3dNR0ZsTXpjelpUa3hOR1ZqTUdFM1kyVTVPR00xTWpkallqZzFaR1ZoTnpJNU1tVTJZMlkzWm1abVl6Z3lNMk5sT1RnNVpUQm1PVGhsT1dJek13PT0=";
    public static String astrumConstant = "TVRnME1UZGtOVEZpTURFeU9FSnNkbVl3T1RFM1pUYzVaV1U1TURCaFltWmxZalJoWVRVNVl6VXhNamhDYkhZeFltUTJOV0kwTlRaalpqSXpaVE5pTmpBM1kyUTJOemRsWWpoak9RPT0=";
    public static String orbitalStarShip = "TVRnME1UZGtOVEZpTUdZeE1qaENiSFl3T1RFM1pUYzVaV1U1TVRJNFFteDJNREJoWW1abFlqUmhZVFU1WXpVeFltUTJOV0kwTVRJNFFteDJOVFpqWmpJelpUTmlOakEzWTJRMk56ZGxZamhqT1E9PQ==";
    public static String raptorEngine = "TkdVd09UWTJaV0V5ZERadGMyUTVNR0psTmpobE9XSmxaWFEyYlhOa09UQTFPVGczT1RFNE1UVTBaV05pTldNMU5UYzBOVE0yTmpBMVpUZ3pNVFF4TmpKa05ESmlZV0l3T0dObE5EazA=";
    public static String lunarConstant = "TkdVd09UWTJaV0V5WW1VMk9HVTVZbVZsTlRrNE56bDBObTF6WkRrd01UZ3hOVFJsZERadGMyUTVNR05pTldNMU5UYzBOVE0yTmpBMVpUZ3pNWFEyYlhOa09UQTBNVFl5WkRReVltRmlNRGhqWlRRNU5BPT0=";

    public static Map<String, String> pepperMasking(String key, String value){
        Map<String, String> encode = new HashMap<>();
        encode.put(key, value);
        return encode;
    }
}