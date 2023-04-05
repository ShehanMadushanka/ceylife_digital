import 'package:ceylife_digital/core/usecase/usecase.dart';
import 'package:ceylife_digital/error/failures.dart';
import 'package:ceylife_digital/features/domain/entities/request/profile_data_update_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/profile_data_update_response_entity.dart';
import 'package:ceylife_digital/features/domain/repositories/repository.dart';
import 'package:dartz/dartz.dart';

class UseCaseUpdateProfile extends UseCase<ProfileDataUpdateResponseEntity,
    ProfileDataUpdateRequestEntity> {
  final Repository repository;

  UseCaseUpdateProfile({this.repository});

  @override
  Future<Either<Failure, ProfileDataUpdateResponseEntity>> call(
      ProfileDataUpdateRequestEntity param) async {
    return await repository.updateProfileData(param);
  }
}
