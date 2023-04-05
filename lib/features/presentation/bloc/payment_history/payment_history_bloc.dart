import 'package:ceylife_digital/core/network/network_config.dart';
import 'package:ceylife_digital/error/failures.dart';
import 'package:ceylife_digital/error/messages.dart';
import 'package:ceylife_digital/features/data/datasources/shared_preference.dart';
import 'package:ceylife_digital/features/data/models/responses/common_error_response.dart';
import 'package:ceylife_digital/features/domain/entities/request/payment_details_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/request/policy_details_request_entity.dart';
import 'package:ceylife_digital/features/domain/usecases/usecase_get_payment_details.dart';
import 'package:ceylife_digital/features/domain/usecases/usecase_get_policy_details.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';
import 'package:ceylife_digital/features/presentation/bloc/payment_history/payment_history_event.dart';
import 'package:ceylife_digital/features/presentation/bloc/payment_history/payment_history_state.dart';

class PaymentHistoryBloc
    extends BaseBloc<PaymentHistoryEvent, BaseState<PaymentHistoryState>> {
  final UseCasePolicyDetails useCaseGetPolicy;
  final UseCasePaymentDetails useCasePaymentDetails;
  final AppSharedData appSharedData;

  PaymentHistoryBloc(
      {this.useCaseGetPolicy, this.useCasePaymentDetails, this.appSharedData})
      : super(InitialPaymentHistoryState());

  @override
  Stream<BaseState<PaymentHistoryState>> mapEventToState(
      PaymentHistoryEvent event) async* {
    if (event is GetPoliciesEvent) {
      yield APILoadingState();
      final cacheUser = await appSharedData.getCacheUser();
      final result = await useCaseGetPolicy(PolicyDetailsRequestEntity(
          clientNo: cacheUser.mobileUserId.toString()));
      yield result.fold((l) {
        if (l is AuthorizedFailure) {
          return SessionExpireState();
        } else
          return APIFailureState(
              errorResponseModel: ErrorResponseModel(
                  responseError: ErrorMessages().mapFailureToMessage(l)));
      }, (r) {
        if (r.responseCode == APIResponse.RESPONSE_SUCCESS) {
          return PolicyLoadedState(policyDetailsResponseEntity: r);
        } else
          return PolicyLoadingFailedState(error: ErrorMessages().mapAPIErrorCode(r.responseCode, r.responseError));
      });
    } else if (event is GetPaymentHistoryEvent) {
      if (event.pageNo == null) yield PaymentHistoryLoadingState();
      final result = await useCasePaymentDetails(PaymentDetailsRequestEntity(
          policyNo: event.policyNo, pageNo: event.pageNo));
      yield result.fold((l) {
        if (l is AuthorizedFailure) {
          return SessionExpireState();
        } else
          return APIFailureState(
              errorResponseModel: ErrorResponseModel(
                  responseError: ErrorMessages().mapFailureToMessage(l)));
      }, (r) {
        if (r.responseCode == APIResponse.RESPONSE_SUCCESS) {
          return PaymentHistoryLoadedState(
              paymentDetailsResponseEntity: r,
              isPageRefreshed: event.pageNo != null);
        } else
          return PaymentHistoryLoadingFailedState(error: ErrorMessages().mapAPIErrorCode(r.responseCode, r.responseError));
      });
    }
  }
}
