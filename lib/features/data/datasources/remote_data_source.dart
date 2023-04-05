import 'dart:core';

import 'package:ceylife_digital/core/network/api_helper.dart';
import 'package:ceylife_digital/features/data/models/requests/accoumulation_rate_history_request.dart';
import 'package:ceylife_digital/features/data/models/requests/biometric_registration_request.dart';
import 'package:ceylife_digital/features/data/models/requests/create_user_request.dart';
import 'package:ceylife_digital/features/data/models/requests/customer_initiated_category_request.dart';
import 'package:ceylife_digital/features/data/models/requests/customer_initiated_service_request.dart';
import 'package:ceylife_digital/features/data/models/requests/generate_payment_link_request.dart';
import 'package:ceylife_digital/features/data/models/requests/get_bank_branches_request.dart';
import 'package:ceylife_digital/features/data/models/requests/get_brances_request.dart';
import 'package:ceylife_digital/features/data/models/requests/get_login_request.dart';
import 'package:ceylife_digital/features/data/models/requests/get_notification_request.dart';
import 'package:ceylife_digital/features/data/models/requests/get_otp_request.dart';
import 'package:ceylife_digital/features/data/models/requests/get_policy_request.dart';
import 'package:ceylife_digital/features/data/models/requests/get_product_detail_request.dart';
import 'package:ceylife_digital/features/data/models/requests/get_promotions_request.dart';
import 'package:ceylife_digital/features/data/models/requests/get_user_profile_request.dart';
import 'package:ceylife_digital/features/data/models/requests/health_tips_request.dart';
import 'package:ceylife_digital/features/data/models/requests/initiate_customer_service_request.dart';
import 'package:ceylife_digital/features/data/models/requests/key_exchange_request.dart';
import 'package:ceylife_digital/features/data/models/requests/notification_status_change_request.dart';
import 'package:ceylife_digital/features/data/models/requests/password_reset_otp_request.dart';
import 'package:ceylife_digital/features/data/models/requests/password_reset_request.dart';
import 'package:ceylife_digital/features/data/models/requests/payment_details_request.dart';
import 'package:ceylife_digital/features/data/models/requests/payment_status_check_request.dart';
import 'package:ceylife_digital/features/data/models/requests/policy_details_request.dart';
import 'package:ceylife_digital/features/data/models/requests/policy_info_request.dart';
import 'package:ceylife_digital/features/data/models/requests/profile_data_update_request.dart';
import 'package:ceylife_digital/features/data/models/requests/register_lead_generator_request.dart';
import 'package:ceylife_digital/features/data/models/requests/resend_otp_request.dart';
import 'package:ceylife_digital/features/data/models/requests/splash_request.dart';
import 'package:ceylife_digital/features/data/models/requests/submit_bank_details_request.dart';
import 'package:ceylife_digital/features/data/models/requests/update_password_request.dart';
import 'package:ceylife_digital/features/data/models/requests/verify_new_lead_generator_request.dart';
import 'package:ceylife_digital/features/data/models/responses/accumulation_rate_history_response.dart';
import 'package:ceylife_digital/features/data/models/responses/accumulation_rate_response.dart';
import 'package:ceylife_digital/features/data/models/responses/biometric_registration_response.dart';
import 'package:ceylife_digital/features/data/models/responses/create_user_response.dart';
import 'package:ceylife_digital/features/data/models/responses/customer_initiated_category_response.dart';
import 'package:ceylife_digital/features/data/models/responses/customer_initiated_service_response.dart';
import 'package:ceylife_digital/features/data/models/responses/generate_payment_link_response.dart';
import 'package:ceylife_digital/features/data/models/responses/get_bank_branches_response.dart';
import 'package:ceylife_digital/features/data/models/responses/get_banks_response.dart';
import 'package:ceylife_digital/features/data/models/responses/get_branch_response.dart';
import 'package:ceylife_digital/features/data/models/responses/get_contact_us_response.dart';
import 'package:ceylife_digital/features/data/models/responses/get_csr_main_category_response.dart';
import 'package:ceylife_digital/features/data/models/responses/get_faq_response.dart';
import 'package:ceylife_digital/features/data/models/responses/get_login_response.dart';
import 'package:ceylife_digital/features/data/models/responses/get_news_response.dart';
import 'package:ceylife_digital/features/data/models/responses/get_notification_response.dart';
import 'package:ceylife_digital/features/data/models/responses/get_otp_response.dart';
import 'package:ceylife_digital/features/data/models/responses/get_policy_response.dart';
import 'package:ceylife_digital/features/data/models/responses/get_product_detail_response.dart';
import 'package:ceylife_digital/features/data/models/responses/get_products_response.dart';
import 'package:ceylife_digital/features/data/models/responses/get_promotion_response.dart';
import 'package:ceylife_digital/features/data/models/responses/get_user_profile_response.dart';
import 'package:ceylife_digital/features/data/models/responses/health_tips_response.dart';
import 'package:ceylife_digital/features/data/models/responses/initiate_customer_service_response.dart';
import 'package:ceylife_digital/features/data/models/responses/key_exchange_response.dart';
import 'package:ceylife_digital/features/data/models/responses/password_reset_otp_response.dart';
import 'package:ceylife_digital/features/data/models/responses/password_reset_response.dart';
import 'package:ceylife_digital/features/data/models/responses/payment_details_response.dart';
import 'package:ceylife_digital/features/data/models/responses/payment_status_check_response.dart';
import 'package:ceylife_digital/features/data/models/responses/policy_details_response.dart';
import 'package:ceylife_digital/features/data/models/responses/policy_info_response.dart';
import 'package:ceylife_digital/features/data/models/responses/profile_data_update_response.dart';
import 'package:ceylife_digital/features/data/models/responses/register_lead_generator_response.dart';
import 'package:ceylife_digital/features/data/models/responses/resend_otp_response.dart';
import 'package:ceylife_digital/features/data/models/responses/splash_response.dart';
import 'package:ceylife_digital/features/data/models/responses/submit_bank_details_response.dart';
import 'package:ceylife_digital/features/data/models/responses/update_password_response.dart';
import 'package:ceylife_digital/features/data/models/responses/verify_new_lead_generator_response.dart';
import 'package:ceylife_digital/utils/app_constants.dart';
import 'package:flutter/material.dart';

abstract class RemoteDataSource {
  Future<GetPromotionsResponse> getPromotions(
      GetPromotionsRequest getPromotionsRequest);

  Future<GetBranchResponse> getBranches(GetBranchesRequest getBranchesRequest);

  Future<GetFaqResponse> getFAQ();

  Future<GetNewsResponse> getNews();

  Future<GetProductsResponse> getProductCategories();

  Future<GetProductDetailResponse> getProductDetail(
      GetProductDetailRequest getProductDetailRequest);

  Future<GetLoginResponse> getLogin(GetLoginRequest getLoginRequest);

  Future<SplashResponse> splashRequest(SplashRequest splashRequest);

  Future<GetPolicyResponse> getPolicy(GetPolicyRequest getPolicyRequest);

  Future<CreateUserResponse> createUser(CreateUserRequest createUserRequest);

  Future<GetOtpResponse> getOtp(GetOtpRequest getOtpRequest);

  Future<UpdatePasswordResponse> updatePassword(
      UpdatePasswordRequest updatePasswordRequest);

  Future<UserProfileResponse> getUserProfile(
      UserProfileRequest userProfileRequest);

  Future<List<ContactUsData>> getContactUs();

  Future<ResendOtpResponse> resendOtp(ResendOtpRequest resendOtpRequest);

  Future<ProfileDataUpdateResponse> updateProfileData(
      ProfileDataUpdateRequest profileDataUpdateRequest);

  Future<CustomerInitiatedCategoryResponse>
      getCustomerInitiatedCategoryServices(
          CustomerInitiatedCategoryRequest customerInitiatedCategoryRequest);

  Future<InitiateCustomerServiceResponse> initiateCustomerService(
      InitiateCustomerServiceRequest initiateCustomerServiceRequest);

  Future<CustomerInitiatedServiceResponse> getCustomerInitiatedService(
      CustomerInitiatedServiceRequest customerInitiatedServiceRequest);

  Future<PaymentDetailsResponse> getPaymentDetails(
      PaymentDetailsRequest customerInitiatedServiceRequest);

  Future<PolicyDetailsResponse> getPolicyDetails(
      PolicyDetailsRequest policyDetailsRequest);

  Future<GeneratePaymentLinkResponse> getPaymentLink(
      GeneratePaymentLinkRequest generatePaymentLinkRequest);

  Future<PaymentStatusCheckResponse> checkPaymentStatus(
      PaymentStatusCheckRequest paymentStatusCheckRequest);

  Future<PolicyInfoResponse> getPolicyBenefitsData(
      PolicyInfoRequest policyInfoRequest);

  Future<PolicyInfoResponse> getPolicyLoanData(
      PolicyInfoRequest policyInfoRequest);

  Future<GetNotificationResponse> getNotifications(
      GetNotificationRequest getNotificationRequest);

  Future<GetNotificationResponse> changeNotificationStatus(
      NotificationStatusChangeRequest notificationStatusChangeRequest);

  Future<AccumulationRateResponse> getAccumulationRates();

  Future<AccumulationRateHistoryResponse> getAccumulationRateHistory(
      AccumulationRateHistoryRequest accumulationRateHistoryRequest);

  Future<HealthTipsResponse> getHealthTips(HealthTipsRequest healthTipsRequest);

  Future<SubmitBankDetailsResponse> submitBankDetails(
      SubmitBankDetailsRequest submitBankDetailsRequest);

  Future<BanksResponse> getBanks();

  Future<GetBankBranchesResponse> getBankBranches(
      GetBankBranchesRequest getBankBranchesRequest);

  Future<VerifyNewLeadGeneratoResponse> verifyNewLeadGenerator(
      VerifyNewLeadGeneratorRequest verifyNewLeadGeneratorRequest);

  Future<RegisterLeadGeneratorResponse> registerLeadGenerator(
      RegisterLeadGeneratorRequest registerLeadGeneratorRequest);

  Future<KeyExchangeResponse> keyExchange(
      KeyExchangeRequest keyExchangeRequest);

  Future<BiometricRegistrationResponse> biometricRegistration(
      BiometricRegistrationRequest biometricRegistrationRequest);

  Future<PasswordResetOtpResponse> passwordResetOtpRequest(
      PasswordResetOtpRequest passwordResetOtpRequest);

  Future<PasswordResetResponse> passwordReset(
      PasswordResetRequest passwordResetRequest);

  Future<GetCsrMainCategoryResponse> getCSRMainCategories();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final APIHelper apiHelper;

  RemoteDataSourceImpl({@required this.apiHelper});

  @override
  Future<GetPromotionsResponse> getPromotions(
      GetPromotionsRequest getPromotionsRequest) async {
    try {
      final response = await apiHelper.get(
        "consumer/pre-login/promotions/${getPromotionsRequest.promotionType}",
      );
      return GetPromotionsResponse.fromJson(response);
    } on Exception catch (ex) {
      throw ex;
    }
  }

  @override
  Future<GetBranchResponse> getBranches(
      GetBranchesRequest getBranchesRequest) async {
    try {
      final response = await apiHelper.get(
        "consumer/pre-login/service-provider/${getBranchesRequest.categoryCode}",
      );
      return GetBranchResponse.fromJson(response);
    } on Exception catch (ex) {
      throw ex;
    }
  }

  @override
  Future<GetFaqResponse> getFAQ() async {
    try {
      final response = await apiHelper.get(
        "consumer/pre-login/faqs",
      );
      return GetFaqResponse.fromJson(response);
    } on Exception catch (ex) {
      throw ex;
    }
  }

  @override
  Future<GetNewsResponse> getNews() async {
    try {
      final response = await apiHelper.get(
        "consumer/pre-login/news",
      );
      return GetNewsResponse.fromJson(response);
    } on Exception catch (ex) {
      throw ex;
    }
  }

  @override
  Future<GetProductsResponse> getProductCategories() async {
    try {
      final response = await apiHelper.get(
        "consumer/pre-login/product-category",
      );
      return GetProductsResponse.fromJson(response);
    } on Exception catch (ex) {
      throw ex;
    }
  }

  @override
  Future<GetProductDetailResponse> getProductDetail(
      GetProductDetailRequest getProductDetailRequest) async {
    try {
      final response = await apiHelper.get(
        "consumer/pre-login/products/${getProductDetailRequest.categoryCode}",
      );
      return GetProductDetailResponse.fromJson(response);
    } on Exception catch (ex) {
      throw ex;
    }
  }

  @override
  Future<GetLoginResponse> getLogin(GetLoginRequest getLoginRequest) async {
    try {
      final response = await apiHelper.post("consumer/auth/sign-in",
          body: getLoginRequest.toJson());
      return GetLoginResponse.fromJson(response);
    } on Exception catch (ex) {
      throw ex;
    }
  }

  @override
  Future<SplashResponse> splashRequest(SplashRequest splashRequest) async {
    try {
      final response =
          await apiHelper.post("consumer/splash", body: splashRequest.toJson());
      return SplashResponse.fromJson(response);
    } on Exception catch (ex) {
      throw ex;
    }
  }

  @override
  Future<GetPolicyResponse> getPolicy(GetPolicyRequest getPolicyRequest) async {
    try {
      final response = await apiHelper.post(
          "consumer/user-registration/policy-verification",
          body: getPolicyRequest.toJson());
      return GetPolicyResponse.fromJson(response);
    } on Exception catch (ex) {
      throw ex;
    }
  }

  @override
  Future<List<ContactUsData>> getContactUs() async {
    try {
      final response =
          await apiHelper.get("consumer/pre-login/contact-details");
      return ContactUsResponse.fromJson(response).data;
    } on Exception catch (ex) {
      throw ex;
    }
  }

  @override
  Future<GetOtpResponse> getOtp(GetOtpRequest getOtpRequest) async {
    try {
      final response = await apiHelper.post(
          "consumer/user-registration/validate-otp",
          body: getOtpRequest.toJson());
      return GetOtpResponse.fromJson(response);
    } on Exception catch (ex) {
      throw ex;
    }
  }

  @override
  Future<CreateUserResponse> createUser(
      CreateUserRequest createUserRequest) async {
    try {
      final response = await apiHelper.post(
          "consumer/user-registration/create-user",
          body: createUserRequest.toJson());
      return CreateUserResponse.fromJson(response);
    } on Exception catch (ex) {
      throw ex;
    }
  }

  @override
  Future<UserProfileResponse> getUserProfile(
      UserProfileRequest userProfileRequest) async {
    try {
      final response = await apiHelper.get(
        "consumer/profile?mobileUserId=${userProfileRequest.mobileUserId}",
      );
      return UserProfileResponse.fromJson(response);
    } on Exception catch (ex) {
      throw ex;
    }
  }

  @override
  Future<UpdatePasswordResponse> updatePassword(
      UpdatePasswordRequest updatePasswordRequest) async {
    try {
      final response = await apiHelper.post(
          "consumer/user-registration/forgot-password/update-password",
          body: updatePasswordRequest.toJson());
      return UpdatePasswordResponse.fromJson(response);
    } on Exception catch (ex) {
      throw ex;
    }
  }

  @override
  Future<ResendOtpResponse> resendOtp(ResendOtpRequest resendOtpRequest) async {
    try {
      final response = await apiHelper.post(
          "consumer/user-registration/resend-otp",
          body: resendOtpRequest.toJson());

      return ResendOtpResponse.fromJson(response);
    } on Exception catch (ex) {
      throw ex;
    }
  }

  @override
  Future<ProfileDataUpdateResponse> updateProfileData(
      ProfileDataUpdateRequest profileDataUpdateRequest) async {
    try {
      final response = await apiHelper.post("consumer/profile/update",
          body: profileDataUpdateRequest.toJson());

      return ProfileDataUpdateResponse.fromJson(response);
    } on Exception catch (ex) {
      throw ex;
    }
  }

  @override
  Future<CustomerInitiatedCategoryResponse>
      getCustomerInitiatedCategoryServices(
          CustomerInitiatedCategoryRequest
              customerInitiatedCategoryRequest) async {
    try {
      final response = await apiHelper.get(
        "consumer/customer-initiated-service/category?mainCategoryId=${customerInitiatedCategoryRequest.mainCategoryId}",
      );
      return CustomerInitiatedCategoryResponse.fromJson(response);
    } on Exception catch (ex) {
      throw ex;
    }
  }

  @override
  Future<InitiateCustomerServiceResponse> initiateCustomerService(
      InitiateCustomerServiceRequest initiateCustomerServiceRequest) async {
    AppConstants.LOADING_PROGRESS = 0;

    try {
      final response = await apiHelper.post(
        "consumer/customer-initiated-service",
        body: initiateCustomerServiceRequest.toJson(),
      );

      return InitiateCustomerServiceResponse.fromJson(response);
    } on Exception catch (ex) {
      throw ex;
    }
  }

  @override
  Future<CustomerInitiatedServiceResponse> getCustomerInitiatedService(
      CustomerInitiatedServiceRequest customerInitiatedServiceRequest) async {
    try {
      final response = await apiHelper.get(
        "consumer/customer-initiated-service?mobileUserId=${customerInitiatedServiceRequest.mobileUserId}",
      );
      return CustomerInitiatedServiceResponse.fromJson(response);
    } on Exception catch (ex) {
      throw ex;
    }
  }

  @override
  Future<PaymentDetailsResponse> getPaymentDetails(
      PaymentDetailsRequest customerInitiatedServiceRequest) async {
    try {
      final response = await apiHelper.get(
        "consumer/payments?policyNo=${customerInitiatedServiceRequest.policyNo}&pageNo=${customerInitiatedServiceRequest.pageNo != null ? customerInitiatedServiceRequest.pageNo : 0}&pageSize=${AppConstants.PAYMENT_HISTORY_PAGE_SIZE}&clientNo=${customerInitiatedServiceRequest.clientNo}",
      );
      return PaymentDetailsResponse.fromJson(response);
    } on Exception catch (ex) {
      throw ex;
    }
  }

  @override
  Future<PolicyDetailsResponse> getPolicyDetails(
      PolicyDetailsRequest policyDetailsRequest) async {
    try {
      final response = await apiHelper.get(
        (policyDetailsRequest.policyNo != null &&
                policyDetailsRequest.policyNo.isNotEmpty)
            ? "consumer/policies?policyNo=${policyDetailsRequest.policyNo}&mobileUserId=${policyDetailsRequest.clientNo}"
            : "consumer/policies?mobileUserId=${policyDetailsRequest.clientNo}",
      );
      return PolicyDetailsResponse.fromJson(response);
    } on Exception catch (ex) {
      throw ex;
    }
  }

  @override
  Future<GeneratePaymentLinkResponse> getPaymentLink(
      GeneratePaymentLinkRequest generatePaymentLinkRequest) async {
    try {
      final response = await apiHelper.post("consumer/payments/generate-url",
          body: generatePaymentLinkRequest.toJson());

      return GeneratePaymentLinkResponse.fromJson(response);
    } on Exception catch (ex) {
      throw ex;
    }
  }

  @override
  Future<PaymentStatusCheckResponse> checkPaymentStatus(
      PaymentStatusCheckRequest paymentStatusCheckRequest) async {
    try {
      final response = await apiHelper.post("consumer/payments/check-status",
          body: paymentStatusCheckRequest.toJson());

      return PaymentStatusCheckResponse.fromJson(response);
    } on Exception catch (ex) {
      throw ex;
    }
  }

  @override
  Future<PolicyInfoResponse> getPolicyBenefitsData(
      PolicyInfoRequest policyInfoRequest) async {
    try {
      final response = await apiHelper.get(
        "consumer/policies/benefit?policyNo=${policyInfoRequest.policyNo}",
      );
      return PolicyInfoResponse.fromJson(response);
    } on Exception catch (ex) {
      throw ex;
    }
  }

  @override
  Future<PolicyInfoResponse> getPolicyLoanData(
      PolicyInfoRequest policyInfoRequest) async {
    try {
      final response = await apiHelper.get(
        "consumer/policies/loan?policyNo=${policyInfoRequest.policyNo}",
      );
      return PolicyInfoResponse.fromJson(response);
    } on Exception catch (ex) {
      throw ex;
    }
  }

  @override
  Future<GetNotificationResponse> getNotifications(
      GetNotificationRequest getNotificationRequest) async {
    try {
      final response = await apiHelper.get(
        "consumer/notifications?mobileUserId=${getNotificationRequest.mobileUserId}",
      );
      return GetNotificationResponse.fromJson(response);
    } on Exception catch (ex) {
      throw ex;
    }
  }

  @override
  Future<GetNotificationResponse> changeNotificationStatus(
      NotificationStatusChangeRequest notificationStatusChangeRequest) async {
    try {
      final response = await apiHelper.post("consumer/notifications/update",
          body: notificationStatusChangeRequest.toJson());

      return GetNotificationResponse.fromJson(response);
    } on Exception catch (ex) {
      throw ex;
    }
  }

  @override
  Future<KeyExchangeResponse> keyExchange(
      KeyExchangeRequest keyExchangeRequest) async {
    try {
      final response = await apiHelper.post("sec/key-exchange",
          body: keyExchangeRequest.toJson(), isKeyExchangeRequest: true);

      return KeyExchangeResponse.fromJson(response);
    } on Exception catch (ex) {
      throw ex;
    }
  }

  @override
  Future<HealthTipsResponse> getHealthTips(
      HealthTipsRequest healthTipsRequest) async {
    try {
      final response = await apiHelper.get(
        (healthTipsRequest.mobileUserId == null)
            ? "consumer/pre-login/health-tips"
            : 'consumer/health-tips?mobileUserId=${healthTipsRequest.mobileUserId}',
      );
      return HealthTipsResponse.fromJson(response);
    } on Exception catch (ex) {
      throw ex;
    }
  }

  @override
  Future<AccumulationRateResponse> getAccumulationRates() async {
    try {
      final response = await apiHelper.get(
        "consumer/pre-login/rates",
      );
      return AccumulationRateResponse.fromJson(response);
    } on Exception catch (ex) {
      throw ex;
    }
  }

  @override
  Future<AccumulationRateHistoryResponse> getAccumulationRateHistory(
      AccumulationRateHistoryRequest accumulationRateHistoryRequest) async {
    try {
      final response = await apiHelper.get(
        "consumer/pre-login/rates/history?productDetailId=${accumulationRateHistoryRequest.productDetailId}",
      );
      return AccumulationRateHistoryResponse.fromJson(response);
    } on Exception catch (ex) {
      throw ex;
    }
  }

  @override
  Future<SubmitBankDetailsResponse> submitBankDetails(
      SubmitBankDetailsRequest submitBankDetailsRequest) async {
    try {
      final response = await apiHelper.post("consumer/lead/bank-details",
          body: submitBankDetailsRequest.toJson());
      return SubmitBankDetailsResponse.fromJson(response);
    } on Exception catch (ex) {
      throw ex;
    }
  }

  @override
  Future<BanksResponse> getBanks() async {
    try {
      final response = await apiHelper.get("consumer/pre-login/banks");
      return BanksResponse.fromJson(response);
    } on Exception catch (ex) {
      throw ex;
    }
  }

  @override
  Future<GetBankBranchesResponse> getBankBranches(
      GetBankBranchesRequest getBankBranchesRequest) async {
    try {
      final response = await apiHelper.get(
        "consumer/pre-login/banks/branch?bankCode=${getBankBranchesRequest.bankCode}",
      );
      return GetBankBranchesResponse.fromJson(response);
    } on Exception catch (ex) {
      throw ex;
    }
  }

  @override
  Future<VerifyNewLeadGeneratoResponse> verifyNewLeadGenerator(
      VerifyNewLeadGeneratorRequest verifyNewLeadGeneratorRequest) async {
    try {
      final response = await apiHelper.post(
          "consumer/lead/verify-new-lead-generator",
          body: verifyNewLeadGeneratorRequest.toJson());
      return VerifyNewLeadGeneratoResponse.fromJson(response);
    } on Exception catch (ex) {
      throw ex;
    }
  }

  @override
  Future<RegisterLeadGeneratorResponse> registerLeadGenerator(
      RegisterLeadGeneratorRequest registerLeadGeneratorRequest) async {
    try {
      final response = await apiHelper.post("consumer/lead/register",
          body: registerLeadGeneratorRequest.toJson());
      return RegisterLeadGeneratorResponse.fromJson(response);
    } on Exception catch (ex) {
      throw ex;
    }
  }

  @override
  Future<BiometricRegistrationResponse> biometricRegistration(
      BiometricRegistrationRequest biometricRegistrationRequest) async {
    try {
      final response = await apiHelper.post(
          "consumer/user-registration/biometric-authentication",
          body: biometricRegistrationRequest.toJson());
      return BiometricRegistrationResponse.fromJson(response);
    } on Exception catch (ex) {
      throw ex;
    }
  }

  @override
  Future<PasswordResetOtpResponse> passwordResetOtpRequest(
      PasswordResetOtpRequest passwordResetOtpRequest) async {
    try {
      final response = await apiHelper.post(
          "consumer/user-registration/request-password-reset",
          body: passwordResetOtpRequest.toJson());
      return PasswordResetOtpResponse.fromJson(response);
    } on Exception catch (ex) {
      throw ex;
    }
  }

  @override
  Future<PasswordResetResponse> passwordReset(
      PasswordResetRequest passwordResetRequest) async {
    try {
      final response = await apiHelper.post(
          "consumer/user-registration/reset-password/update-password",
          body: passwordResetRequest.toJson());
      return PasswordResetResponse.fromJson(response);
    } on Exception catch (ex) {
      throw ex;
    }
  }

  @override
  Future<GetCsrMainCategoryResponse> getCSRMainCategories() async {
    try {
      final response = await apiHelper.get(
        "consumer/customer-initiated-service/main-category",
      );
      return GetCsrMainCategoryResponse.fromJson(response);
    } on Exception catch (ex) {
      throw ex;
    }
  }
}
