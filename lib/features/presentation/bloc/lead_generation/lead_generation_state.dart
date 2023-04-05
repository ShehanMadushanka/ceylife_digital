import 'package:ceylife_digital/features/data/models/common/configuration_data.dart';
import 'package:ceylife_digital/features/domain/entities/response/get_bank_branches_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/get_banks_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/register_lead_generator_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/submit_bank_details_response_entity.dart';

import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';

abstract class LeadGenerationState extends BaseState<LeadGenerationState> {}

class InitialLeadGenerationState extends LeadGenerationState {}

class LeadGenerationSuccessState extends LeadGenerationState {
  final SubmitBankDetailsResponseEntity submitBankDetailsResponseEntity;

  LeadGenerationSuccessState({this.submitBankDetailsResponseEntity});
}

class LeadGenerationFailedState extends LeadGenerationState {
  final String error;

  LeadGenerationFailedState({this.error});
}

class ConfigDataSuccessState extends LeadGenerationState{
  final ConfigurationData configurationData;

  ConfigDataSuccessState({this.configurationData});
}
class InitialGetBanksState extends LeadGenerationState{}

class GetBanksLoaded extends LeadGenerationState {
final BanksResponseEntity banksResponseEntity;

  GetBanksLoaded({this.banksResponseEntity});
}
class GetBanksFailedState extends LeadGenerationState {
  final String error;

  GetBanksFailedState({this.error});
}


class InitialBranchesState extends LeadGenerationState{}

class BankBranchesLoadedState extends LeadGenerationState {
  final GetBankBranchesResponseEntity bankBranchesResponseEntity;

  BankBranchesLoadedState({this.bankBranchesResponseEntity});
}

class BankBranchesFailedState extends LeadGenerationState {
  final String error;

  BankBranchesFailedState({this.error});
}
class InitialRegisterLeadGeneratorState extends LeadGenerationState {}

class RegisterLeadGeneratorSuccessState extends LeadGenerationState {
  final RegisterLeadGeneratorResponseEntity registerLeadGeneratorResponseEntity;

  RegisterLeadGeneratorSuccessState({this.registerLeadGeneratorResponseEntity});
}

class RegisterLeadGeneratorFailedState extends LeadGenerationState{
  final String error;

  RegisterLeadGeneratorFailedState ({this.error});
}

class PasswordMatchingFailedState extends LeadGenerationState {
  final String error;

  PasswordMatchingFailedState({this.error});
}

class ExistingUserFailedState extends LeadGenerationState{
  final String error;

  ExistingUserFailedState({this.error});
}