import 'package:ceylife_digital/features/data/models/requests/get_brances_request.dart';

class BranchesRequestEntity extends GetBranchesRequest {
  final String categoryCode;

  BranchesRequestEntity({this.categoryCode}) : super(categoryCode: categoryCode);
}
