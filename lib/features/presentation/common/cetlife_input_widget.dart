import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CeyLifeInputWidget extends StatefulWidget {
  final String title;
  final String hint;
  final bool shouldMask;
  final TextEditingController controller;
  final Function(String) onTextChage;

  CeyLifeInputWidget(
      {@required this.title,
      this.hint = "",
      @required this.controller,
      this.shouldMask = false,
      this.onTextChage});

  @override
  _CeyLifeInputWidgetState createState() => _CeyLifeInputWidgetState();
}

class _CeyLifeInputWidgetState extends State<CeyLifeInputWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          textAlign: TextAlign.start,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: AppColors.textColorMaroon,
            fontSize: 16.0,
          ),
        ),
        SizedBox(
          height: 7,
        ),
        TextFormField(
          controller: widget.controller,
          obscureText: widget.shouldMask,
          textAlign: TextAlign.start,
          onChanged: (value) {
            if (widget.onTextChage != null) widget.onTextChage(value);
          },
          cursorColor: AppColors.appHighlightColor,
          style: TextStyle(
            color: AppColors.primaryAshColor,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            filled: true,
            contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            hintText: widget.hint,
            fillColor: Colors.white,
            hintStyle: TextStyle(
                color: AppColors.textColorAsh,
                fontSize: 16,
                fontWeight: FontWeight.w400),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0),
              borderSide: BorderSide(
                width: 1,
                color: AppColors.primaryBackgroundColor,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0),
              borderSide: BorderSide(
                width: 1,
                color: AppColors.primaryBackgroundColor,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0),
              borderSide: BorderSide(
                width: 1,
                color: AppColors.primaryBackgroundColor,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0),
              borderSide: BorderSide(
                width: 1,
                color: AppColors.primaryBackgroundColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
