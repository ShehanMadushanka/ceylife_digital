import 'package:ceylife_digital/error/failures.dart';
import 'package:ceylife_digital/features/domain/entities/request/accumulation_rate_history_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/request/biometric_registration_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/request/branches_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/request/create_user_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/request/customer_initiated_category_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/request/customer_initiated_service_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/request/generate_payment_link_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/request/get_bank_branches_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/request/get_notification_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/request/health_tips_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/request/initiate_customer_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/request/key_exchange_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/request/login_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/request/notification_status_change_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/request/otp_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/request/password_reset_otp_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/request/password_reset_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/request/payment_details_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/request/payment_status_check_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/request/policy_details_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/request/policy_info_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/request/policy_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/request/production_detail_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/request/profile_data_update_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/request/promotions_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/request/register_lead_generator_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/request/resend_otp_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/request/splash_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/request/submit_bank_details_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/request/update_password_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/request/user_profile_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/request/verify_new_lead_generator_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/accumulation_rate_history_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/biometric_registration_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/branch_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/contact_us_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/create_user_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/customer_initiated_category_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/customer_initiated_service_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/faq_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/generate_payment_link_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/get_bank_branches_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/get_banks_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/get_csr_main_category_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/get_notification_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/health_tip_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/initiate_customer_service_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/key_exchange_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/login_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/news_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/otp_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/password_reset_otp_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/password_reset_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/payment_details_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/payment_status_check_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/policy_details_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/policy_info_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/policy_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/product_category_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/product_type_data_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/profile_data_update_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/promotion_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/rates_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/register_lead_generator_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/resend_otp_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/splash_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/submit_bank_details_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/update_password_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/user_profile_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/verify_new_lead_generator_response_entity.dart';
import 'package:dartz/dartz.dart';

abstract class Repository {
  Future<Either<Failure, PromotionResponseEntity>> getPromotions(
      PromotionsRequestEntity getPostRequest);

  Future<Either<Failure, BranchResponseEntity>> getBranches(
      BranchesRequestEntity branchesRequestEntity);

  Future<Either<Failure, FAQResponseEntity>> getFAQ();

  Future<Either<Failure, GetNewsResponseEntity>> getNews();

  Future<Either<Failure, ProductCategoryEntityResponse>> getProductCategories();

  Future<Either<Failure, GetProductDetailResponseEntity>> getProductDetails(
      ProductDetailRequestEntity productDetailRequestEntity);

  Future<Either<Failure, LoginResponseEntity>> getLogin(
      LoginRequestEntity loginRequestEntity);

  Future<Either<Failure, SplashResponseEntity>> splashRequest(
      SplashRequestEntity splashRequestEntity);

  Future<Either<Failure, PolicyResponseEntity>> getPolicy(
      PolicyRequestEntity policyRequestEntity);

  Future<Either<Failure, OtpResponseEntity>> getOtp(
      OtpRequestEntity otpRequestEntity);

  Future<Either<Failure, CreateUserResponseEntity>> createUser(
      CreateUserRequestEntity createUserRequestEntity);

  Future<Either<Failure, UserProfileResponseEntity>> getUserProfile(
      UserProfileRequestEntity userProfileRequestEntity);

  Future<Either<Failure, ProfileDataUpdateResponseEntity>> updateProfileData(
      ProfileDataUpdateRequestEntity profileDataUpdateRequestEntity);

  Future<Either<Failure, UpdatePasswordResponseEntity>> updatePassword(
      UpdatePasswordRequestEntity updatePasswordRequestEntity);

  Future<Either<Failure, List<ContactUsEntity>>> getContactUs();

  Future<Either<Failure, ResendOtpResponseEntity>> resendOtp(
      ResendOtpRequestEntity resendOtpRequestEntity);

  Future<Either<Failure, CustomerInitiatedCategoryResponseEntity>>
      getCustomerInitiatedCategories(
          CustomerInitiatedCategoryRequestEntity categoryRequestEntity);

  Future<Either<Failure, InitiateCustomerServiceResponseEntity>>
      initiateCustomerServiceRequest(
          InitiateCustomerServiceRequestEntity
              initiateCustomerServiceRequestEntity);

  Future<Either<Failure, CustomerInitiatedServiceResponseEntity>>
      getCustomerInitiatedService(
          CustomerInitiatedServiceRequestEntity
              customerInitiatedServiceRequestEntity);

  Future<Either<Failure, PaymentDetailsResponseEntity>> getPaymentDetails(
      PaymentDetailsRequestEntity paymentDetailsRequestEntity);

  Future<Either<Failure, PolicyDetailsResponseEntity>> getPolicyDetails(
      PolicyDetailsRequestEntity policyDetailsRequestEntity);

  Future<Either<Failure, GeneratePaymentLinkResponseEntity>> getPaymentLink(
      GeneratePaymentLinkRequestEntity generatePaymentLinkRequestEntity);

  Future<Either<Failure, PaymentStatusCheckResponseEntity>> checkPaymentStatus(
      PaymentStatusCheckRequestEntity paymentStatusCheckRequestEntity);

  Future<Either<Failure, PolicyInfoResponseEntity>> getPolicyBenefitsData(
      PolicyInfoRequestEntity policyInfoRequestEntity);

  Future<Either<Failure, PolicyInfoResponseEntity>> getPolicyLoanData(
      PolicyInfoRequestEntity policyInfoRequestEntity);

  Future<Either<Failure, GetNotificationResponseEntity>> getNotifications(
      GetNotificationRequestEntity getNotificationRequestEntity);

  Future<Either<Failure, GetNotificationResponseEntity>>
      changeNotificationStatus(
          NotificationStatusChangeRequestEntity
              notificationStatusChangeRequestEntity);

  Future<Either<Failure, HealthTipsResponseEntity>> getHealthTips(
      HealthTipsRequestEntity healthTipsRequestEntity);

  Future<Either<Failure, AccumulationRateResponseEntity>> getAccumulationRate();

  Future<Either<Failure, AccumulationRateHistoryResponseEntity>>
      getAccumulationRateHistory(
          AccumulationRateHistoryRequestEntity
              accumulationRateHistoryRequestEntity);

  Future<Either<Failure, SubmitBankDetailsResponseEntity>> submitBankDetails(
      SubmitBankDetailsRequestEntity submitBankDetailsRequestEntity);

  Future<Either<Failure, BanksResponseEntity>> getBanks();

  Future<Either<Failure, GetBankBranchesResponseEntity>> getBankBranches(
      GetBankBranchesRequestEntity getBankBranchesRequestEntity);

  Future<Either<Failure, VerifyNewLeadGeneratoResponseEntity>>
      verifyNewLeadGenerator(
          VerifyNewLeadGeneratorRequestEntity
              verifyNewLeadGeneratorRequestEntity);

  Future<Either<Failure, RegisterLeadGeneratorResponseEntity>>
      registerLeadGenerator(
          RegisterLeadGeneratorRequestEntity
              registerLeadGeneratorRequestEntity);

  Future<Either<Failure, KeyExchangeResponseEntity>> keyExchange(
      KeyExchangeRequestEntity keyExchangeRequestEntity);

  Future<Either<Failure, BiometricRegistrationResponseEntity>>
      biometricRegistration(
          BiometricRegistrationRequestEntity
              biometricRegistrationRequestEntity);

  Future<Either<Failure, PasswordResetOtpResponseEntity>>
      passwordResetOtpRequest(
          PasswordResetOtpRequestEntity passwordResetOtpRequestEntity);

  Future<Either<Failure, PasswordResetResponseEntity>> passwordReset(
      PasswordResetRequestEntity passwordResetRequestEntity);

  Future<Either<Failure, GetCsrMainCategoryResponseEntity>> getCSRMainCategories();
}
