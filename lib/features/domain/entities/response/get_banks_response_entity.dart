import 'package:equatable/equatable.dart';

class BanksResponseEntity extends Equatable{
  BanksResponseEntity({
    this.banks,
    this.responseCode,
    this.responseError,
  });

  List<BanksEntity> banks;
  String responseCode;
  String responseError;


  @override
  List<Object> get props => [banks,responseError, responseCode];
}

class BanksEntity extends Equatable{
  BanksEntity({
    this.bankCode,
    this.bankName,
    this.createdTime,
    this.lastUpdatedTime,
    this.status
  });

  String bankCode;
  String bankName;
  String createdTime;
  String lastUpdatedTime;
  String status;

  @override
  List<Object> get props => [bankCode,bankName,createdTime,lastUpdatedTime,status];

}

