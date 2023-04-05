import 'package:ceylife_digital/features/presentation/common/transitions/fade_route.dart';
import 'package:ceylife_digital/features/presentation/views/branch_locator/branch_view.dart';
import 'package:ceylife_digital/features/presentation/views/buy_online/buy_online_view.dart';
import 'package:ceylife_digital/features/presentation/views/common/common_otp_verification_view.dart';
import 'package:ceylife_digital/features/presentation/views/contact_us/contact_us_view.dart';
import 'package:ceylife_digital/features/presentation/views/customer_service_request/csr_root_view.dart';
import 'package:ceylife_digital/features/presentation/views/customer_service_request/csr_view_previous_view.dart';
import 'package:ceylife_digital/features/presentation/views/direct_pay/direct_pay_status_view.dart';
import 'package:ceylife_digital/features/presentation/views/direct_pay/direct_pay_view.dart';
import 'package:ceylife_digital/features/presentation/views/faq/faq_view.dart';
import 'package:ceylife_digital/features/presentation/views/forget_password/password_creation.dart';
import 'package:ceylife_digital/features/presentation/views/forget_password/user_verification_view.dart';
import 'package:ceylife_digital/features/presentation/views/health_tips/health_tip_view.dart';
import 'package:ceylife_digital/features/presentation/views/health_tips/health_tips_detail_view.dart';
import 'package:ceylife_digital/features/presentation/views/home/home_view.dart';
import 'package:ceylife_digital/features/presentation/views/language_selection/language_selection_view.dart';
import 'package:ceylife_digital/features/presentation/views/language_selection/pre_login_language_view.dart';
import 'package:ceylife_digital/features/presentation/views/lead_generator/bank_account_view.dart';
import 'package:ceylife_digital/features/presentation/views/lead_generator/dashboard_view.dart';
import 'package:ceylife_digital/features/presentation/views/lead_generator/lg_registration_view.dart';
import 'package:ceylife_digital/features/presentation/views/lead_generator/mobile/lg_login_view.dart';
import 'package:ceylife_digital/features/presentation/views/lead_generator/web&new/lead_generator_account_creation_view.dart';
import 'package:ceylife_digital/features/presentation/views/lead_generator/web&new/lead_generator_user_details_view.dart';
import 'package:ceylife_digital/features/presentation/views/login/login_view.dart';
import 'package:ceylife_digital/features/presentation/views/news/news_detail_view.dart';
import 'package:ceylife_digital/features/presentation/views/news/news_view.dart';
import 'package:ceylife_digital/features/presentation/views/notifications/notifications_view.dart';
import 'package:ceylife_digital/features/presentation/views/password_reset/password_reset_view.dart';
import 'package:ceylife_digital/features/presentation/views/pay_premium/pay_premium_view.dart';
import 'package:ceylife_digital/features/presentation/views/payment_history/payment_history_view.dart';
import 'package:ceylife_digital/features/presentation/views/policy_details/beneficiary_details_view.dart';
import 'package:ceylife_digital/features/presentation/views/policy_details/benefits_details_view.dart';
import 'package:ceylife_digital/features/presentation/views/policy_details/loan_details_view.dart';
import 'package:ceylife_digital/features/presentation/views/policy_details/loan_receipts_view.dart';
import 'package:ceylife_digital/features/presentation/views/policy_details/policy_details_view.dart';
import 'package:ceylife_digital/features/presentation/views/policy_details/premium_transaction_history_view.dart';
import 'package:ceylife_digital/features/presentation/views/pre_login_menu/pre_login_view.dart';
import 'package:ceylife_digital/features/presentation/views/products_services/product_detail_view.dart';
import 'package:ceylife_digital/features/presentation/views/products_services/product_detailed_summary_view.dart';
import 'package:ceylife_digital/features/presentation/views/products_services/product_plan_detail_view.dart';
import 'package:ceylife_digital/features/presentation/views/products_services/products_services_view.dart';
import 'package:ceylife_digital/features/presentation/views/promotions/promotion_detail_view.dart';
import 'package:ceylife_digital/features/presentation/views/promotions/promotions_view.dart';
import 'package:ceylife_digital/features/presentation/views/rates/rates_history_view.dart';
import 'package:ceylife_digital/features/presentation/views/rates/rates_view.dart';
import 'package:ceylife_digital/features/presentation/views/settings/biometric_settings_view.dart';
import 'package:ceylife_digital/features/presentation/views/settings/settings_view.dart';
import 'package:ceylife_digital/features/presentation/views/splash_view.dart';
import 'package:ceylife_digital/features/presentation/views/switch_view.dart';
import 'package:ceylife_digital/features/presentation/views/user_profile/user_profile_view.dart';
import 'package:ceylife_digital/features/presentation/views/user_registration/account_creation_view.dart';
import 'package:ceylife_digital/features/presentation/views/user_registration/policy_verification_view.dart';
import 'package:ceylife_digital/features/presentation/views/user_registration/user_details_view.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String SPLASH_VIEW = "SPLASH_VIEW";
  static const String FAQ_VIEW = "FAQ_VIEW";
  static const String NEWS_VIEW = "NEWS_VIEW";
  static const String NEWS_DETAIL_VIEW = "NEWS_DETAIL_VIEW";
  static const String PROMOTIONS_VIEW = "PROMOTIONS_VIEW";
  static const String PROMOTION_DETAIL_VIEW = "PROMOTION_DETAIL_VIEW";
  static const String BRANCH_VIEW = "BRANCH_VIEW";
  static const String CONTACT_US_VIEW = "CONTACT_US_VIEW";
  static const String PRE_LOGIN_MENU_VIEW = "PRE_LOGIN_MENU_VIEW";
  static const String HEALTH_TIPS_VIEW = "HEALTH_TIPS_VIEW";
  static const String HEALTH_TIPS_DETAIL_VIEW = "HEALTH_TIPS_DETAIL_VIEW";
  static const String LOGIN_VIEW = "LOGIN_VIEW";
  static const String PRODUCTS_SERVICES_VIEW = "PRODUCTS_SERVICES_VIEW";
  static const String PAYMENT_HISTORY_VIEW = "PAYMENT_HISTORY_VIEW";
  static const String RATES_VIEW = "RATES_VIEW";
  static const String RATES_HISTORY_VIEW = "RATES_HISTORY_VIEW";
  static const String PASSWORD_RESET_VIEW = "PASSWORD_RESET_VIEW";
  static const String PRODUCTS_SERVICES_DETAIL_VIEW =
      "PRODUCTS_SERVICES_DETAIL_VIEW";
  static const String PRODUCTS_SERVICES_PLAN_DETAIL_VIEW =
      "PRODUCTS_SERVICES_PLAN_DETAIL_VIEW";
  static const String PRODUCTS_SERVICES_PLAN_DETAILED_SUMMARY_VIEW =
      "PRODUCTS_SERVICES_PLAN_DETAILED_SUMMARY_VIEW";
  static const String USER_REGISTRATION_POLICY_VERIFICATION_VIEW =
      "USER_REGISTRATION_POLICY_VERIFICATION_VIEW";
  static const String USER_REGISTRATION_SECONDARY_VERIFICATION_VIEW =
      "USER_REGISTRATION_SECONDARY_VERIFICATION_VIEW";
  static const String USER_REGISTRATION_USER_DETAILS_VIEW =
      "USER_REGISTRATION_USER_DETAILS_VIEW";
  static const String USER_REGISTRATION_ACCOUNT_CREATION_VIEW =
      "USER_REGISTRATION_ACCOUNT_CREATION_VIEW";
  static const String HOME_VIEW = "HOME_VIEW";
  static const String PRE_LANG_VIEW = "PRE_LANG_VIEW";
  static const String LANGUAGE_VIEW = "LANGUAGE_VIEW";
  static const String FORGET_PASSWORD_USER_VERIFICATION_VIEW =
      "FORGET_PASSWORD_USER_VERIFICATION_VIEW";
  static const String FORGOT_PASSWORD_SECONDARY_VERIFICATION_VIEW =
      "FORGOT_PASSWORD_SECONDARY_VERIFICATION_VIEW";
  static const String PASSWORD_CREATION_VIEW = "PASSWORD_CREATION_VIEW";
  static const String USER_PROFILE_VIEW = "USER_PROFILE_VIEW";
  static const String BUY_ONLINE_VIEW = "BUY_ONLINE_VIEW";
  static const String CUSTOMER_SERVICE_REQUEST_ROOT_VIEW =
      "CUSTOMER_SERVICE_REQUEST_ROOT_VIEW";
  static const String CUSTOMER_SERVICE_REQUEST_VIEW_PREVIOUS_VIEW =
      "CUSTOMER_SERVICE_REQUEST_VIEW_PREVIOUS_VIEW";
  static const String PAY_PREMIUM_VIEW = "PAY_PREMIUM_VIEW";
  static const String DIRECT_PAY_VIEW = "DIRECT_PAY_VIEW";
  static const String DIRECT_PAY_STATUS_VIEW = "DIRECT_PAY_STATUS_VIEW";
  static const String POLICY_DETAILS_VIEW = "POLICY_DETAILS_VIEW";
  static const String BENEFITS_DETAILS_VIEW = "BENEFITS_DETAILS_VIEW";
  static const String BENEFICIARY_DETAILS_VIEW = "BENEFICIARY_DETAILS_VIEW";
  static const String LOAN_DETAILS_VIEW = "LOAN_DETAILS_VIEW";
  static const String LOAN_RECEIPTS_VIEW = "LOAN_RECEIPTS_VIEW";
  static const String PREMIUM_TRANSACTION_HISTORY_VIEW =
      "PREMIUM_TRANSACTION_HISTORY_VIEW";
  static const String NOTIFICATIONS_VIEW = "NOTIFICATIONS_VIEW";
  static const String LEAD_GENERATOR_REGISTRATION_VIEW =
      "LEAD_GENERATOR_REGISTRATION_VIEW";
  static const String LEAD_GENERATOR_LOGIN_VIEW = "LEAD_GENERATOR_LOGIN_VIEW";
  static const String BANK_DETAILS_VIEW = "BANK_DETAILS_VIEW";
  static const String COMMON_OTP_VERIFICATION_VIEW =
      "COMMON_OTP_VERIFICATION_VIEW";
  static const String LEAD_GENERATOR_DASHBOARD_VIEW =
      "LEAD_GENERATOR_DASHBOARD_VIEW";
  static const String SWITCH_VIEW = "SWITCH_VIEW";
  static const String LEAD_GENERATOR_USER_DETAILS_VIEW =
      "LEAD_GENERATOR_USER_DETAILS_VIEW";
  static const String LEAD_GENERATOR_ACCOUNT_CREATION_VIEW =
      "LEAD_GENERATOR_ACCOUNT_CREATION_VIEW";
  static const String SETTINGS_VIEW = "SETTINGS_VIEW";
  static const String BIOMETRIC_SETTINGS_VIEW = "BIOMETRIC_SETTINGS_VIEW";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.SPLASH_VIEW:
        return MaterialPageRoute(
          builder: (_) => SplashView(),
          settings: RouteSettings(name: Routes.SPLASH_VIEW),
        );
      case Routes.FAQ_VIEW:
        return MaterialPageRoute(
          builder: (_) => FAQView(),
          settings: RouteSettings(name: Routes.FAQ_VIEW),
        );
      case Routes.PROMOTIONS_VIEW:
        return MaterialPageRoute(
          builder: (_) => PromotionsView(),
          settings: RouteSettings(name: Routes.PROMOTIONS_VIEW),
        );
      case Routes.PROMOTION_DETAIL_VIEW:
        return MaterialPageRoute(
          builder: (_) => PromotionDetailView(settings.arguments),
          settings: RouteSettings(name: Routes.PROMOTIONS_VIEW),
        );
      case Routes.NEWS_VIEW:
        return MaterialPageRoute(
          builder: (_) => NewsView(),
          settings: RouteSettings(name: Routes.NEWS_VIEW),
        );
      case Routes.BRANCH_VIEW:
        return MaterialPageRoute(
          builder: (_) => BranchView(),
          settings: RouteSettings(name: Routes.BRANCH_VIEW),
        );
      case Routes.NEWS_DETAIL_VIEW:
        return MaterialPageRoute(
          builder: (_) => NewsDetailView(settings.arguments),
          settings: RouteSettings(name: Routes.NEWS_DETAIL_VIEW),
        );
      case Routes.CONTACT_US_VIEW:
        return MaterialPageRoute(
          builder: (_) => ContactUsView(),
          settings: RouteSettings(name: Routes.CONTACT_US_VIEW),
        );
      case Routes.PRE_LOGIN_MENU_VIEW:
        return FadeRoute(
          page: PreLoginMenuView(settings.arguments),
          settings: RouteSettings(name: Routes.PRE_LOGIN_MENU_VIEW),
        );
      case Routes.HEALTH_TIPS_VIEW:
        return MaterialPageRoute(
          builder: (_) => HealthTipView(settings.arguments),
          settings: RouteSettings(name: Routes.HEALTH_TIPS_VIEW),
        );
      case Routes.HEALTH_TIPS_DETAIL_VIEW:
        return MaterialPageRoute(
          builder: (_) => HealthTipsDetailView(settings.arguments),
          settings: RouteSettings(name: Routes.HEALTH_TIPS_DETAIL_VIEW),
        );
      case Routes.LOGIN_VIEW:
        return MaterialPageRoute(
          builder: (_) => LoginView(),
          settings: RouteSettings(name: Routes.LOGIN_VIEW),
        );
      case Routes.PRODUCTS_SERVICES_VIEW:
        return MaterialPageRoute(
          builder: (_) => ProductsServicesView(),
          settings: RouteSettings(name: Routes.PRODUCTS_SERVICES_VIEW),
        );
      case Routes.PRODUCTS_SERVICES_DETAIL_VIEW:
        return MaterialPageRoute(
          builder: (_) => ProductDetailView(product: settings.arguments),
          settings: RouteSettings(name: Routes.PRODUCTS_SERVICES_DETAIL_VIEW),
        );
      case Routes.PRODUCTS_SERVICES_PLAN_DETAIL_VIEW:
        return MaterialPageRoute(
          builder: (_) =>
              ProductPlanDetailView(productDetail: settings.arguments),
          settings:
              RouteSettings(name: Routes.PRODUCTS_SERVICES_PLAN_DETAIL_VIEW),
        );
      case Routes.PRODUCTS_SERVICES_PLAN_DETAILED_SUMMARY_VIEW:
        return MaterialPageRoute(
          builder: (_) =>
              ProductDetailedSummaryView(productDetail: settings.arguments),
          settings: RouteSettings(
              name: Routes.PRODUCTS_SERVICES_PLAN_DETAILED_SUMMARY_VIEW),
        );
      case Routes.USER_REGISTRATION_POLICY_VERIFICATION_VIEW:
        return MaterialPageRoute(
          builder: (_) => PolicyVerificationView(),
          settings: RouteSettings(
              name: Routes.USER_REGISTRATION_POLICY_VERIFICATION_VIEW),
        );
      case Routes.USER_REGISTRATION_USER_DETAILS_VIEW:
        return MaterialPageRoute(
          builder: (_) => UserDetailsView(
            registrationData: settings.arguments,
          ),
          settings:
              RouteSettings(name: Routes.USER_REGISTRATION_USER_DETAILS_VIEW),
        );
      case Routes.USER_REGISTRATION_ACCOUNT_CREATION_VIEW:
        return MaterialPageRoute(
          builder: (_) => AccountCreationView(
            registrationData: settings.arguments,
          ),
          settings: RouteSettings(
              name: Routes.USER_REGISTRATION_ACCOUNT_CREATION_VIEW),
        );
      case Routes.HOME_VIEW:
        return MaterialPageRoute(
          builder: (_) => HomeView(
            policies: settings.arguments,
          ),
          settings: RouteSettings(name: Routes.HOME_VIEW),
        );
      case Routes.FORGET_PASSWORD_USER_VERIFICATION_VIEW:
        return MaterialPageRoute(
          builder: (_) => UserVerificationView(),
          settings: RouteSettings(
              name: Routes.FORGET_PASSWORD_USER_VERIFICATION_VIEW),
        );
      case Routes.PASSWORD_CREATION_VIEW:
        return MaterialPageRoute(
          builder: (_) => PasswordCreationView(settings.arguments),
          settings: RouteSettings(name: Routes.PASSWORD_CREATION_VIEW),
        );
      case Routes.BUY_ONLINE_VIEW:
        return MaterialPageRoute(
          builder: (_) => BuyOnlineView(),
          settings: RouteSettings(name: Routes.BUY_ONLINE_VIEW),
        );
      case Routes.USER_PROFILE_VIEW:
        return MaterialPageRoute(
          builder: (_) => UserProfileView(settings.arguments),
          settings: RouteSettings(
            name: Routes.USER_PROFILE_VIEW,
          ),
        );
      case Routes.CUSTOMER_SERVICE_REQUEST_ROOT_VIEW:
        return MaterialPageRoute(
          builder: (_) => CustomerServiceRequestRootView(
            isFromProfileUI:
                settings.arguments == null ? false : settings.arguments,
          ),
          settings: RouteSettings(
            name: Routes.CUSTOMER_SERVICE_REQUEST_ROOT_VIEW,
          ),
        );
      case Routes.CUSTOMER_SERVICE_REQUEST_VIEW_PREVIOUS_VIEW:
        return MaterialPageRoute(
          builder: (_) =>
              CSRViewPreviousRequestsView(request: settings.arguments),
          settings: RouteSettings(
            name: Routes.CUSTOMER_SERVICE_REQUEST_VIEW_PREVIOUS_VIEW,
          ),
        );
      case Routes.PAYMENT_HISTORY_VIEW:
        return MaterialPageRoute(
          builder: (_) => PaymentHistoryView(),
          settings: RouteSettings(
            name: Routes.PAYMENT_HISTORY_VIEW,
          ),
        );
      case Routes.PAY_PREMIUM_VIEW:
        return MaterialPageRoute(
          builder: (_) => PayPremiumView(policy: settings.arguments),
          settings: RouteSettings(
            name: Routes.PAY_PREMIUM_VIEW,
          ),
        );
      case Routes.DIRECT_PAY_VIEW:
        return MaterialPageRoute(
          builder: (_) => DirectPayView(settings.arguments),
          settings: RouteSettings(
            name: Routes.DIRECT_PAY_VIEW,
          ),
        );
      case Routes.DIRECT_PAY_STATUS_VIEW:
        return MaterialPageRoute(
          builder: (_) => DirectPayStatusView(settings.arguments),
          settings: RouteSettings(
            name: Routes.DIRECT_PAY_STATUS_VIEW,
          ),
        );
      case Routes.POLICY_DETAILS_VIEW:
        return MaterialPageRoute(
          builder: (_) => PolicyDetailsView(policy: settings.arguments),
          settings: RouteSettings(
            name: Routes.POLICY_DETAILS_VIEW,
          ),
        );
      case Routes.BENEFITS_DETAILS_VIEW:
        return MaterialPageRoute(
          builder: (_) => BenefitsDetailsView(
            benefits: settings.arguments,
          ),
          settings: RouteSettings(
            name: Routes.BENEFITS_DETAILS_VIEW,
          ),
        );
      case Routes.PREMIUM_TRANSACTION_HISTORY_VIEW:
        return MaterialPageRoute(
          builder: (_) => PremiumTransactionHistoryView(
            transactions: settings.arguments,
          ),
          settings: RouteSettings(
            name: Routes.PREMIUM_TRANSACTION_HISTORY_VIEW,
          ),
        );
      case Routes.LOAN_DETAILS_VIEW:
        return MaterialPageRoute(
          builder: (_) => LoanDetailsView(
            policyLoans: settings.arguments,
          ),
          settings: RouteSettings(
            name: Routes.LOAN_DETAILS_VIEW,
          ),
        );
      case Routes.LOAN_RECEIPTS_VIEW:
        return MaterialPageRoute(
          builder: (_) => LoanReceiptsView(loanReceipts: settings.arguments),
          settings: RouteSettings(
            name: Routes.LOAN_RECEIPTS_VIEW,
          ),
        );
      case Routes.BENEFICIARY_DETAILS_VIEW:
        return MaterialPageRoute(
          builder: (_) => BeneficiaryDetailsView(),
          settings: RouteSettings(
            name: Routes.BENEFICIARY_DETAILS_VIEW,
          ),
        );
      case Routes.NOTIFICATIONS_VIEW:
        return MaterialPageRoute(
          builder: (_) => NotificationsView(),
          settings: RouteSettings(
            name: Routes.NOTIFICATIONS_VIEW,
          ),
        );
      case Routes.RATES_VIEW:
        return MaterialPageRoute(
          builder: (_) => RatesView(),
          settings: RouteSettings(
            name: Routes.RATES_VIEW,
          ),
        );
      case Routes.RATES_HISTORY_VIEW:
        return MaterialPageRoute(
          builder: (_) => RatesHistoryView(
            rateEntity: settings.arguments,
          ),
          settings: RouteSettings(
            name: Routes.RATES_HISTORY_VIEW,
          ),
        );
      case Routes.LEAD_GENERATOR_REGISTRATION_VIEW:
        return MaterialPageRoute(
          builder: (_) => LeadGeneratorRegistrationView(),
          settings: RouteSettings(
            name: Routes.LEAD_GENERATOR_REGISTRATION_VIEW,
          ),
        );
      case Routes.LEAD_GENERATOR_LOGIN_VIEW:
        return MaterialPageRoute(
          builder: (_) => LeadGeneratorLoginView(
            leadData: settings.arguments,
          ),
          settings: RouteSettings(
            name: Routes.LEAD_GENERATOR_LOGIN_VIEW,
          ),
        );
      case Routes.BANK_DETAILS_VIEW:
        return MaterialPageRoute(
          builder: (_) => BankAccountDetailsView(
            leadData: settings.arguments,
          ),
          settings: RouteSettings(
            name: Routes.BANK_DETAILS_VIEW,
          ),
        );
      case Routes.COMMON_OTP_VERIFICATION_VIEW:
        return MaterialPageRoute(
          builder: (_) => CommonOTPVerificationView(
            settings.arguments,
          ),
          settings: RouteSettings(
            name: Routes.COMMON_OTP_VERIFICATION_VIEW,
          ),
        );
      case Routes.LEAD_GENERATOR_DASHBOARD_VIEW:
        return MaterialPageRoute(
          builder: (_) => LeadGeneratorDashboardView(),
          settings: RouteSettings(
            name: Routes.LEAD_GENERATOR_DASHBOARD_VIEW,
          ),
        );
      case Routes.SWITCH_VIEW:
        return MaterialPageRoute(
          builder: (_) => SwitchView(settings.arguments),
          settings: RouteSettings(
            name: Routes.SWITCH_VIEW,
          ),
        );
      case Routes.LEAD_GENERATOR_USER_DETAILS_VIEW:
        return MaterialPageRoute(
          builder: (_) => LeadGeneratorUserDetailsView(
            leadData: settings.arguments,
          ),
          settings:
              RouteSettings(name: Routes.LEAD_GENERATOR_USER_DETAILS_VIEW),
        );
      case Routes.LEAD_GENERATOR_ACCOUNT_CREATION_VIEW:
        return MaterialPageRoute(
          builder: (_) => LeadGeneratorAccountCreationView(
            leadData: settings.arguments,
          ),
          settings:
              RouteSettings(name: Routes.LEAD_GENERATOR_ACCOUNT_CREATION_VIEW),
        );
      case Routes.SETTINGS_VIEW:
        return MaterialPageRoute(
          builder: (_) => SettingsView(),
          settings: RouteSettings(name: Routes.SETTINGS_VIEW),
        );
      case Routes.BIOMETRIC_SETTINGS_VIEW:
        return MaterialPageRoute(
          builder: (_) => BiometricSettingsView(),
          settings: RouteSettings(name: Routes.BIOMETRIC_SETTINGS_VIEW),
        );
      case Routes.PRE_LANG_VIEW:
        return MaterialPageRoute(
          builder: (_) => PreLoginLanguageSelectionView(),
          settings: RouteSettings(name: Routes.PRE_LANG_VIEW),
        );
      case Routes.LANGUAGE_VIEW:
        return MaterialPageRoute(
          builder: (_) => LanguageSelectionView(),
          settings: RouteSettings(name: Routes.LANGUAGE_VIEW),
        );
      case Routes.PASSWORD_RESET_VIEW:
        return MaterialPageRoute(
          builder: (_) => PasswordResetView(),
          settings: RouteSettings(name: Routes.PASSWORD_RESET_VIEW),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text("Invalid Route"),
            ),
          ),
        );
    }
  }
}
