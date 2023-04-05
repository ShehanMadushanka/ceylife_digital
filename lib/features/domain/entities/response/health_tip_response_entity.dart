import 'package:equatable/equatable.dart';

class HealthTipsResponseEntity extends Equatable{
  HealthTipsResponseEntity({
    this.ageRanges,
    this.healthTips,
    this.responseCode,
    this.responseError,
    this.userAgeRange
  });

  List<AgeRangeEntity> ageRanges;
  List<HealthTipEntity> healthTips;
  String responseCode;
  String responseError;
  int userAgeRange;

  @override
  List<Object> get props => [ageRanges, healthTips, responseError, responseCode];
}

class AgeRangeEntity extends Equatable{
  AgeRangeEntity({
    this.ageFrom,
    this.ageTo,
    this.healthAgeRangeId,
    this.status,
    this.isSelected = false,
    this.isInitialItem = false
  });

  int ageFrom;
  int ageTo;
  int healthAgeRangeId;
  String status;
  bool isSelected;
  bool isInitialItem;

  @override
  List<Object> get props => [ageFrom, ageTo, healthAgeRangeId, status, isSelected, isInitialItem];
}

class HealthTipEntity extends Equatable{
  HealthTipEntity({
    this.ageRangeIds,
    this.content,
    this.createdTime,
    this.healthTipId,
    this.imageUrl,
    this.lastUpdatedTime,
    this.status,
    this.thumbnailImagePath,
    this.title,
  });

  List<int> ageRangeIds;
  String content;
  String createdTime;
  int healthTipId;
  String imageUrl;
  String lastUpdatedTime;
  String status;
  String thumbnailImagePath;
  String title;

  @override
  List<Object> get props => [ageRangeIds, content, createdTime, healthTipId, imageUrl];
}
