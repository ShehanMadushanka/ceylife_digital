import 'dart:convert';

import 'package:ceylife_digital/core/network/network_config.dart';
import 'package:ceylife_digital/error/failures.dart';
import 'package:ceylife_digital/error/messages.dart';
import 'package:ceylife_digital/features/data/datasources/shared_preference.dart';
import 'package:ceylife_digital/features/data/models/responses/common_error_response.dart';
import 'package:ceylife_digital/features/domain/entities/request/get_bank_branches_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/request/register_lead_generator_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/request/submit_bank_details_request_entity.dart';
import 'package:ceylife_digital/features/domain/usecases/use_case_get_bank_branches.dart';
import 'package:ceylife_digital/features/domain/usecases/use_case_get_banks.dart';
import 'package:ceylife_digital/features/domain/usecases/usecase_register_lead_generator.dart';
import 'package:ceylife_digital/features/domain/usecases/usecase_submit_bank_details.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';
import 'package:ceylife_digital/utils/app_constants.dart';
import 'package:ceylife_digital/utils/app_extensions.dart';
import 'package:ceylife_digital/utils/validator.dart';
import 'package:huawei_map/constants/param.dart';

import 'lead_generation_event.dart';
import 'lead_generation_state.dart';

class LeadGenerationBloc
    extends BaseBloc<LeadGenerationEvent, BaseState<LeadGenerationState>> {
  final UseCaseSubmitBankDetails useCaseSubmitBankDetails;
  final UseCaseGetBanks useCaseGetBanks;
  final UseCaseGetBankBranches useCaseGetBankBranches;
  final UseCaseRegisterLeadGenerator useCaseRegisterLeadGenerator;
  final AppSharedData appSharedData;

  LeadGenerationBloc(
      {this.useCaseSubmitBankDetails,
      this.useCaseGetBanks,
      this.appSharedData,
      this.useCaseGetBankBranches,
      this.useCaseRegisterLeadGenerator})
      : super(InitialLeadGenerationState());

  @override
  Stream<BaseState<LeadGenerationState>> mapEventToState(
      LeadGenerationEvent event) async* {
    if (event is LeadGeneration) {
      final cacheUser = await appSharedData.getCacheUser();
      yield APILoadingState();
      final result = await useCaseSubmitBankDetails(
          SubmitBankDetailsRequestEntity(
              accountHolderName: event.accountHolderName,
              accountNo: event.accountNo,
              bankCode: event.bankCode,
              bankBranchId: event.bankBranchId,
              leadGeneratorId: cacheUser.leadGeneratorId));
      yield result.fold(
          (l) => APIFailureState(
              errorResponseModel: ErrorResponseModel(
                  responseError: ErrorMessages().mapFailureToMessage(l))), (r) {
        if (r.responseCode == APIResponse.RESPONSE_SUCCESS) {
          return LeadGenerationSuccessState(submitBankDetailsResponseEntity: r);
        } else
          return LeadGenerationFailedState(error: ErrorMessages().mapAPIErrorCode(r.responseCode, r.responseError));
      });
    } else if (event is GetBanksEvent) {
      yield APILoadingState();
      final result = await useCaseGetBanks(Param());
      yield result.fold((l) {
        if (l is AuthorizedFailure) {
          if (AppConstants.IS_USER_LOGGED)
            return SessionExpireState();
          else
            return GetBanksFailedState(
                error: ErrorMessages().mapFailureToMessage(l));
        } else
          return GetBanksFailedState(
              error: ErrorMessages().mapFailureToMessage(l));
      }, (r) {
        if (r.responseCode == APIResponse.RESPONSE_SUCCESS)
          return GetBanksLoaded(banksResponseEntity: r);
        else
          return GetBanksFailedState(error: ErrorMessages().mapAPIErrorCode(r.responseCode, r.responseError));
      });
    } else if (event is GetBankBranchesEvent) {
      yield APILoadingState();
      final result = await useCaseGetBankBranches(
          GetBankBranchesRequestEntity(bankCode: event.bankCode));
      yield result.fold((l) {
        if (l is AuthorizedFailure) {
          if (AppConstants.IS_USER_LOGGED)
            return SessionExpireState();
          else
            return BankBranchesFailedState(
                error: ErrorMessages().mapFailureToMessage(l));
        } else
          return BankBranchesFailedState(
              error: ErrorMessages().mapFailureToMessage(l));
      }, (r) {
        if (r.responseCode == APIResponse.RESPONSE_SUCCESS)
          return BankBranchesLoadedState(bankBranchesResponseEntity: r);
        else
          return BankBranchesFailedState(error: ErrorMessages().mapAPIErrorCode(r.responseCode, r.responseError));
      });
    } else if (event is RegisterLeadGeneratorEvent) {
      final confData = await appSharedData.getConfigurationData();
      if (event.isNewUser) {
        if (event.password != event.repeatPassword)
          yield PasswordMatchingFailedState(
              error: ErrorMessages().mapAPIErrorCode(ErrorMessages.APP_PASSWORD_MISMATCH,""));
        else if (!Validator.validatePassword(
            event.password, confData.passwordPolicy)) {
          yield PasswordMatchingFailedState(
              error: ErrorMessages().mapAPIErrorCode(ErrorMessages.APP_PASSWORD_POLICY_MISMATCH,""));
        } else {
          yield APILoadingState();
          final result = await useCaseRegisterLeadGenerator(
              RegisterLeadGeneratorRequestEntity(
                  nic: event.nic,
                  userName: event.userName,
                  nickName: event.nickName,
                  password:
                      base64.encode(utf8.encode(event.password.getSHA1())),
                  branchId: event.branchId,
                  accountHolderName: event.accountHolderName,
                  accountNo: event.accountNo,
                  addressCity: event.addressCity,
                  addressLine1: event.addressLine1,
                  addressLine2: event.addressLine2,
                  bankBranchId: event.bankBranchId,
                  bankCode: event.bankCode,
                  contactNo: event.contactNo,
                  contactNo2: event.contactNo2,
                  email: event.email,
                  fullName: event.fullName));
          yield result.fold(
              (l) => APIFailureState(
                  errorResponseModel: ErrorResponseModel(
                      responseError: ErrorMessages().mapFailureToMessage(l))),
              (r) {
            if (r.responseCode == APIResponse.RESPONSE_SUCCESS) {
              return RegisterLeadGeneratorSuccessState();
            } else if (r.responseCode ==
                APIResponse.RESPONSE_FAILED_EXISTING_USER_ID)
              return ExistingUserFailedState(
                  error: ErrorMessages().mapAPIErrorCode(ErrorMessages.APP_USER_ID_TAKEN,""));
            else
              return RegisterLeadGeneratorFailedState(error: ErrorMessages().mapAPIErrorCode(r.responseCode, r.responseError));
          });
        }
      } else {
        yield APILoadingState();
        final result = await useCaseRegisterLeadGenerator(
            RegisterLeadGeneratorRequestEntity(
                nic: event.nic,
                userName: event.userName,
                nickName: event.nickName,
                password: event.password,
                branchId: event.branchId,
                accountHolderName: event.accountHolderName,
                accountNo: event.accountNo,
                addressCity: event.addressCity,
                addressLine1: event.addressLine1,
                addressLine2: event.addressLine2,
                bankBranchId: event.bankBranchId,
                bankCode: event.bankCode,
                contactNo: event.contactNo,
                contactNo2: event.contactNo2,
                email: event.email,
                fullName: event.fullName));
        yield result.fold(
            (l) => APIFailureState(
                errorResponseModel: ErrorResponseModel(
                    responseError: ErrorMessages().mapFailureToMessage(l))),
            (r) {
          if (r.responseCode == APIResponse.RESPONSE_SUCCESS) {
            RegisterLeadGeneratorSuccessState();
            return RegisterLeadGeneratorSuccessState();
          } else
            return RegisterLeadGeneratorFailedState(error: ErrorMessages().mapAPIErrorCode(r.responseCode, r.responseError));
        });
      }
    } else if (event is GetConfigData) {
      final confData = await appSharedData.getConfigurationData();
      yield ConfigDataSuccessState(configurationData: confData);
    }
  }
}
