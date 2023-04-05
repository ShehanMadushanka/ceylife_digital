import 'package:ceylife_digital/core/usecase/usecase.dart';
import 'package:ceylife_digital/error/failures.dart';
import 'package:ceylife_digital/features/domain/entities/request/user_profile_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/user_profile_response_entity.dart';
import 'package:ceylife_digital/features/domain/repositories/repository.dart';
import 'package:dartz/dartz.dart';

class UseCaseGetUserProfile
    extends UseCase<UserProfileResponseEntity, UserProfileRequestEntity> {
  final Repository repository;

  UseCaseGetUserProfile({this.repository});

  @override
  Future<Either<Failure, UserProfileResponseEntity>> call(
      UserProfileRequestEntity param) async {
    return await repository.getUserProfile(param);
  }
}
