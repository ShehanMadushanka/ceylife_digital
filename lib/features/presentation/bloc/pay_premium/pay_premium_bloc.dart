import 'package:ceylife_digital/core/network/network_config.dart';
import 'package:ceylife_digital/error/failures.dart';
import 'package:ceylife_digital/error/messages.dart';
import 'package:ceylife_digital/features/data/datasources/shared_preference.dart';
import 'package:ceylife_digital/features/data/models/responses/common_error_response.dart';
import 'package:ceylife_digital/features/domain/entities/request/generate_payment_link_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/request/payment_status_check_request_entity.dart';
import 'package:ceylife_digital/features/domain/usecases/usecase_check_payment_status.dart';
import 'package:ceylife_digital/features/domain/usecases/usecase_generate_payment_link.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';
import 'package:ceylife_digital/features/presentation/bloc/pay_premium/pay_premium_event.dart';
import 'package:ceylife_digital/features/presentation/bloc/pay_premium/pay_premium_state.dart';

class PayPremiumBloc
    extends BaseBloc<PayPremiumEvent, BaseState<PayPremiumState>> {
  final UseCaseGeneratePaymentLink generatePaymentLink;
  final UseCaseCheckPaymentStatus checkPaymentStatus;
  final AppSharedData appSharedData;

  PayPremiumBloc(
      {this.generatePaymentLink, this.checkPaymentStatus, this.appSharedData})
      : super(InitialPayPremiumState());

  @override
  Stream<BaseState<PayPremiumState>> mapEventToState(
      PayPremiumEvent event) async* {
    if (event is GetGeneratedPaymentLink) {
      yield APILoadingState();
      final cacheUser = await appSharedData.getCacheUser();
      final result = await generatePaymentLink(GeneratePaymentLinkRequestEntity(
          amount: event.amount,
          policyNo: event.policyNumber,
          startDate: event.startDate,
          paymentType: event.paymentType,
          interval: event.interval,
          endDate: event.endDate,
          mobileNo: event.mobileNumber,
          premium: event.premium.toInt(),
          mobileUserId: cacheUser.mobileUserId));
      yield result.fold((l) {
        if (l is AuthorizedFailure) {
          return SessionExpireState();
        } else
          return APIFailureState(
              errorResponseModel: ErrorResponseModel(
                  responseError: ErrorMessages().mapFailureToMessage(l)));
      }, (r) {
        if (r.responseCode == APIResponse.RESPONSE_SUCCESS) {
          return PaymentLinkGenerateSuccessState(
              generatePaymentLinkResponseEntity: r);
        } else
          return APIFailureState(
              errorResponseModel:
                  ErrorResponseModel(responseError: r.responseError));
      });
    } else if (event is GetPaymentStatus) {
      yield APILoadingState();
      final result = await checkPaymentStatus(
          PaymentStatusCheckRequestEntity(refCode: event.referenceCode));
      yield result.fold((l) {
        if (l is AuthorizedFailure) {
          return SessionExpireState();
        } else
          return APIFailureState(
              errorResponseModel: ErrorResponseModel(
                  responseError: ErrorMessages().mapFailureToMessage(l)));
      }, (r) {
        if (r.responseCode == APIResponse.RESPONSE_SUCCESS) {
          return CheckPaymentStatusSuccessState(
              paymentStatusCheckResponseEntity: r);
        } else
          return APIFailureState(
              errorResponseModel:
                  ErrorResponseModel(responseError: r.responseError));
      });
    } else if (event is GetProfileDataEvent) {
      final cacheUser = await appSharedData.getCacheUser();
      yield ProfileDataLoadedState(profileEntity: cacheUser);
    }
  }
}
