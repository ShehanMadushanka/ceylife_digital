import 'package:equatable/equatable.dart';

class ContactUsEntity extends Equatable {
  ContactUsEntity({
    this.code,
    this.description,
    this.value,
    this.status
  });

  final String code;
  final String description;
  final String value;
  final String status;

  @override
  List<Object> get props => [code, description, value, status];
}
