import 'package:ceylife_digital/core/network/network_config.dart';
import 'package:ceylife_digital/error/failures.dart';
import 'package:ceylife_digital/error/messages.dart';
import 'package:ceylife_digital/features/data/models/responses/common_error_response.dart';
import 'package:ceylife_digital/features/domain/entities/request/payment_status_check_request_entity.dart';
import 'package:ceylife_digital/features/domain/usecases/usecase_check_payment_status.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';
import 'package:ceylife_digital/features/presentation/bloc/directpay_bloc/directpay_event.dart';
import 'package:ceylife_digital/features/presentation/bloc/directpay_bloc/directpay_state.dart';
import 'package:ceylife_digital/utils/app_constants.dart';

import '../base_bloc.dart';

class DirectPayBloc
    extends BaseBloc<DirectPayEvent, BaseState<DirectPayState>> {
  final UseCaseCheckPaymentStatus useCaseCheckPaymentStatus;

  DirectPayBloc({this.useCaseCheckPaymentStatus})
      : super(InitialDirectPayState());

  @override
  Stream<BaseState<DirectPayState>> mapEventToState(
      DirectPayEvent event) async* {
    if (event is CheckPaymentStatusEvent) {
      yield APILoadingState();
      final result = await useCaseCheckPaymentStatus(
          PaymentStatusCheckRequestEntity(refCode: event.referenceNumber));

      yield result.fold((l) {
        if (l is AuthorizedFailure) {
          return SessionExpireState();
        } else
          return APIFailureState(
              errorResponseModel: ErrorResponseModel(
                  responseError: ErrorMessages().mapFailureToMessage(l)));
      }, (r) {
        if (r.responseCode == APIResponse.RESPONSE_SUCCESS) {
          if (r.paymentStatus == AppConstants.DIRECT_PAY_SUCCESS_STATE)
            return DirectPayPaymentSuccessState();
          else
            return DirectPayPaymentFailedState();
        } else if (r.responseCode ==
            APIResponse.RESPONSE_FAILED_TRANSACTION_NOT_FOUND)
          return PaymentFailedState();
        else
          return APIFailureState(
              errorResponseModel:
                  ErrorResponseModel(responseError: r.responseError));
      });
    }
  }
}
