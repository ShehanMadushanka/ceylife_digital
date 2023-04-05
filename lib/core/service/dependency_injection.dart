import 'dart:io';

import 'package:ceylife_digital/core/network/api_helper.dart';
import 'package:ceylife_digital/core/network/network_info.dart';
import 'package:ceylife_digital/core/service/push_notification_manager.dart';
import 'package:ceylife_digital/features/data/datasources/local_data_source.dart';
import 'package:ceylife_digital/features/data/datasources/remote_data_source.dart';
import 'package:ceylife_digital/features/data/datasources/shared_preference.dart';
import 'package:ceylife_digital/features/data/repositories/repository_impl.dart';
import 'package:ceylife_digital/features/domain/repositories/repository.dart';
import 'package:ceylife_digital/features/domain/usecases/use_case_get_bank_branches.dart';
import 'package:ceylife_digital/features/domain/usecases/use_case_get_banks.dart';
import 'package:ceylife_digital/features/domain/usecases/use_case_get_contact_us.dart';
import 'package:ceylife_digital/features/domain/usecases/usecase_biometric_registration.dart';
import 'package:ceylife_digital/features/domain/usecases/usecase_change_notification_status.dart';
import 'package:ceylife_digital/features/domain/usecases/usecase_check_payment_status.dart';
import 'package:ceylife_digital/features/domain/usecases/usecase_create_user.dart';
import 'package:ceylife_digital/features/domain/usecases/usecase_generate_payment_link.dart';
import 'package:ceylife_digital/features/domain/usecases/usecase_get_accumulation_rate_history.dart';
import 'package:ceylife_digital/features/domain/usecases/usecase_get_accumulation_rates.dart';
import 'package:ceylife_digital/features/domain/usecases/usecase_get_branches.dart';
import 'package:ceylife_digital/features/domain/usecases/usecase_get_csr_main_categories.dart';
import 'package:ceylife_digital/features/domain/usecases/usecase_get_customer_initiated_categories.dart';
import 'package:ceylife_digital/features/domain/usecases/usecase_get_customer_initiated_service.dart';
import 'package:ceylife_digital/features/domain/usecases/usecase_get_faq.dart';
import 'package:ceylife_digital/features/domain/usecases/usecase_get_healthtips.dart';
import 'package:ceylife_digital/features/domain/usecases/usecase_get_login.dart';
import 'package:ceylife_digital/features/domain/usecases/usecase_get_news.dart';
import 'package:ceylife_digital/features/domain/usecases/usecase_get_notifications.dart';
import 'package:ceylife_digital/features/domain/usecases/usecase_get_otp.dart';
import 'package:ceylife_digital/features/domain/usecases/usecase_get_payment_details.dart';
import 'package:ceylife_digital/features/domain/usecases/usecase_get_policy.dart';
import 'package:ceylife_digital/features/domain/usecases/usecase_get_policy_benefits.dart';
import 'package:ceylife_digital/features/domain/usecases/usecase_get_policy_details.dart';
import 'package:ceylife_digital/features/domain/usecases/usecase_get_policy_loans.dart';
import 'package:ceylife_digital/features/domain/usecases/usecase_get_product_categories.dart';
import 'package:ceylife_digital/features/domain/usecases/usecase_get_product_detail.dart';
import 'package:ceylife_digital/features/domain/usecases/usecase_get_promotions.dart';
import 'package:ceylife_digital/features/domain/usecases/usecase_get_user_profile.dart';
import 'package:ceylife_digital/features/domain/usecases/usecase_initiate_customer_service.dart';
import 'package:ceylife_digital/features/domain/usecases/usecase_key_exchange.dart';
import 'package:ceylife_digital/features/domain/usecases/usecase_password_reset.dart';
import 'package:ceylife_digital/features/domain/usecases/usecase_password_reset_otp_request.dart';
import 'package:ceylife_digital/features/domain/usecases/usecase_register_lead_generator.dart';
import 'package:ceylife_digital/features/domain/usecases/usecase_resend_otp.dart';
import 'package:ceylife_digital/features/domain/usecases/usecase_splash.dart';
import 'package:ceylife_digital/features/domain/usecases/usecase_submit_bank_details.dart';
import 'package:ceylife_digital/features/domain/usecases/usecase_update_password.dart';
import 'package:ceylife_digital/features/domain/usecases/usecase_update_profile.dart';
import 'package:ceylife_digital/features/domain/usecases/usecase_verify_new_lead_generator.dart';
import 'package:ceylife_digital/features/presentation/bloc/branches_bloc/branches_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/buy_online/buy_online_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/contact_us/contact_us_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/customer_service_request/customer_service_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/directpay_bloc/directpay_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/faq/faq_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/health_tips/health_tips_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/home/home_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/language_selection/language_selection_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/lead_generation/lead_generation_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/login/login_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/news/news_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/notification/notification_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/otp/otp_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/password_reset/password_reset_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/pay_premium/pay_premium_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/payment_history/payment_history_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/policy/policy_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/policy_details/policy_details_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/products_services/product_services_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/profile/profile_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/promotions_bloc/promotions_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/rates/rates_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/registration/registration_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/settings/settings_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/splash/splash_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/user_details/user_details_bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cloud_services.dart';

final injection = GetIt.instance;

Future<void> setupLocator() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  final secureStorage = FlutterSecureStorage();

  if (Platform.isIOS && !sharedPreferences.containsKey('secure_setup')) {
    //TODO: Uncomment in Phase 3 release
    // await secureStorage.deleteAll();
    sharedPreferences.setBool('secure_setup', false);
  }

  injection.registerLazySingleton(() => sharedPreferences);
  injection.registerLazySingleton(() => secureStorage);
  injection.registerSingleton(AppSharedData(injection()));

  injection.registerSingleton(PushNotificationsManager(injection()));
  injection.registerSingleton(CloudServices(injection()));
  injection.registerSingleton(Dio());
  injection.registerLazySingleton<APIHelper>(() => APIHelper(dio: injection()));
  injection
      .registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(injection()));
  injection.registerLazySingleton(() => Connectivity());

  // Repository
  injection.registerLazySingleton<Repository>(
    () => RepositoryImpl(
        remoteDataSource: injection(),
        localDataSource: injection(),
        networkInfo: injection()),
  );

  // Data sources
  injection.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(apiHelper: injection()),
  );
  injection.registerLazySingleton<LocalDataSource>(
    () => LocalDataSourceImpl(sharedPreferences: injection()),
  );

  //UseCases
  injection.registerLazySingleton(
      () => UseCaseGetPromotions(repository: injection()));
  injection
      .registerLazySingleton(() => UseCaseGetBranches(repository: injection()));
  injection.registerLazySingleton(() => UseCaseGetFAQ(repository: injection()));
  injection
      .registerLazySingleton(() => UseCaseGetNews(repository: injection()));
  injection.registerLazySingleton(
      () => UseCaseGetProductCategories(repository: injection()));
  injection.registerLazySingleton(
      () => UseCaseGetProductDetail(repository: injection()));
  injection
      .registerLazySingleton(() => UseCaseGetLogin(repository: injection()));
  injection.registerLazySingleton(() => UseCaseSplash(repository: injection()));
  injection
      .registerLazySingleton(() => UseCaseGetPolicy(repository: injection()));
  injection.registerLazySingleton(
      () => UseCaseGetContactUs(repository: injection()));
  injection.registerLazySingleton(() => UseCaseGetOtp(repository: injection()));
  injection
      .registerLazySingleton(() => UseCaseCreateUser(repository: injection()));
  injection.registerLazySingleton(
      () => UseCaseGetUserProfile(repository: injection()));
  injection.registerLazySingleton(
      () => UseCaseUpdatePassword(repository: injection()));
  injection
      .registerLazySingleton(() => UseCaseResendOtp(repository: injection()));
  injection.registerLazySingleton(
      () => UseCaseUpdateProfile(repository: injection()));
  injection.registerLazySingleton(
      () => UseCaseGetCustomerInitiatedCategories(repository: injection()));
  injection.registerLazySingleton(
      () => UseCaseInitiateCustomerService(repository: injection()));
  injection.registerLazySingleton(
      () => UseCaseGetCustomerInitiatedService(repository: injection()));
  injection.registerLazySingleton(
      () => UseCasePaymentDetails(repository: injection()));
  injection.registerLazySingleton(
      () => UseCasePolicyDetails(repository: injection()));
  injection.registerLazySingleton(
      () => UseCaseGeneratePaymentLink(repository: injection()));
  injection.registerLazySingleton(
      () => UseCaseCheckPaymentStatus(repository: injection()));
  injection.registerLazySingleton(
      () => UseCaseGetPolicyBenefits(repository: injection()));
  injection.registerLazySingleton(
      () => UseCaseGetPolicyLoans(repository: injection()));
  injection.registerLazySingleton(
      () => UseCaseGetNotifications(repository: injection()));
  injection.registerLazySingleton(
      () => UseCaseChangeNotificationStatus(repository: injection()));
  injection.registerLazySingleton(
      () => UseCaseGetHealthTips(repository: injection()));
  injection.registerLazySingleton(
      () => UseCaseAccumulationRate(repository: injection()));
  injection.registerLazySingleton(
      () => UseCaseAccumulationRateHistory(repository: injection()));
  injection.registerLazySingleton(
      () => UseCaseSubmitBankDetails(repository: injection()));
  injection
      .registerLazySingleton(() => UseCaseGetBanks(repository: injection()));
  injection.registerLazySingleton(
      () => UseCaseGetBankBranches(repository: injection()));
  injection.registerLazySingleton(
      () => UseCaseNewLeadGenerator(repository: injection()));
  injection.registerLazySingleton(
      () => UseCaseRegisterLeadGenerator(repository: injection()));
  injection
      .registerLazySingleton(() => UseCaseKeyExchange(repository: injection()));
  injection.registerLazySingleton(
      () => UseCaseBiometricRegistration(repository: injection()));
  injection.registerLazySingleton(
      () => UseCasePasswordResetOtpRequest(repository: injection()));
  injection.registerLazySingleton(
      () => UseCasePasswordReset(repository: injection()));
  injection.registerLazySingleton(
      () => UseCaseGetCSRMainCategories(repository: injection()));

  //Blocs
  injection.registerFactory(() => SplashBloc(
      useCaseSplash: injection(),
      appSharedData: injection(),
      cloudServices: injection(),
      useCaseKeyExchange: injection()));
  injection.registerFactory(() => HealthTipsBloc(
      useCaseGetHealthTips: injection(), appSharedData: injection()));
  injection.registerFactory(() => RegistrationBloc(
      useCaseCreateUser: injection(), appSharedData: injection()));
  injection
      .registerFactory(() => PromotionsBloc(useCaseGetPromotions: injection()));
  injection
      .registerFactory(() => BranchesBloc(useCaseGetBranches: injection()));
  injection.registerFactory(() => FAQBloc(useCaseGetFAQ: injection()));
  injection.registerFactory(() => NewsBloc(useCaseGetNews: injection()));
  injection.registerFactory(() => LoginBloc(
        useCaseGetLogin: injection(),
        appSharedData: injection(),
      ));
  injection.registerFactory(() => ProductsBloc(
      useCaseGetProductCategories: injection(),
      useCaseGetProductDetail: injection()));
  injection.registerFactory(() =>
      PolicyBloc(useCaseGetPolicy: injection(), appSharedData: injection()));
  injection
      .registerFactory(() => ContactUsBloc(usecaseGetContactUs: injection()));
  injection.registerFactory(() => ForgotPasswordBloc(
      useCaseUpdatePassword: injection(), appSharedData: injection()));
  injection.registerFactory(() => OtpBloc(
      useCaseGetOtp: injection(),
      useCaseResendOtp: injection(),
      appSharedData: injection()));
  injection.registerFactory(() => BuyOnlineBloc(appSharedData: injection()));
  injection.registerFactory(() => UserDetailsBloc(
      useCaseGetBranches: injection(), useCaseNewLeadGenerator: injection()));
  injection.registerFactory(() => HomeBloc(
      useCaseGetUserProfile: injection(),
      appSharedData: injection(),
      useCaseGetPolicy: injection(),
      useCasePasswordResetOtpRequest: injection()));
  injection.registerFactory(() => ProfileBloc(
      updateProfile: injection(),
      appSharedData: injection(),
      getCustomerInitiatedCategories: injection(),
      initiateCustomerService: injection()));
  injection.registerFactory(() => PaymentHistoryBloc(
      useCaseGetPolicy: injection(),
      useCasePaymentDetails: injection(),
      appSharedData: injection()));
  injection.registerFactory(() => CustomerServiceBloc(
      initiateCustomerService: injection(),
      useCaseGetPolicy: injection(),
      getCustomerInitiatedCategories: injection(),
      appSharedData: injection(),
      useCaseGetCustomerInitiatedService: injection(),
      useCaseGetCSRMainCategories: injection()));
  injection.registerFactory(() => PayPremiumBloc(
      appSharedData: injection(),
      checkPaymentStatus: injection(),
      generatePaymentLink: injection()));
  injection.registerFactory(
      () => DirectPayBloc(useCaseCheckPaymentStatus: injection()));
  injection.registerFactory(() => PolicyDetailsBloc(
      useCasePaymentDetails: injection(),
      useCaseGetPolicyBenefits: injection(),
      useCaseGetPolicyLoans: injection()));
  injection.registerFactory(() => NotificationBloc(
      appSharedData: injection(),
      useCaseChangeNotificationStatus: injection(),
      useCaseGetNotifications: injection()));
  injection.registerFactory(() => RatesBloc(
      useCaseAccumulationRate: injection(),
      useCaseAccumulationRateHistory: injection()));
  injection.registerFactory(() => LeadGenerationBloc(
      useCaseSubmitBankDetails: injection(),
      appSharedData: injection(),
      useCaseGetBanks: injection(),
      useCaseGetBankBranches: injection(),
      useCaseRegisterLeadGenerator: injection()));
  injection.registerFactory(() => SettingsBloc(
      appSharedData: injection(),
      biometricRegistration: injection(),
      useCaseGetLogin: injection()));
  injection
      .registerFactory(() => LanguageSelectionBloc(appSharedData: injection()));
  injection.registerFactory(() => PasswordResetBloc(
      appSharedData: injection(), useCasePasswordReset: injection()));
}
