import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CheckableButton{
  bool isChecked;
  final String label;
  final String fontFamily;

  CheckableButton({this.isChecked, this.label, this.fontFamily = 'SohoGothicPro'});
}

class CeyLifeButtonList extends StatefulWidget {
  final List<CheckableButton> buttons;
  final Function(int) selectedIndex;

  CeyLifeButtonList({this.buttons, this.selectedIndex});

  @override
  _CeyLifeButtonListState createState() => _CeyLifeButtonListState();
}

class _CeyLifeButtonListState extends State<CeyLifeButtonList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: 100),
        itemCount: widget.buttons.length,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return InkWell(
            child: Container(
              height: 53,
              margin: EdgeInsets.only(bottom: 28),
              decoration: BoxDecoration(
                  border: Border.all(
                      color:
                      widget.buttons[index].isChecked ? Colors.transparent : AppColors.newsHeadlineColor),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.black, blurRadius: 0.2, offset: Offset(0.0, 0.2))
                  ],
                  gradient: widget.buttons[index].isChecked
                      ? LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.newsHeadlineColor,
                      AppColors.newsHeadlineColor2,
                    ],
                  )
                      : LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white,
                      AppColors.inactiveIndicatorColor2,
                    ],
                  )),
              child: Center(
                child: Text(
                  widget.buttons[index].label,
                  style: TextStyle(
                    fontFamily: widget.buttons[index].fontFamily,
                      color:
                      widget.buttons[index].isChecked ? Colors.white : AppColors.primaryHeadingTextColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 23),
                ),
              ),
            ),
            onTap: () {
              setState(() {
                widget.buttons.forEach((element) {
                  element.isChecked = false;
                });
                widget.buttons[index].isChecked = true;
                widget.selectedIndex(index);
              });
            },
          );
        });
  }
}