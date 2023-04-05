import 'package:ceylife_digital/features/data/models/requests/get_user_profile_request.dart';

class UserProfileRequestEntity extends UserProfileRequest {
  UserProfileRequestEntity({
    this.mobileUserId,
  }) : super(mobileUserId: mobileUserId);

  int mobileUserId;
}
