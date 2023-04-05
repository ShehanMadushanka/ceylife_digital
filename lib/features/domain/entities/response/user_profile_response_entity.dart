// To parse this JSON data, do
//
//     final userProfileResponse = userProfileResponseFromJson(jsonString);

import 'package:equatable/equatable.dart';

class UserProfileResponseEntity extends Equatable {
  UserProfileResponseEntity({
    this.profile,
    this.profilePictureUrl,
    this.responseCode,
    this.responseError,
  });

  Profile profile;
  String profilePictureUrl;
  String responseCode;
  String responseError;

  @override
  List<Object> get props => [profile, profilePictureUrl];
}

class Profile extends Equatable {
  Profile({
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.dateOfBirth,
    this.email,
    this.fullName,
    this.mobileNo,
    this.nicNo,
    this.nickName,
    this.profilePictureUrl,
    this.username,
    this.mobileUserId
  });

  String addressLine1;
  String addressLine2;
  String city;
  String dateOfBirth;
  String email;
  String fullName;
  String mobileNo;
  String nicNo;
  String nickName;
  String profilePictureUrl;
  String username;
  int mobileUserId;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    addressLine1: json["addressLine1"],
    addressLine2: json["addressLine2"],
    city: json["city"],
    dateOfBirth: json["dateOfBirth"],
    email: json["email"],
    fullName: json["fullName"],
    mobileNo: json["mobileNo"],
    nicNo: json["nicNo"],
    nickName: json["nickName"],
    profilePictureUrl: json["profilePictureUrl"],
    username: json["username"],
    mobileUserId: json["mobileUserId"],
  );

  Map<String, dynamic> toJson() => {
    "addressLine1": addressLine1,
    "addressLine2": addressLine2,
    "city": city,
    "dateOfBirth": dateOfBirth,
    "email": email,
    "fullName": fullName,
    "mobileNo": mobileNo,
    "nicNo": nicNo,
    "nickName": nickName,
    "profilePictureUrl": profilePictureUrl,
    "username": username,
    "mobileUserId": mobileUserId,
  };

  @override
  List<Object> get props => [addressLine1, addressLine2, city, dateOfBirth];
}
