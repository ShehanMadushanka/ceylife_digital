import 'package:ceylife_digital/core/network/network_config.dart';
import 'package:ceylife_digital/error/failures.dart';
import 'package:ceylife_digital/error/messages.dart';
import 'package:ceylife_digital/features/data/models/responses/common_error_response.dart';
import 'package:ceylife_digital/features/domain/entities/request/payment_details_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/request/policy_info_request_entity.dart';
import 'package:ceylife_digital/features/domain/usecases/usecase_get_payment_details.dart';
import 'package:ceylife_digital/features/domain/usecases/usecase_get_policy_benefits.dart';
import 'package:ceylife_digital/features/domain/usecases/usecase_get_policy_loans.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';
import 'package:ceylife_digital/features/presentation/bloc/policy_details/policy_details_event.dart';
import 'package:ceylife_digital/features/presentation/bloc/policy_details/product_services_status.dart';

class PolicyDetailsBloc
    extends BaseBloc<PolicyDetailsEvent, BaseState<PolicyDetailsState>> {
  final UseCasePaymentDetails useCasePaymentDetails;
  final UseCaseGetPolicyBenefits useCaseGetPolicyBenefits;
  final UseCaseGetPolicyLoans useCaseGetPolicyLoans;

  PolicyDetailsBloc(
      {this.useCasePaymentDetails,
      this.useCaseGetPolicyLoans,
      this.useCaseGetPolicyBenefits})
      : super(InitialPolicyDetailsState());

  @override
  Stream<BaseState<PolicyDetailsState>> mapEventToState(
      PolicyDetailsEvent event) async* {
    if (event is GetPaymentHistoryEvent) {
      yield APILoadingState();
      final result = await useCasePaymentDetails(
          PaymentDetailsRequestEntity(policyNo: event.policyNo));
      yield result.fold((l) {
        if (l is AuthorizedFailure) {
          return SessionExpireState();
        } else
          return APIFailureState(
              errorResponseModel: ErrorResponseModel(
                  responseError: ErrorMessages().mapFailureToMessage(l)));
      }, (r) {
        if (r.responseCode == APIResponse.RESPONSE_SUCCESS) {
          return PaymentHistoryLoadedState(paymentDetailsResponseEntity: r);
        } else
          return APIFailureState(
              errorResponseModel:
                  ErrorResponseModel(responseError: r.responseError));
      });
    } else if (event is GetPolicyBenefitsEvent) {
      yield APILoadingState();
      final result = await useCaseGetPolicyBenefits(
          PolicyInfoRequestEntity(policyNo: event.policyNo));
      yield result.fold((l) {
        if (l is AuthorizedFailure) {
          return SessionExpireState();
        } else
          return APIFailureState(
              errorResponseModel: ErrorResponseModel(
                  responseError: ErrorMessages().mapFailureToMessage(l)));
      }, (r) {
        if (r.responseCode == APIResponse.RESPONSE_SUCCESS) {
          return PolicyBenefitsLoadedState(policyInfoResponseEntity: r);
        } else
          return APIFailureState(
              errorResponseModel:
                  ErrorResponseModel(responseError: r.responseError));
      });
    } else if (event is GetPolicyLoansEvent) {
      yield APILoadingState();
      final result = await useCaseGetPolicyLoans(
          PolicyInfoRequestEntity(policyNo: event.policyNo));
      yield result.fold((l) {
        if (l is AuthorizedFailure) {
          return SessionExpireState();
        } else
          return APIFailureState(
              errorResponseModel: ErrorResponseModel(
                  responseError: ErrorMessages().mapFailureToMessage(l)));
      }, (r) {
        if (r.responseCode == APIResponse.RESPONSE_SUCCESS) {
          return PolicyLoansLoadedState(policyInfoResponseEntity: r);
        } else
          return APIFailureState(
              errorResponseModel:
                  ErrorResponseModel(responseError: r.responseError));
      });
    }
  }
}
