import 'package:ceylife_digital/features/presentation/common/ceylife_bottom_sheet.dart';
import 'package:ceylife_digital/features/presentation/views/common/data/bottom_sheet_data.dart';
import 'package:flutter/material.dart';

class AppDataPicker {
  final List<BottomSheetData> dataList;
  final Function(BottomSheetData) onSelectItem;
  BottomSheetData defaultSelectedItem;
  final String title;
  final double height;
  final bool isSearchable;

  AppDataPicker(
      {@required this.dataList,
      this.onSelectItem,
      this.defaultSelectedItem,
      this.title,
      this.height = 382,
      this.isSearchable = false});

  showPicker(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isDismissible: false,
      enableDrag: false,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      builder: (BuildContext context) {
        return CeylifeBottomSheet(
          isSearchable: isSearchable,
          dataList: dataList,
          height: height,
          callback: (selectedData) {
            if (selectedData != null) {
              defaultSelectedItem = selectedData;
              onSelectItem(selectedData);
            }
          },
          title: title,
          selectedIndex: dataList.indexOf(defaultSelectedItem),
        );
      },
    );
  }
}
