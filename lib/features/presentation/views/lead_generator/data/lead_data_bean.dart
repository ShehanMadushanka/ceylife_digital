class LeadData {
  final int userType;
  final String key;

  String fullName;
  String nickname;
  String email;
  int nearestBranchId;
  String mobileNumber;
  String telephoneNumber;
  String address1;
  String address2;
  String address3;

  LeadData(
      {this.userType,
      this.key,
      this.email,
      this.nickname,
      this.nearestBranchId,
      this.address1,
      this.address2,
      this.address3,
      this.fullName,
      this.mobileNumber,
      this.telephoneNumber});
}
