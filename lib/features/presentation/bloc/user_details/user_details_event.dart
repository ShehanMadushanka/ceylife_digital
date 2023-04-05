import 'package:ceylife_digital/features/domain/entities/request/branches_request_entity.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_event.dart';

abstract class UserDetailsEvent extends BaseEvent {}

class ValidateUserEmailEvent extends UserDetailsEvent {
  final String email;

  ValidateUserEmailEvent({
    this.email,
  });
}

class GetBranchesEvent extends UserDetailsEvent {
  final BranchesRequestEntity branchesRequestEntity;

  GetBranchesEvent({this.branchesRequestEntity});
}

class NewLeadGeneratorEvent extends UserDetailsEvent {
  final String email;
  final String nic;
  final String contactNo;
  final String contactNo2;

  NewLeadGeneratorEvent({
    this.email,
    this.nic,
    this.contactNo,
    this.contactNo2,
  });
}

class SubmitNearestBranchEvent extends UserDetailsEvent{

}
