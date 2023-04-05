import 'package:ceylife_digital/utils/enums.dart';

const String PNG_IMAGE_PATH = 'images/pngs/';
const String SVG_IMAGE_PATH = 'images/svgs/';
const String PDF_SAVE_PATH = "storage/emulated/0/Ceylife Digital";
const String ANIM_PATH = 'animation/';
const String SVG_TYPE = '.svg';
const String PNG_TYPE = '.png';
const String PDF_TYPE = '.pdf';
const String ANIM_TYPE = '.json';

const String CEYLINCO_LIFE = 'Ceylinco Life';
const String serverDefaultPublicKey =
    "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCku6XJ4F2x/+v7nqYUYavQ1Pemki6dbhyhrpVD2Jpr8NXlF988YUtxaDncM0vP0z2dT/nLFTnNqY/sb9Qu9yVQ1n9DsQy9Zy6iDeEFpQ8kaUEHpi5QAvnXxfnueZjDkIwrMmzL4/0GPHVuMs7IcaZHic1rIbfgiL9EtU2YJ2obrQIDAQAB";

const String SERVICE_REQUEST_STATUS_PENDING_INPUT = "Pending Input";
const String SERVICE_REQUEST_STATUS_CLOSED = "Closed";

const String BUY_ONLINE_LIFE_INSURANCE = "BO_LI_WEB_LK";
const String BUY_ONLINE_CUSTOMIZED_LIFE = "BO_CLI_WEB_LK";
const String BUY_ONLINE_RETIREMENT = "BO_RP_WEB_LK";
const String BUY_ONLINE_INVESTMENT = "BO_IP_WEB_LK";

const String CURRENCY_CODE = 'LKR ';

const String YYYY_MM_DD = 'yyyy-MM-dd';
const String YYYY_MM_DD_HH_mma = 'yyyy-MM-dd HH:mma';
const String YYYY_MM_DD_HH_mm_a = 'yyyy-MM-dd HH:mm a';

const int APP_SESSION_TIMEOUT = 4 * 60;
const int UPLOAD_FILE_SIZE_IN_MB = 3 * 1024 * 1024;
const String XOR = "4C32945B5D34C7732F2AF7C751D0BFB6";

class AppConstants {
  static final String fontFamily = 'SohoGothicPro';
  static final String appName = 'CeyLife Digital';
  static final String androidAppID = 'com.ceylincolife.ceylifeapp';
  static final String iOSAppID = '1573194159';

  static String VENDOR_ANDROID = 'com.android.vending';
  static String VENDOR_HUAWEI = 'com.huawei.appmarket';
  static String VENDOR_IOS = 'com.apple.AppStore';
  static String TESTFLIGHT_IOS = 'com.apple.TestFlight';

  static Languages APP_LANGUAGE = Languages.ENGLISH;
  static double LOADING_PROGRESS = 0;

  static bool IS_USER_LOGGED = false;
  static bool IS_BIOMETRIC_ENABLED = false;

  static final int CLIENT_USER_TYPE_POLICY_HOLDER = 1;
  static final int CLIENT_USER_TYPE_VERIFIED_WEB_USER = 2;
  static final int CLIENT_USER_TYPE_NON_VERIFIED_WEB_USER = 3;
  static final int CLIENT_USER_TYPE_NEW_USER = 4;
  static final int CLIENT_USER_TYPE_CLIENT_LEAD_GENERATOR = 5;
  static final int CLIENT_USER_TYPE_VERIFIED_WEB_LEAD_GENERATOR = 6;
  static final int CLIENT_USER_TYPE_NON_VERIFIED_WEB_LEAD_GENERATOR = 7;
  static final int CLIENT_USER_TYPE_MOBILE_USER = 8;
  static final int CLIENT_USER_TYPE_LEAD_GENERATOR = 9;
  static final int CLIENT_USER_TYPE_DUAL_USER = 10;
  static String SERVER_PMK = "";
  static String SERVER_KCV = "";

  // static final int CLIENT_USER_TYPE_NEW_USER = 1;
  static final int CLIENT_USER_TYPE_NON_VERIFIED_USER = 2;
  static final int CLIENT_USER_TYPE_VERIFIED_USER = 3;

  static final int PAYMENT_HISTORY_PAGE_SIZE = 20;

  static final int FAQ_REF_WEB = 1;
  static final int FAQ_REF_EMAIL = 2;
  static final int FAQ_REF_TEL = 3;

  static final int PAYMENT_TYPE_RECURRING = 1;
  static final int PAYMENT_TYPE_ONE_TIME = 2;

  static final int POLICY_HOLDER_REGISTRATION = 1;
  static final int LEAD_GENERATOR_REGISTRATION = 2;

  static final String SERVICE_REQUEST_PROFILE = "PFC";
  static final String SERVICE_REQUEST_CUSTOMER = "GNR";
  static final String SERVICE_REQUEST_ALL = "ALL";

  static final String DIRECT_PAY_SUCCESS_STATE = "SUCCESS";
  static final String DIRECT_PAY_FAILED_STATE = "FAILED";

  static final String PROMOTION_TYPE_PRE = 'pre';
  static final String PROMOTION_TYPE_POST = 'post';
  static final String PROMOTION_TYPE_ALL = 'all';

  static final String localeEN = 'en';
  static final String localeSI = 'si';
  static final String localeTA = 'ta';

  static final String STATUS_NOTIFICATION_DELETE = "NDT";
  static final String STATUS_NOTIFICATION_UNREAD = "NUR";
  static final String STATUS_NOTIFICATION_READ = "NRD";

  static final String NOTIFICATION_TYPE_NEWS = "NEWS";
  static final String NOTIFICATION_TYPE_PROMO = "PROMO";

  static final String defaultDropdownHint = 'Select ---------------';

  static String LAST_LOGIN = '';
  static int UNREAD_NOTIFICATION_COUNT = 0;
}
