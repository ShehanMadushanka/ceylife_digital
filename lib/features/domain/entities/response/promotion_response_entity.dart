import 'package:equatable/equatable.dart';

class PromotionResponseEntity extends Equatable {
  String responseCode;
  String responseError;
  List<PromotionsEntity> promotions;

  PromotionResponseEntity(
      {this.responseCode, this.responseError, this.promotions});

  @override
  List<Object> get props => [responseCode, responseError, promotions];
}

class PromotionsEntity extends Equatable {
  final String title;
  final String description;
  final String imageURL;
  final String validDate;
  final String validTime;
  final String contactNumber;
  final String link;
  final String createdTime;

  PromotionsEntity(
      {this.title,
      this.description,
      this.imageURL,
      this.validDate,
      this.validTime,
      this.contactNumber,
      this.link,
      this.createdTime});

  @override
  List<Object> get props =>
      [title, description, imageURL, validTime, validDate, contactNumber, link];
}
