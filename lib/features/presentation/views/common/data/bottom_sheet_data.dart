import 'package:equatable/equatable.dart';

class BottomSheetData extends Equatable{
  int id;
  String description;
  String fontFamily;
  bool isSelected;

  BottomSheetData({this.id, this.description, this.isSelected = false, this.fontFamily = "SohoGothicPro"});

  @override
  List<Object> get props => [id];
}
