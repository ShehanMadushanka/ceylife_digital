import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CeyLifeTextField extends StatelessWidget {
  final TextEditingController controller;
  final Icon icon;
  final IconButton suffixIcon;
  final String hint;
  final int length;
  final bool optionalHint;
  final String errorMessage;
  final String inputFormatter;
  final Function(String) onTextChanged;
  final TextInputType inputType;
  bool obscureText;
  bool floatingEnabled;

  CeyLifeTextField({
    this.controller,
    this.icon,
    this.hint,
    this.inputFormatter,
    this.optionalHint = false,
    this.errorMessage,
    this.onTextChanged,
    this.inputType,
    this.obscureText = false,
    this.floatingEnabled = false,
    this.suffixIcon,
    this.length = 25,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 29),
      child: Column(
        children: [
          TextField(
            onChanged: (text) {
              onTextChanged(text);
            },
            controller: controller,
            obscureText: obscureText,
            inputFormatters: inputFormatter != null
                ? [FilteringTextInputFormatter.allow(RegExp(inputFormatter))]
                : [FilteringTextInputFormatter.deny(RegExp(''))],
            style: TextStyle(
              fontSize: optionalHint ? 16 : 18,
              fontWeight: FontWeight.w400,
              color: AppColors.appBarTitle,
            ),
            maxLength: length,
            keyboardType: inputType == null ? TextInputType.text : inputType,
            cursorColor: AppColors.appHighlightColor,
            decoration: InputDecoration(
              labelText: floatingEnabled ? hint : null,
              contentPadding: EdgeInsets.zero,
              counterText: '',
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
              prefixIcon: icon,
              suffixIcon: suffixIcon,
              alignLabelWithHint: true,
              filled: false,
              hintStyle: optionalHint
                  ? TextStyle(color: AppColors.textColorAmber)
                  : TextStyle(color: AppColors.appBarTitle),
              hintText: floatingEnabled ? null : hint,
              fillColor: AppColors.appBarTitle,
            ),
          ),
          (errorMessage != null && errorMessage.isNotEmpty)
              ? Column(
                  children: [
                    SizedBox(height: 7),
                    TextFieldError(error: errorMessage)
                  ],
                )
              : SizedBox.shrink()
        ],
      ),
    );
  }
}

class TextFieldError extends StatelessWidget {
  final String error;

  const TextFieldError({Key key, this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(7),
      decoration: BoxDecoration(color: Color(0xFFE9D2D3)),
      child: Text(
        error,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: AppColors.fieldErrorTextColor,
        ),
        maxLines: 5,
      ),
    );
  }
}
