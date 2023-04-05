import 'package:ceylife_digital/features/data/models/responses/common_error_response.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  Failure([List properties = const <dynamic>[]]);

  @override
  List<Object> get props => props;
}

// General failures
class ServerFailure extends Failure {
  final ErrorResponseModel errorResponse;

  ServerFailure(this.errorResponse);
}

class CacheFailure extends Failure {}

class ConnectionFailure extends Failure {}

class AuthorizedFailure extends Failure {
  final ErrorResponseModel errorResponse;

  AuthorizedFailure(this.errorResponse);
}
