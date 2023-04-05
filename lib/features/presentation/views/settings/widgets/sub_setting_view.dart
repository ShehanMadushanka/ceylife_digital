import 'package:ceylife_digital/features/presentation/common/ceylife_switch.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:flutter/material.dart';

class SubSettingItemWidget extends StatefulWidget {
  final String label;
  final String subLabel;
  final Function(bool) callback;
  final bool defaultValue;

  SubSettingItemWidget(
      {this.label, this.callback, this.subLabel, this.defaultValue = false});

  @override
  _SubSettingItemWidgetState createState() => _SubSettingItemWidgetState();
}

class _SubSettingItemWidgetState extends State<SubSettingItemWidget> {
  bool _value;

  @override
  void initState() {
    super.initState();
    _value = widget.defaultValue;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.label,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: AppColors.primaryBlackColor,
                    ),
                  ),
                  CeylifeSwitch(
                    value: _value,
                    borderRadius: 30.0,
                    width: 53,
                    height: 26,
                    toggleColor: AppColors.redwoodOne,
                    inactiveColor: AppColors.dividerColor,
                    activeColor: AppColors.indianRedLightColor,
                    activeText: 'ON',
                    inactiveText: 'OFF',
                    activeSwitchBorder:
                        Border.all(color: AppColors.textColorRedwood, width: 1),
                    inactiveSwitchBorder:
                        Border.all(color: AppColors.textColorAsh, width: 1),
                    inactiveTextColor: AppColors.primaryAshColor,
                    inactiveTextFontWeight: FontWeight.w500,
                    activeTextFontWeight: FontWeight.w500,
                    activeTextColor: AppColors.textColorMaroon,
                    valueFontSize: 11,
                    padding: 0,
                    showOnOff: true,
                    toggleSize: 24,
                    onToggle: (val) {
                      setState(() {
                        _value = val;
                      });
                      widget.callback(val);
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.subLabel,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: AppColors.primaryAshColor,
                ),
              ),
              SizedBox(
                height: 12,
              ),
            ],
          ),
          Divider(
            height: 1,
            thickness: 1,
            color: AppColors.dividerColor.withOpacity(0.6),
          ),
        ],
      ),
    );
  }
}
