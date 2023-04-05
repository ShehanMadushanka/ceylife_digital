import 'package:equatable/equatable.dart';

class BranchResponseEntity extends Equatable {
  String responseCode;
  String responseError;
  List<BranchEntity> branches;

  BranchResponseEntity({this.responseCode, this.responseError, this.branches});

  @override
  List<Object> get props => [responseCode, responseError, branches];
}

class BranchEntity extends Equatable {
  final int serviceProviderId;
  final String title;
  final String address;
  final String availableTime;
  final String contact;
  final String latitude;
  final String longitude;

  BranchEntity({
    this.serviceProviderId,
    this.title,
    this.address,
    this.availableTime,
    this.contact,
    this.latitude,
    this.longitude,
  });

  @override
  List<Object> get props =>
      [title, address, availableTime, contact, latitude, longitude];
}
