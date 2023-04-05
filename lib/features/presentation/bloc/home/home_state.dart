import 'package:ceylife_digital/features/domain/entities/response/login_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/password_reset_otp_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/policy_details_response_entity.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';

abstract class HomeState extends BaseState<HomeState> {}

class InitialHomeState extends HomeState {}

class ProfileDataLoadedState extends HomeState {
  final ProfileEntity profileEntity;

  ProfileDataLoadedState({this.profileEntity});
}

class ProfileDataFailedState extends HomeState {
  final String error;

  ProfileDataFailedState({this.error});
}

class PolicyLoadedState extends HomeState {
  final PolicyDetailsResponseEntity policyDetailsResponseEntity;

  PolicyLoadedState({this.policyDetailsResponseEntity});
}

class PolicyLoadingFailedState extends HomeState {
  final String error;

  PolicyLoadingFailedState({this.error});
}

class PasswordResetOtpSuccessState extends HomeState{
  final PasswordResetOtpResponseEntity passwordResetOtpResponseEntity;

  PasswordResetOtpSuccessState({this.passwordResetOtpResponseEntity});
}
