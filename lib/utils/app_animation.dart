import 'package:ceylife_digital/utils/app_constants.dart';

import 'enums.dart';

class AppAnimation {
  //Lotti
  static final String animError = ANIM_PATH + 'error' + ANIM_TYPE;
  static final String animSuccess = ANIM_PATH + 'success' + ANIM_TYPE;
  static final String animFailed = ANIM_PATH + 'failed' + ANIM_TYPE;
  static final String animStep1En = ANIM_PATH + 'stepper_step_1' + ANIM_TYPE;
  static final String animStep1Si = ANIM_PATH + 'stepper_si_1' + ANIM_TYPE;
  static final String animStep1Ta = ANIM_PATH + 'stepper_ta_1' + ANIM_TYPE;
  static final String animStep2En = ANIM_PATH + 'stepper_step_2' + ANIM_TYPE;
  static final String animStep2Si = ANIM_PATH + 'stepper_si_2' + ANIM_TYPE;
  static final String animStep2Ta = ANIM_PATH + 'stepper_ta_2' + ANIM_TYPE;
  static final String animStep3En = ANIM_PATH + 'stepper_step_2_5' + ANIM_TYPE;
  static final String animStep3Si = ANIM_PATH + 'stepper_si_3' + ANIM_TYPE;
  static final String animStep3Ta = ANIM_PATH + 'stepper_ta_3' + ANIM_TYPE;
  static final String animStep4En = ANIM_PATH + 'stepper_step_3' + ANIM_TYPE;
  static final String animStep4Si = ANIM_PATH + 'stepper_si_4' + ANIM_TYPE;
  static final String animStep4Ta = ANIM_PATH + 'stepper_ta_4' + ANIM_TYPE;
  static final String animLoading = ANIM_PATH + 'anim_loading' + ANIM_TYPE;
  static final String animEmpty = ANIM_PATH + 'anim_empty_screen' + ANIM_TYPE;
  static final String animOTP = ANIM_PATH + 'anim_otp' + ANIM_TYPE;
  static final String animIDCard = ANIM_PATH + 'anim_id_card' + ANIM_TYPE;
  static final String animAccountCreate =
      ANIM_PATH + 'anim_account_create' + ANIM_TYPE;
  static final String animDetails = ANIM_PATH + 'anim_details' + ANIM_TYPE;
  static final String animForgotPassword =
      ANIM_PATH + 'anim_forgot_password' + ANIM_TYPE;
  static final String animForceUpdate =
      ANIM_PATH + 'anim_force_update' + ANIM_TYPE;


  static String getStepperAnim(int step){
    if(step ==1){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return animStep1En;
          break;
        case Languages.SINHALA:
          return animStep1Si;
          break;
        case Languages.TAMIL:
          return animStep1Ta;
          break;
      }
    }else if(step == 2){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return animStep2En;
          break;
        case Languages.SINHALA:
          return animStep2Si;
          break;
        case Languages.TAMIL:
          return animStep2Ta;
          break;
      }
    }else if(step == 3){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return animStep3En;
          break;
        case Languages.SINHALA:
          return animStep3Si;
          break;
        case Languages.TAMIL:
          return animStep3Ta;
          break;
      }
    }else if(step == 4){
      switch(AppConstants.APP_LANGUAGE) {
        case Languages.ENGLISH:
          return animStep4En;
          break;
        case Languages.SINHALA:
          return animStep4Si;
          break;
        case Languages.TAMIL:
          return animStep4Ta;
          break;
      }
    }
  }
}
