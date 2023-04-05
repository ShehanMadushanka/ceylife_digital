import 'package:ceylife_digital/features/domain/entities/request/branches_request_entity.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_event.dart';

abstract class BranchesEvent extends BaseEvent {}

class GetBranchesEvent extends BranchesEvent {
  final BranchesRequestEntity branchesRequestEntity;

  GetBranchesEvent({this.branchesRequestEntity});
}
