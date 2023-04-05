import 'package:ceylife_digital/core/network/network_config.dart';
import 'package:ceylife_digital/utils/app_constants.dart';
import 'package:ceylife_digital/utils/enums.dart';

import 'failures.dart';

class ErrorMessages {

  ///App Error Codes
  static const String APP_PASSWORD_MISMATCH = "A0001";
  static const String APP_PASSWORD_POLICY_MISMATCH = "A0002";
  static const String APP_USER_ID_TAKEN = "A0003";
  static const String APP_POLICY_VERIFY_FAILED = "A0004";
  static const String APP_POLICY_ALREADY_REGISTERED = "A0005";
  static const String APP_PASSWORD_MINIMUM_CHARACTERS = "A0006";
  static const String APP_PASSWORD_MINIMUM_CASES = "A0007";
  static const String APP_PASSWORD_MINIMUM_SPECIAL_CHARACTERS = "A0008";
  static const String APP_PASSWORD_SPECIAL_CHARACTERS = "A0009";
  static const String APP_PASSWORD_NO_USER_NAME = "A0010";
  static const String APP_BIOMETRIC_FINGER_ID = "A0011";
  static const String APP_BIOMETRIC_TOUCH_ID = "A0012";
  static const String APP_BIOMETRIC_FACE_ID = "A0013";
  static const String APP_BIOMETRIC_BIOMETRIC = "A0014";
  static const String APP_PAY_PREMIUM_RECURRING = "A0015";
  static const String APP_ENABLE_DISABLE_TOUCH_ID = "A0016";
  static const String APP_ENABLE_DISABLE_FINGERPRINT_ID = "A0017";
  static const String APP_PROMOTION_TITLE_HEAD = "A0018";
  static const String APP_VALID_TILL = "A0019";
  static const String APP_MOBILE_EMAIL_VERIFICATION = "A0020";
  static const String APP_INTERNET_FAILED = "A0021";
  static const String APP_HEALTH_TIP_ALL = "A0022";
  static const String APP_HEALTH_TIP_AGE_RANGE = "A0023";
  static const String APP_EMPTY_STATUS_NEWS = "A0024";
  static const String APP_EMPTY_STATUS_PAYMENT = "A0025";
  static const String APP_EMPTY_STATUS_REQUEST = "A0026";
  static const String APP_EMPTY_STATUS_NOTIFICATION = "A0027";
  static const String APP_EMPTY_STATUS_PROMOTION = "A0028";
  static const String APP_EMPTY_STATUS_HEALTH_TIP = "A0029";
  static const String APP_EMPTY_STATUS_RATE = "A0030";
  static const String APP_EMPTY_STATUS_PRODUCT_DETAIL = "A0031";
  static const String APP_EMPTY_STATUS_BENEFIT = "A0032";
  static const String APP_EMPTY_STATUS_LOAN = "A0033";
  static const String APP_EMPTY_STATUS_TITLE = "A0034";
  static const String APP_EMPTY_STATUS_DESCRIPTION = "A0035";
  static const String APP_EMPTY_DIRECTPAY_STATUS_SUCCESS = "A0036";
  static const String APP_EMPTY_DIRECTPAY_STATUS_FAILED = "A0037";
  static const String APP_INFO_TYPE_NAME = "A0038";
  static const String APP_INFO_TYPE_EMAIL = "A0039";
  static const String APP_INFO_TYPE_NIC = "A0040";
  static const String APP_INFO_TYPE_DOB = "A0041";
  static const String APP_INFO_TYPE_MOBILE = "A0042";
  static const String APP_INFO_TYPE_ADDRESS = "A0043";
  static const String APP_NOTIFICATION_TYPE_NEWS = "A0044";
  static const String APP_NOTIFICATION_TYPE_PROMO = "A0045";
  static const String APP_DRAWER_ITEM_PAYMENT_HISTORY = "A0046";
  static const String APP_DRAWER_ITEM_CUSTOMER_SERVICE = "A0047";
  static const String APP_DRAWER_ITEM_SETTINGS = "A0048";
  static const String APP_DRAWER_ITEM_PWD_RESET = "A0049";
  static const String APP_DRAWER_ITEM_BRANCH = "A0050";
  static const String APP_DRAWER_ITEM_CONTACT = "A0051";
  static const String APP_DRAWER_ITEM_FAQ = "A0052";
  static const String APP_DRAWER_ITEM_LANGUAGE = "A0053";
  static const String APP_POLICY_STATUS_DES_ACTIVE = "A0054";
  static const String APP_POLICY_STATUS_DES_LAPSED = "A0055";
  static const String APP_POLICY_STATUS_DES_PAIDUP = "A0056";
  static const String APP_POLICY_STATUS_DES_PROPOSAL = "A0057";
  static const String APP_POLICY_STATUS_DES_MATURED = "A0058";
  static const String APP_POLICY_STATUS_DES_BUY= "A0059";
  static const String APP_PAYMENT_TYPE_RECURRING= "A0060";
  static const String APP_PAYMENT_TYPE_ONE_TIME= "A0061";
  static const String APP_PRE_LANGUAGE_TITLE= "A0062";
  static const String APP_PRE_LANGUAGE_BUTTON= "A0063";
  static const String APP_COMMON_VERIFICATION_TYPE= "A0064";
  static const String APP_BIOMETRIC_PROMPT_TITLE= "A0065";
  static const String APP_BIOMETRIC_PROMPT_SUBTITLE= "A0066";
  static const String APP_BIOMETRIC_PROMPT_CANCEL= "A0067";
  static const String APP_ERROR_SOMETHING_WRONG= "A0068";
  static const String APP_ERROR_VERIFICATION= "A0069";
  static const String APP_PAYMENT_FREQUENCY_QUARTERLY= "A0070";
  static const String APP_PAYMENT_FREQUENCY_MONTHLY= "A0072";
  static const String APP_PAYMENT_FREQUENCY_YEARLY= "A0073";
  static const String APP_NOTIFICATION_MULTIPLE_DELETE= "A0074";
  static const String APP_BRANCH_LOCATOR_SEARCH= "A0075";
  static const String APP_BRANCH_LOCATOR_MTOF= "A0076";
  static const String APP_BRANCH_LOCATOR_SAT= "A0077";
  static const String APP_BRANCH_LOCATOR_SUN= "A0078";

  String mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ConnectionFailure:
        return mapAPIErrorCode(APP_INTERNET_FAILED, '');
      case ServerFailure:
        return (failure as ServerFailure).errorResponse.responseError;
      case AuthorizedFailure:
        return 'Unauthorized User';
      default:
        return 'Unexpected error';
    }
  }

  String mapAPIErrorCode(String errorCode, String errorMessage){
    if(errorCode == APIResponse.RESPONSE_FAILED_FORCE_UPDATE){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "App Update Required";
          break;
        case Languages.SINHALA:
          return "යෙදුම් යාවත්කාලීන කිරීම අවශ්‍යයි";
          break;
        case Languages.TAMIL:
          return "அப் அப்டேட் செய்வது அவசிமாகும்.";
          break;
      }
    }else if(errorCode == APIResponse.RESPONSE_APPLICATION_VERSIOM_NO_MISMATCH){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "Application Version No Mismatch";
          break;
        case Languages.SINHALA:
          return "ඇප් පතේ  අනුවාදය නොගැලපේ";
          break;
        case Languages.TAMIL:
          return "அப்ளிக்கேஷன் வகை பொருந்தவில்லை";
          break;
      }
    }else if(errorCode == APIResponse.RESPONSE_UNKNOWN_OS){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "Unknown OS";
          break;
        case Languages.SINHALA:
          return "හදුනාගත නොහැකි OS එකකි";
          break;
        case Languages.TAMIL:
          return "அறியப்படாத OS.";
          break;
      }
    }else if(errorCode == APIResponse.RESPONSE_UNKNOWN_VERSION_NO){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "Unknown Version No";
          break;
        case Languages.SINHALA:
          return "නොදන්නා අනුවාදය අංකයකි";
          break;
        case Languages.TAMIL:
          return "அறியப்படாத வகை";
          break;
      }
    }else if(errorCode == APIResponse.RESPONSE_INVALID_APP_HASH){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "Invalid App Hash";
          break;
        case Languages.SINHALA:
          return "වලංගු නොවන ඇප් පුරකයකි";
          break;
        case Languages.TAMIL:
          return "செல்லுபடியற்ற அப் ஹாஷ்";
          break;
      }
    }else if(errorCode == APIResponse.RESPONSE_SUCCESS_OTP_NOT_SEND){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "Failed";
          break;
        case Languages.SINHALA:
          return "අසමත් විය";
          break;
        case Languages.TAMIL:
          return "வெற்றியளிக்கவில்லை";
          break;
      }
    }else if(errorCode == APIResponse.RESPONSE_DEVICE_TOKEN_INSERT_FAILED){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "Device Token Insert Failed";
          break;
        case Languages.SINHALA:
          return "උපාංග ටෝකනය ඇතුළු කිරීම අසාර්ථක විය";
          break;
        case Languages.TAMIL:
          return "டிவைஸ் டோக்கன் வெற்றியளிக்கவில்லை";
          break;
      }
    }else if(errorCode == APIResponse.RESPONSE_DEVICE_UPDATE_FAILED){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "Device Update Failed";
          break;
        case Languages.SINHALA:
          return "උපාංග යාවත්කාලීන කිරීම අසාර්ථක විය";
          break;
        case Languages.TAMIL:
          return "டிவைஸ் அப்டேட் வெற்றியளிக்கவில்லை";
          break;
      }
    }else if(errorCode == APIResponse.RESPONSE_DEVICE_ID_MISSING){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "Device Id Missing";
          break;
        case Languages.SINHALA:
          return "උපාංග හැඳුනුම්පත අස්ථානගත වී ඇත";
          break;
        case Languages.TAMIL:
          return "டிவைஸ் அடையாளம் வெற்றியளிக்கவில்லை";
          break;
      }
    }else if(errorCode == APIResponse.RESPONSE_USER_NOT_FOUND){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "User Not Found";
          break;
        case Languages.SINHALA:
          return "පරිශීලකයා හමු නොවීය";
          break;
        case Languages.TAMIL:
          return "பயனரை கண்டறியப்படவில்லை";
          break;
      }
    }else if(errorCode == APIResponse.RESPONSE_USER_MOBILE_NO_NOT_FOUND){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "User Mobile No Not Found";
          break;
        case Languages.SINHALA:
          return "පරිශීලක ජංගම දුරකථන අංකය හමු නොවීය";
          break;
        case Languages.TAMIL:
          return "பயனரின் மொபைல் இல கண்டறியப்படவில்லை";
          break;
      }
    }else if(errorCode == APIResponse.RESPONSE_USER_EMAIL_NOT_FOUND){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "User Email Not Found";
          break;
        case Languages.SINHALA:
          return "පරිශීලක විද්‍යුත් තැපෑල හමු නොවීය";
          break;
        case Languages.TAMIL:
          return "பயனரின் மின்னஞ்சல் கண்டறியப்படவில்லை";
          break;
      }
    }else if(errorCode == APIResponse.RESPONSE_MULTIPLE_RECORDS_UPDATED){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "Multiple Records Updated";
          break;
        case Languages.SINHALA:
          return "බහු වාර්තා යාවත්කාලීන කරන ලදි";
          break;
        case Languages.TAMIL:
          return "பல்வேறு பதிவுகள் அப்டேட் செய்யப்பட்டது";
          break;
      }
    }else if(errorCode == APIResponse.RESPONSE_OTP_VALIDATION_FAILED){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "OTP Validation Failed";
          break;
        case Languages.SINHALA:
          return "OTP වලංගුකරණය අසාර්ථක විය";
          break;
        case Languages.TAMIL:
          return "OTP பயன் வெற்றியளிக்கவில்லை.";
          break;
      }
    }else if(errorCode == APIResponse.RESPONSE_OTP_EXPIRED){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "OTP Expired";
          break;
        case Languages.SINHALA:
          return "කල්ඉකුත්වූ OTP  එකකි";
          break;
        case Languages.TAMIL:
          return "OTP காலாவதியாகிவிட்டது.";
          break;
      }
    }else if(errorCode == APIResponse.RESPONSE_INVALID_PASSWORD){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "Invalid Password";
          break;
        case Languages.SINHALA:
          return "වලංගු නොවන මුරපදය";
          break;
        case Languages.TAMIL:
          return "செல்லுபடியற்ற கடவுச்சொல்";
          break;
      }
    }else if(errorCode == APIResponse.RESPONSE_INVALID_USER_KEY_TYPE){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "Invalid User Key Type";
          break;
        case Languages.SINHALA:
          return "පරිශීලක විසින් දෙනලද වලංගු නොවන යෙදවුමකි";
          break;
        case Languages.TAMIL:
          return "செல்லுபடியற்ற பயனர் வகை";
          break;
      }
    }else if(errorCode == APIResponse.RESPONSE_INVALID_REQUESTED_DATA){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "Invalid Requested Data";
          break;
        case Languages.SINHALA:
          return "ඉල්ලුම් කල වලංගු නොවන දත්ත";
          break;
        case Languages.TAMIL:
          return "டேட்டா கோரிக்கை செல்லுபடியற்றது";
          break;
      }
    }else if(errorCode == APIResponse.RESPONSE_INVALID_USER){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "User already exist";
          break;
        case Languages.SINHALA:
          return "පරිශීලකයා දැනටමත් පවතී";
          break;
        case Languages.TAMIL:
          return "பயனர் ஏற்கனவே உள்ளார்";
          break;
      }
    }else if(errorCode == APIResponse.RESPONSE_FAILED_EXISTING_USER_ID){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "Username Already Exist";
          break;
        case Languages.SINHALA:
          return "මෙම පරිශීලක නාමය දැනටමත් පවතී";
          break;
        case Languages.TAMIL:
          return "பயனர் பெயர் முன்னர் பதிவு செய்யப்பட்டுள்ளது";
          break;
      }
    }else if(errorCode == APIResponse.RESPONSE_FAILED_OTP_SEND){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "OTP Sending Failed";
          break;
        case Languages.SINHALA:
          return "OTP යැවීම අසාර්ථක විය";
          break;
        case Languages.TAMIL:
          return "OTP அனுப்புவது வெற்றியளிக்கவில்லை";
          break;
      }
    }else if(errorCode == APIResponse.RESPONSE_USER_TEMPORILY_LOCKED){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "User Temporarily Locked";
          break;
        case Languages.SINHALA:
          return "මෙම පරිශීලකයා තාවකාලිකව ලොක්කර ඇත";
          break;
        case Languages.TAMIL:
          return "பயனர் தற்காலிகமாக முடக்கபட்டுள்ளார்";
          break;
      }
    }else if(errorCode == APIResponse.RESPONSE_FAILED_REQUEST_PENDING ){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "Customer Initiated Service Request Already In Progress";
          break;
        case Languages.SINHALA:
          return "පාරිභෝගිකයා විසින් ආරම්භ කරන ලද සේවා ඉල්ලීම මේ වන විටත් ක්‍රියාත්මක වෙමින් පවතී";
          break;
        case Languages.TAMIL:
          return "வாடிக்கையாளரின் சேவை கோரிக்கை முன்னரே செயற்பாட்டிலுள்ளது";
          break;
      }
    }else if(errorCode == APIResponse.RESPONSE_CUSTOMER_INITIATED_SERVICE_REQUEST_ALREADY_IN_PROGRESS){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "Invalid Payment Type";
          break;
        case Languages.SINHALA:
          return "වලංගු නොවන ගෙවීමකි";
          break;
        case Languages.TAMIL:
          return "செல்லுபடியற்ற கொடுப்பனவு முறை";
          break;
      }
    }else if(errorCode == APIResponse.RESPONSE_PREMIUM_CESS_DATE_EXPIRED){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "Premium Cess Date Expired";
          break;
        case Languages.SINHALA:
          return "වාරික සෙස් බදු දිනය කල් ඉකුත් වී ඇත";
          break;
        case Languages.TAMIL:
          return "கட்டுப்பணத் திகதி முடிவுற்றுள்ளது";
          break;
      }
    }else if(errorCode == APIResponse.RESPONSE_FAILED_TRANSACTION_NOT_FOUND){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "Transaction Not Found";
          break;
        case Languages.SINHALA:
          return "ගනුදෙනුව සොයාගත නොහැක ";
          break;
        case Languages.TAMIL:
          return "கொடுப்பனவு கண்டறியப்படவில்லை";
          break;
      }
    }else if(errorCode == APP_PASSWORD_MISMATCH){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "New password and confirm password do not match.";
          break;
        case Languages.SINHALA:
          return "නව මුරපදය සහ තහවුරු කළ මුරපදය නොගැලපේ.";
          break;
        case Languages.TAMIL:
          return "புதிய கடவுச்சொல் மற்றும் உறுதிப்படுத்திய கடவுச்சொல் பொருந்தவில்லை.";
          break;
      }
    }else if(errorCode == APP_PASSWORD_POLICY_MISMATCH){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "Password do not match with our password policy.";
          break;
        case Languages.SINHALA:
          return "මෙම මුරපදය අපගේ මුරපද ප්‍රතිපත්තිය සමඟ නොගැලපේ.";
          break;
        case Languages.TAMIL:
          return "எமது கடவுச்சொல் கொள்கையுடன் இக்கடவுச்சொல் பொருந்தவில்லை.";
          break;
      }
    }else if(errorCode == APP_USER_ID_TAKEN){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "This user ID is already taken.";
          break;
        case Languages.SINHALA:
          return "මෙම පරිශීලක හැඳුනුම්පත දැනටමත් ගෙන ඇත.";
          break;
        case Languages.TAMIL:
          return "இந்த பயனர் அடையளாம் முன்னரே எடுக்கப்பட்டுள்ளது.";
          break;
      }
    }else if(errorCode == APP_POLICY_VERIFY_FAILED){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "We are unable to verify you as the policy holder. Please insert the valid NIC number to continue.";
          break;
        case Languages.SINHALA:
          return "ඔබව රක්‍ෂණ හිමියා ලෙස තහවුරු කර ගැනීමට අපට නොහැකිය. ඉදිරියට යාමට කරුණාකර වලංගු ජාතික හැඳුනුම්පත් අංකය ඇතුළු කරන්න.";
          break;
        case Languages.TAMIL:
          return "உங்களை காப்புறுதிதாரராக உறுதிப்படுத்த முடியவில்லை. தயைகூர்ந்து உங்கள் NIC இலக்கத்தை பதிவேற்றி தொடருங்கள்.";
          break;
      }
    }else if(errorCode == APP_POLICY_ALREADY_REGISTERED){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "You are an already registered policy holder.";
          break;
        case Languages.SINHALA:
          return "ඔබ දැනටමත් ලියාපදිංචි රක්‍ෂණ හිමියෙකි.";
          break;
        case Languages.TAMIL:
          return "நீங்கள் ஏற்கனவே பதியப்பட்ட காப்புறுதிதாரர்.";
          break;
      }
    }else if(errorCode == APP_PASSWORD_MINIMUM_CHARACTERS){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "Passwords must be at least $errorMessage characters.";
          break;
        case Languages.SINHALA:
          return "මුරපද අවම වශයෙන් අකුරු $errorMessage ක් විය යුතුය.";
          break;
        case Languages.TAMIL:
          return "கடவுச்சொற்கள் குறைந்தது $errorMessage எழுத்துகளாக இருக்க வேண்டும்.";
          break;
      }
    }else if(errorCode == APP_PASSWORD_MINIMUM_CASES){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "Should contain at least ${errorMessage.split("|")[0]} numeral, ${errorMessage.split("|")[1]} uppercase, and ${errorMessage.split("|")[2]} lowercase letter.";
          break;
        case Languages.SINHALA:
          return 'අවම වශයෙන් සංඛ්‍යා ${errorMessage.split("|")[0]} ක්, ලොකු අකුරු ${errorMessage.split("|")[1]} ක් සහ කුඩා අකුරු ${errorMessage.split("|")[2]} ක් වත් අඩංගු විය යුතුය.';
          break;
        case Languages.TAMIL:
          return "குறிப்பாக ${errorMessage.split("|")[0]} இலக்கங்கள், ${errorMessage.split("|")[1]} கப்பிட்டல் மற்றும் ${errorMessage.split("|")[2]} சிம்பிள் எழுத்துக்கள் உள்ளடக்கப்பட வேண்டும்.";
          break;
      }
    }else if(errorCode == APP_PASSWORD_MINIMUM_SPECIAL_CHARACTERS){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "Should contain at least $errorMessage special characters.";
          break;
        case Languages.SINHALA:
          return "අවම වශයෙන් විශේෂ අක්ෂර $errorMessage ක් වත් අඩංගු විය යුතුය.";
          break;
        case Languages.TAMIL:
          return "குறிப்பாக $errorMessage விசேட குறியீடுகள் உள்ளடக்கப்பட வேண்டும்.";
          break;
      }
    }else if(errorCode == APP_PASSWORD_SPECIAL_CHARACTERS){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "Special characters should be $errorMessage";
          break;
        case Languages.SINHALA:
          return "විශේෂ අකුරු තිබිය යුතුයි $errorMessage";
          break;
        case Languages.TAMIL:
          return "விசேட குறியீடுகள் ஆவண $errorMessage";
          break;
      }
    }else if(errorCode == APP_PASSWORD_NO_USER_NAME){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "Password should not contain the username.";
          break;
        case Languages.SINHALA:
          return "මුරපදයේ පරිශීලක නාමය අඩංගු නොවිය යුතුය.";
          break;
        case Languages.TAMIL:
          return "கடவுச்சொல்லில் உங்கள் பெயரை உள்ளடக்க வேண்டாம்.";
          break;
      }
    }else if(errorCode == APP_BIOMETRIC_FINGER_ID){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "Login with fingerprint ID";
          break;
        case Languages.SINHALA:
          return "ඇඟිලි සලකුණු හැඳුනුම්පත සමඟ ලොග් වන්න";
          break;
        case Languages.TAMIL:
          return "கைரேகை அடையாத்துடன் உள்நுழைக";
          break;
      }
    }else if(errorCode == APP_BIOMETRIC_TOUCH_ID){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "Login with touch ID";
          break;
        case Languages.SINHALA:
          return "ස්පර්ශ හැඳුනුම්පත සමඟඇතුල්වන්න";
          break;
        case Languages.TAMIL:
          return "தொடுகை அடையாளத்துடன் உள்நுழைக";
          break;
      }
    }else if(errorCode == APP_BIOMETRIC_FACE_ID){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "Login with face ID";
          break;
        case Languages.SINHALA:
          return "මුහුණු හැඳුනුම්පත සමඟ ඇතුල්වන්න";
          break;
        case Languages.TAMIL:
          return "முக அடையாளத்துடன் உள்நுழைக";
          break;
      }
    }else if(errorCode == APP_BIOMETRIC_BIOMETRIC){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "Login using biometrics";
          break;
        case Languages.SINHALA:
          return "ජෛවමිතික භාවිතයෙන් ඇතුල්වන්න";
          break;
        case Languages.TAMIL:
          return "பயோமெட்ரிக்கினை பயன்படுத்தி உள்நுளைக";
          break;
      }
    }else if(errorCode == APP_PAY_PREMIUM_RECURRING){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "You are about to make a recurring payment. This payment will repeat each Month till $errorMessage.\n\nAre you sure to confirm?";
          break;
        case Languages.SINHALA:
          return "ඔබ නැවත නැවත ගෙවීමක් කිරීමට සැරසේ. මෙම ගෙවීම සෑම මසකම $errorMessage දක්වා නැවත සිදු කෙරේ.\n\nඔබට මෙය  තහවුරු කිරීමට අවශ්‍යය බව විශ්වාසද?";
          break;
        case Languages.TAMIL:
          return "நீங்கள் தொடர் கொடுப்பனவினை மேற்கொண்டுள்ளீர்கள். இக்கொடுப்பனவினை $errorMessage வரை ஒவ்வொரு மாதமும் மேற்கொள்ள வேண்டும்.\n\nநீங்கள் தொடர விரும்புகின்றீர்களா?";
          break;
      }
    }else if(errorCode == APP_ENABLE_DISABLE_TOUCH_ID){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "Enable or disable Touch ID option";
          break;
        case Languages.SINHALA:
          return "ස්පර්ශ හැඳුනුම්පත සක්‍රීය හෝ අක්‍රීය කරන්න";
          break;
        case Languages.TAMIL:
          return "தொடுகை அடையாளத்தை செயற்படுத்த அல்லது நிறுத்த";
          break;
      }
    }else if(errorCode == APP_ENABLE_DISABLE_FINGERPRINT_ID){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "Enable or disable Fingerprint ID option";
          break;
        case Languages.SINHALA:
          return "ඇඟිලි සලකුණු හැඳුනුම්පත සක්‍රීය හෝ අක්‍රීය කරන්න";
          break;
        case Languages.TAMIL:
          return "கைரேகை அடையாளத்தை செயற்படுத்த அல்லது நிறுத்த";
          break;
      }
    }else if(errorCode == APP_PROMOTION_TITLE_HEAD){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "Hey, You are eligible for $errorMessage ongoing Promotions";
          break;
        case Languages.SINHALA:
          return "මේ මොහොතේ පවතින ප්‍රවර්ධන $errorMessageක් ලබාගැනීමට ඔබට සුදුසුකම් ඇත";
          break;
        case Languages.TAMIL:
          return "நடைபெற்றுக்கொண்டிருக்கும் பிரசார $errorMessage மேம்படுத்தல்களுக்கு நீங்கள் தகுதியுடையவர்";
          break;
      }
    }else if(errorCode == APP_VALID_TILL){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "Valid till $errorMessage";
          break;
        case Languages.SINHALA:
          return "$errorMessage දක්වා වලංගු වේ";
          break;
        case Languages.TAMIL:
          return "செல்லுபடியாகும் காலம் $errorMessage";
          break;
      }
    }else if(errorCode == APP_MOBILE_EMAIL_VERIFICATION){
      var contactInfo = errorMessage.split('|');
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          if(contactInfo.length == 2)
            return "Enter the verification code we sent to\nyour mobile ${contactInfo[0]}\nand your email ${contactInfo[1]}";
          else
            return "Enter the verification code we sent to\nyour mobile ${contactInfo[0]}";
          break;
        case Languages.SINHALA:
          if(contactInfo.length == 2)
            return "අපි ඔබගේ ජංගම දුරකථනයට ${contactInfo[0]}\nසහ ඔබගේ විද්‍යුත් තැපෑලට ${contactInfo[1]} යැවූ සත්‍යාපන කේතය ඇතුළත් කරන්න";
          else
            return "අපි ඔබගේ ජංගම දුරකථනයට ${contactInfo[0]} යැවූ සත්‍යාපන කේතය ඇතුළත් කරන්න";
          break;
        case Languages.TAMIL:
          if(contactInfo.length == 2)
            return "உங்கள் மொபைல் ${contactInfo[0]} மற்றும் மின்னஞ் ${contactInfo[1]} சலுக்கு நாம் அனுப்பிய இலக்கத்தை உட்புகுத்தவும்";
          else
            return "உங்கள் மொபைல் ${contactInfo[0]} சலுக்கு நாம் அனுப்பிய இலக்கத்தை உட்புகுத்தவும்";
          break;
      }
    }else if(errorCode == APP_INTERNET_FAILED){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "No internet connection detected.";
          break;
        case Languages.SINHALA:
          return "අන්තර්ජාල සම්බන්ධතාවයක් අනාවරණය වී නොමැත.";
          break;
        case Languages.TAMIL:
          return "இணைய இணைப்பு கண்டறியப்படவில்லை.";
          break;
      }
    }else if(errorCode == APP_HEALTH_TIP_ALL){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "All";
          break;
        case Languages.SINHALA:
          return "සියලුම";
          break;
        case Languages.TAMIL:
          return "அனைத்து";
          break;
      }
    } else if(errorCode == APP_HEALTH_TIP_AGE_RANGE){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "${errorMessage.split('|')[0]} to ${errorMessage.split('|')[1]}";
          break;
        case Languages.SINHALA:
          return "${errorMessage.split('|')[0]} සිට ${errorMessage.split('|')[1]} දක්වා";
          break;
        case Languages.TAMIL:
          return "${errorMessage.split('|')[0]} முதல் ${errorMessage.split('|')[1]} வரை";
          break;
      }
    }else if(errorCode == APP_EMPTY_STATUS_NEWS){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "News";
          break;
        case Languages.SINHALA:
          return "පුවත්";
          break;
        case Languages.TAMIL:
          return "செய்திகள்";
          break;
      }
    }else if(errorCode == APP_EMPTY_STATUS_PAYMENT){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "Payments";
          break;
        case Languages.SINHALA:
          return "ගෙවීමක්";
          break;
        case Languages.TAMIL:
          return "கொடுப்பனவுகள்";
          break;
      }
    }else if(errorCode == APP_EMPTY_STATUS_REQUEST){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "Requests";
          break;
        case Languages.SINHALA:
          return "ඉල්ලීමක්";
          break;
        case Languages.TAMIL:
          return "கோரிக்கை";
          break;
      }
    }else if(errorCode == APP_EMPTY_STATUS_NOTIFICATION){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "Notifications";
          break;
        case Languages.SINHALA:
          return "දැනුම් දීමක්";
          break;
        case Languages.TAMIL:
          return "அறிவிப்பு";
          break;
      }
    }else if(errorCode == APP_EMPTY_STATUS_PROMOTION){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "Promotions";
          break;
        case Languages.SINHALA:
          return "ප්\u200Dරවර්ධන";
          break;
        case Languages.TAMIL:
          return "பதவி உயர்வு";
          break;
      }
    }else if(errorCode == APP_EMPTY_STATUS_HEALTH_TIP){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "Health tips";
          break;
        case Languages.SINHALA:
          return "සෞඛ්‍ය උපදෙස්";
          break;
        case Languages.TAMIL:
          return "ஆரோக்கிய குறிப்பு";
          break;
      }
    }else if(errorCode == APP_EMPTY_STATUS_RATE){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "Rates";
          break;
        case Languages.SINHALA:
          return "අනුපාතයක්";
          break;
        case Languages.TAMIL:
          return "விகிதம்";
          break;
      }
    }else if(errorCode == APP_EMPTY_STATUS_PRODUCT_DETAIL){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "Product details";
          break;
        case Languages.SINHALA:
          return "නිෂ්පාදන විස්තර";
          break;
        case Languages.TAMIL:
          return "தயாரிப்பு விவரம்";
          break;
      }
    }else if(errorCode == APP_EMPTY_STATUS_BENEFIT){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "Benefits";
          break;
        case Languages.SINHALA:
          return "ප්‍රතිලාභ";
          break;
        case Languages.TAMIL:
          return "பலன்";
          break;
      }
    }else if(errorCode == APP_EMPTY_STATUS_LOAN){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "Loan details";
          break;
        case Languages.SINHALA:
          return "ණය විස්තර";
          break;
        case Languages.TAMIL:
          return "கடன் விவரம்";
          break;
      }
    }else if(errorCode == APP_EMPTY_STATUS_TITLE){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "There are no $errorMessage to show";
          break;
        case Languages.SINHALA:
          return "පෙන්වීමට $errorMessage නොමැත";
          break;
        case Languages.TAMIL:
          return "காட்டுவதற்கு எந்த இல்லை";
          break;
      }
    }else if(errorCode == APP_EMPTY_STATUS_DESCRIPTION){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "Currently you don’t have any $errorMessage to show.";
          break;
        case Languages.SINHALA:
          return "දැනට ඔබට පෙන්වීමට $errorMessage නොමැත.";
          break;
        case Languages.TAMIL:
          return "தற்போது உங்களிடம் காண்பிக்க எதுவும் இல்லை.";
          break;
      }
    }else if(errorCode == APP_EMPTY_DIRECTPAY_STATUS_SUCCESS){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "SUCCESS";
          break;
        case Languages.SINHALA:
          return "සාර්ථකයි";
          break;
        case Languages.TAMIL:
          return "வெற்றி";
          break;
      }
    }else if(errorCode == APP_EMPTY_DIRECTPAY_STATUS_FAILED){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "FAILED";
          break;
        case Languages.SINHALA:
          return "අසාර්ථකයි";
          break;
        case Languages.TAMIL:
          return "தோல்வி";
          break;
      }
    }else if(errorCode == APP_INFO_TYPE_NAME){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "Name with Initials";
          break;
        case Languages.SINHALA:
          return "මුලකුරු සමග නම";
          break;
        case Languages.TAMIL:
          return "முதலெழுத்துக்களுடன் பெயர்";
          break;
      }
    }else if(errorCode == APP_INFO_TYPE_EMAIL){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "E-mail";
          break;
        case Languages.SINHALA:
          return "ඊතැපැල් ලිපිනය";
          break;
        case Languages.TAMIL:
          return "மின்னஞ்சல் முகவரி";
          break;
      }
    }else if(errorCode == APP_INFO_TYPE_NIC){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "NIC Number";
          break;
        case Languages.SINHALA:
          return "ජාතික හැඳුනුම්පත් අංකය";
          break;
        case Languages.TAMIL:
          return "தேசிய அடையாள அட்டை இல";
          break;
      }
    }else if(errorCode == APP_INFO_TYPE_DOB){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "Date of Birth";
          break;
        case Languages.SINHALA:
          return "උපන් දිනය";
          break;
        case Languages.TAMIL:
          return "பிறந்த திகதி";
          break;
      }
    }else if(errorCode == APP_INFO_TYPE_MOBILE){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "Mobile Number";
          break;
        case Languages.SINHALA:
          return "ජංගම දූරකථන අංකය";
          break;
        case Languages.TAMIL:
          return "மொபைல் இலக்கம்";
          break;
      }
    }else if(errorCode == APP_INFO_TYPE_ADDRESS){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "Permanent Address";
          break;
        case Languages.SINHALA:
          return "ස්ථිර ලිපිනය";
          break;
        case Languages.TAMIL:
          return "நிரந்தர முகவரி";
          break;
      }
    }else if(errorCode == APP_NOTIFICATION_TYPE_NEWS){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "News";
          break;
        case Languages.SINHALA:
          return "පුවත්";
          break;
        case Languages.TAMIL:
          return "செய்தி";
          break;
      }
    }else if(errorCode == APP_NOTIFICATION_TYPE_PROMO){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "Promo";
          break;
        case Languages.SINHALA:
          return "ප්‍රවර්ධන";
          break;
        case Languages.TAMIL:
          return "மேம்படுத்தல்கள்";
          break;
      }
    }else if(errorCode == APP_DRAWER_ITEM_PAYMENT_HISTORY){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "Payment History";
          break;
        case Languages.SINHALA:
          return "ගෙවීම් පිළිබදව විස්තර";
          break;
        case Languages.TAMIL:
          return "கொடுப்பனவு வரலாறு";
          break;
      }
    }else if(errorCode == APP_DRAWER_ITEM_CUSTOMER_SERVICE){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "Customer Service Request";
          break;
        case Languages.SINHALA:
          return "පාරිභෝගික සේවා ඉල්ලීම";
          break;
        case Languages.TAMIL:
          return "வாடிக்கையாளர் சேவை கோரிக்கை";
          break;
      }
    }else if(errorCode == APP_DRAWER_ITEM_SETTINGS){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "Settings";
          break;
        case Languages.SINHALA:
          return "සැකසුම්";
          break;
        case Languages.TAMIL:
          return "அமைப்புக்கள்";
          break;
      }
    }else if(errorCode == APP_DRAWER_ITEM_PWD_RESET){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "Password Reset";
          break;
        case Languages.SINHALA:
          return "මුරපද යළි පිහිටුවීම";
          break;
        case Languages.TAMIL:
          return "கடவுச்சொல்லை மீட்டமை";
          break;
      }
    }else if(errorCode == APP_DRAWER_ITEM_BRANCH){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "Branch Locator";
          break;
        case Languages.SINHALA:
          return "ශාඛා පිහිටීම";
          break;
        case Languages.TAMIL:
          return "கிளை அமைவிடங்கள்";
          break;
      }
    }else if(errorCode == APP_DRAWER_ITEM_CONTACT){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "Contact Us";
          break;
        case Languages.SINHALA:
          return "අප අමතන්න";
          break;
        case Languages.TAMIL:
          return "எம்மை தொடர்புகொள்ள";
          break;
      }
    }else if(errorCode == APP_DRAWER_ITEM_FAQ){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "FAQ";
          break;
        case Languages.SINHALA:
          return "නි.අ.ප්‍ර";
          break;
        case Languages.TAMIL:
          return "அ.கேட்.கேள்";
          break;
      }
    }else if(errorCode == APP_DRAWER_ITEM_LANGUAGE){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "Language Selection";
          break;
        case Languages.SINHALA:
          return "භාෂා තෝරා ගැනීම";
          break;
        case Languages.TAMIL:
          return "மொழியை தேர்ந்தெடுக்க";
          break;
      }
    }else if(errorCode == APP_POLICY_STATUS_DES_ACTIVE){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "Active";
          break;
        case Languages.SINHALA:
          return "සක්‍රියයි";
          break;
        case Languages.TAMIL:
          return "செயலில்";
          break;
      }
    }else if(errorCode == APP_POLICY_STATUS_DES_LAPSED){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "Lapsed";
          break;
        case Languages.SINHALA:
          return "කල් ඉකුත් වී ඇත";
          break;
        case Languages.TAMIL:
          return "காலாவதியானது";
          break;
      }
    }else if(errorCode == APP_POLICY_STATUS_DES_PAIDUP){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "Paid-up";
          break;
        case Languages.SINHALA:
          return "ගෙවා නිම කල";
          break;
        case Languages.TAMIL:
          return "பணம்\nசெலுத்தப்பட்டது";
          break;
      }
    }else if(errorCode == APP_POLICY_STATUS_DES_PROPOSAL){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "Proposal";
          break;
        case Languages.SINHALA:
          return "යෝජනාව";
          break;
        case Languages.TAMIL:
          return "முன்மொழிவு";
          break;
      }
    }else if(errorCode == APP_POLICY_STATUS_DES_MATURED){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "Matured";
          break;
        case Languages.SINHALA:
          return "පරිණත";
          break;
        case Languages.TAMIL:
          return "முதிர்ச்சியடைந்தவர்";
          break;
      }
    }else if(errorCode == APP_POLICY_STATUS_DES_BUY){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "BUYONLINE";
          break;
        case Languages.SINHALA:
          return "ඔන්ලයින් මිලදී ගන්න";
          break;
        case Languages.TAMIL:
          return "இணையத்தில்\nவாங்கு";
          break;
      }
    }else if(errorCode == APP_PAYMENT_TYPE_RECURRING){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "Recurring Payment";
          break;
        case Languages.SINHALA:
          return "පුනරාවර්තන ගෙවීම";
          break;
        case Languages.TAMIL:
          return "தொடர்ச்சியான கட்டணம்";
          break;
      }
    }else if(errorCode == APP_PAYMENT_TYPE_ONE_TIME){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "One Time Payment";
          break;
        case Languages.SINHALA:
          return "එක් වරක් ගෙවීම";
          break;
        case Languages.TAMIL:
          return "ஒரு முறை கட்டணம்";
          break;
      }
    }else if(errorCode == APP_PRE_LANGUAGE_TITLE){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "Please select your preferred\nlanguage.";
          break;
        case Languages.SINHALA:
          return "කරුණාකර ඔබේ කැමති භාෂාව\nතෝරන්න.";
          break;
        case Languages.TAMIL:
          return "நீங்கள் விரும்பும் மொழியை\nதேர்ந்தெடுக்கவும்.";
          break;
      }
    }else if(errorCode == APP_PRE_LANGUAGE_BUTTON){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "Continue";
          break;
        case Languages.SINHALA:
          return "කරගෙන යන්න";
          break;
        case Languages.TAMIL:
          return "தொடர்வதற்கு";
          break;
      }
    }else if(errorCode == APP_COMMON_VERIFICATION_TYPE){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "Try $errorMessage verification instead";
          break;
        case Languages.SINHALA:
          return "ඒ වෙනුවට $errorMessage සත්‍යාපනය උත්සාහ කරන්න";
          break;
        case Languages.TAMIL:
          return "அதற்கு பதிலாக $errorMessage சரிபார்ப்பை முயற்சிக்கவும்";
          break;
      }
    }else if(errorCode == APP_BIOMETRIC_PROMPT_TITLE){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "Please authenticate to enable the service";
          break;
        case Languages.SINHALA:
          return "සේවාව සක්‍රීය කිරීම සඳහා කරුණාකර සත්‍යාපනය කරන්න";
          break;
        case Languages.TAMIL:
          return "சேவையை இயக்க தயவுசெய்து அங்கீகரிக்கவும்";
          break;
      }
    }else if(errorCode == APP_BIOMETRIC_PROMPT_SUBTITLE){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "Touch your finger on the fingerprint sensor";
          break;
        case Languages.SINHALA:
          return "ඇඟිලි සලකුණු සංවේදකය මත ඔබේ ඇඟිල්ල ස්පර්ශ කරන්න";
          break;
        case Languages.TAMIL:
          return "கைரேகை சென்சாரில் உங்கள் விரலைத் தொடவும்";
          break;
      }
    }else if(errorCode == APP_BIOMETRIC_PROMPT_CANCEL){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "Cancel";
          break;
        case Languages.SINHALA:
          return "අවලංගු කරන්න";
          break;
        case Languages.TAMIL:
          return "ரத்து";
          break;
      }
    }else if(errorCode == APP_ERROR_SOMETHING_WRONG){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "Something went wrong!";
          break;
        case Languages.SINHALA:
          return "මොකක්හරි වැරැද්දක් වෙලා!";
          break;
        case Languages.TAMIL:
          return "ஏதோ தவறு நடந்துவிட்டது!";
          break;
      }
    }else if(errorCode == APP_ERROR_VERIFICATION){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "App verification failed!";
          break;
        case Languages.SINHALA:
          return "යෙදුම් සත්‍යාපනය අසාර්ථකයි!";
          break;
        case Languages.TAMIL:
          return "ஆப் சரிபார்ப்பு தோல்வி!";
          break;
      }
    }else if(errorCode == APIResponse.RESPONSE_LOGIN_INVALID_CREDENTIALS){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "Invalid Credential";
          break;
        case Languages.SINHALA:
          return "වලංගු නොවන අක්තපත්ර‍‍‍";
          break;
        case Languages.TAMIL:
          return "தவறான சான்று";
          break;
      }
    }else if(errorCode == APIResponse.RESPONSE_LOGIN_FAILED){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "Login Failed";
          break;
        case Languages.SINHALA:
          return "ඇතුළු වීම අසාර්ථක විය‍‍‍";
          break;
        case Languages.TAMIL:
          return "உள்நுழைவு தோல்வியடைந்தது";
          break;
      }
    }else if(errorCode == APP_PAYMENT_FREQUENCY_QUARTERLY){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "QUARTERLY";
          break;
        case Languages.SINHALA:
          return "කාර්තුව";
          break;
        case Languages.TAMIL:
          return "காலாண்டு";
          break;
      }
    }else if(errorCode == APP_PAYMENT_FREQUENCY_MONTHLY){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "MONTHLY";
          break;
        case Languages.SINHALA:
          return "මාසිකව";
          break;
        case Languages.TAMIL:
          return "மாதாந்திர";
          break;
      }
    }else if(errorCode == APP_PAYMENT_FREQUENCY_YEARLY){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "YEARLY";
          break;
        case Languages.SINHALA:
          return "වාර්ෂිකව";
          break;
        case Languages.TAMIL:
          return "ஆண்டுதோறும்";
          break;
      }
    }else if(errorCode == APP_BRANCH_LOCATOR_SEARCH){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "Search...";
          break;
        case Languages.SINHALA:
          return "සෙවීම...";
          break;
        case Languages.TAMIL:
          return "செர்வு...";
          break;
      }
    }else if(errorCode == APP_BRANCH_LOCATOR_MTOF){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "Monday to Friday $errorMessage";
          break;
        case Languages.SINHALA:
          return "සඳුදා සිට සිකුරාදා දක්වා $errorMessage";
          break;
        case Languages.TAMIL:
          return "திங்கள் முதல் வெள்ளி வரை $errorMessage";
          break;
      }
    }else if(errorCode == APP_BRANCH_LOCATOR_SAT){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "Saturday $errorMessage";
          break;
        case Languages.SINHALA:
          return "සෙනසුරාදා $errorMessage";
          break;
        case Languages.TAMIL:
          return "சனிக்கிழமை $errorMessage";
          break;
      }
    }else if(errorCode == APP_BRANCH_LOCATOR_SUN){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "Sunday $errorMessage";
          break;
        case Languages.SINHALA:
          return "ඉරිදා $errorMessage";
          break;
        case Languages.TAMIL:
          return "ஞாயிற்றுக்கிழமை $errorMessage";
          break;
      }
    }else if(errorCode == APP_NOTIFICATION_MULTIPLE_DELETE){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return "Are you sure to delete the $errorMessage item(s) selected? Once confirmed this cannot be undone.";
          break;
        case Languages.SINHALA:
          return "තෝරාගත් අයිතම $errorMessage මැකීම ඔබ තහවුරු කරනවාද? තහවුරු වූ පසු මෙය ආපසු හැරවිය නොහැක.";
          break;
        case Languages.TAMIL:
          return "தேர்ந்தெடுக்கப்பட்ட $errorMessage உருப்படிகளை (களை) நிச்சயமாக நீக்க வேண்டுமா? ஒருமுறை உறுதி செய்தவுடன் இதை திரும்பப்பெற.";
          break;
      }
    }else{
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return errorMessage;
          break;
        case Languages.SINHALA:
          return errorMessage;
          break;
        case Languages.TAMIL:
          return errorMessage;
          break;
      }
    }
  }
}

