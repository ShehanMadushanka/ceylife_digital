import 'package:ceylife_digital/features/presentation/common/ceylife_icons_icons.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:flutter/material.dart';

class DropdownField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final Function callBack;

  const DropdownField({Key key, @required this.controller, this.hint, this.callBack})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 29),
      child: TextFormField(
        showCursor: false,
        controller: controller,
        textAlignVertical: TextAlignVertical.center,
        onTap: () {
          callBack();
        },
        readOnly: true,
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
          color: AppColors.appBarTitle,
        ),
        decoration: InputDecoration(
          counterText: '',
          hintText: hint,
          contentPadding: EdgeInsets.zero,
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.appBarTitle, width: 1),
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.appBarTitle, width: 1),
          ),
          labelStyle: TextStyle(color: AppColors.appBarTitle),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.appBarTitle, width: 1),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.appBarTitle, width: 1),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.appBarTitle, width: 1),
          ),
          hintStyle: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
          suffixIcon: Icon(CeylifeIcons.ic_rounded_arrow_down,
              color: Colors.white, size: 40),
        ),
        onChanged: (text) {},
      ),
    );
  }
}
