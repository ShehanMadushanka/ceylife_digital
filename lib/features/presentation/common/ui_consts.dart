import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:flutter/material.dart';

const kAppBarGradient = LinearGradient(
  colors: [AppColors.appbarPrimary, AppColors.appbarSecondary],
  begin: const FractionalOffset(0.0, 0.18),
  end: const FractionalOffset(0.0, 0.95),
  stops: [0.0, 1.0],
);

const kBackgroundGradient = LinearGradient(
    colors: [Colors.white, Color(0xB0DADADA)],
    stops: [0.2, 1],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter);
