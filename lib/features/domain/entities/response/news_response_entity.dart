import 'package:equatable/equatable.dart';

class CeylifeNewsEntity extends Equatable {
  final String newsTitle;
  final String newsDescription;
  final String dateTime;
  bool isHeadline;
  final String image;
  final String thumbnail;
  final int newsUpdateDetailsId;
  final String createdTime;

  CeylifeNewsEntity(
      {this.newsTitle,
      this.newsDescription,
      this.dateTime,
      this.isHeadline,
      this.image,
      this.newsUpdateDetailsId,
      this.createdTime,
      this.thumbnail});

  @override
  List<Object> get props => [
        newsTitle,
        newsDescription,
        dateTime,
        isHeadline,
        image,
        newsUpdateDetailsId
      ];
}

class GetNewsResponseEntity extends Equatable {
  String responseCode;
  String responseError;
  List<CeylifeNewsEntity> newsData;

  GetNewsResponseEntity({this.responseCode, this.responseError, this.newsData});

  @override
  List<Object> get props => [responseCode, responseError, newsData];
}
