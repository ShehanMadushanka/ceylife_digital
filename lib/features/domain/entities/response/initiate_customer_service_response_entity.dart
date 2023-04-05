import 'package:equatable/equatable.dart';

class InitiateCustomerServiceResponseEntity extends Equatable{
  InitiateCustomerServiceResponseEntity({
    this.responseCode,
    this.responseError,
  });

  String responseCode;
  String responseError;

  @override
  List<Object> get props => [responseError, responseCode];
}
