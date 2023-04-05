import 'package:ceylife_digital/core/service/platform_services.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_button.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:ceylife_digital/utils/enums.dart';
import 'package:flutter/material.dart';

class SecurityFailureView extends StatelessWidget {
  final SecurityFailureType securityFailureType;

  SecurityFailureView({this.securityFailureType});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xff790013), Color(0xff370009)],
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: Text(
                getSecurityFailureMessage(),
                style: TextStyle(color: AppColors.appBarTitle, fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
            securityFailureType == SecurityFailureType.ADB?Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 18),
                child: CeyLifeButton(
                  onTapButton: () {
                    PlatformServices.disableADB();
                  },
                  buttonText: 'Disable USB Debugging',
                ),
              ),
            ):SizedBox.shrink()
          ],
        ),
      )),
    );
  }

  String getSecurityFailureMessage() {
    switch (securityFailureType) {
      case SecurityFailureType.ADB:
        return "Please Disable USB Debugging and \nRestart the Application";
        break;
      case SecurityFailureType.ROOT:
        return "Device is Rooted";
        break;
      case SecurityFailureType.EMU:
        return "App is running on an Emulator";
        break;
      case SecurityFailureType.SECURE:
        return "";
        break;
      case SecurityFailureType.SOURCE:
        return "Source Verification Failed";
        break;
    }
  }
}
