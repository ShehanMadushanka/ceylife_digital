import 'dart:ui';

import 'package:ceylife_digital/features/presentation/common/external_libraries/calender_library/DatePickersWidgets/day_picker_page.dart';
import 'package:ceylife_digital/features/presentation/common/external_libraries/calender_library/DatePickersWidgets/month_picker_page.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;

///Creating Calender(day) widget
class CalenderWidget extends StatelessWidget {
  final Function(DateTime) onTapCalender;
  final int year;
  final int month;
  final int day;
  final DateTime lastDate;

  CalenderWidget(
      {this.onTapCalender, this.year, this.month, this.day, this.lastDate});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.38 * MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: DayPickerPage(
        onTapDay: onTapCalender,
        month: month,
        year: year,
        day: day,
        lastDate: lastDate,
      ),
    );
  }
}

///Creating Calender(month) widget
class MonthWidget extends StatelessWidget {
  final Function(DateTime) onTapCalender;
  final int year;
  final int month;

  MonthWidget({this.onTapCalender, this.year, this.month});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.35 * MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: MonthPickerPage(
        onTapCalender: onTapCalender,
        year: year,
        month: month,
      ),
    );
  }
}

///Creating Calender(year) widget
class YearWidget extends StatefulWidget {
  final int year;
  final int lastYear;
  final Function(DateTime) onTapYear;

  YearWidget({this.onTapYear, this.year, this.lastYear});

  @override
  _YearWidgetState createState() => _YearWidgetState();
}

class _YearWidgetState extends State<YearWidget> {
  String _currentYear = DateFormat.y().format(DateTime.now());
  var yearForYear = DateTime.now();
  var newYearForYear;
  bool selectedYear;
  final List<Widget> labels = <Widget>[];
  final _scrollDirection = Axis.vertical;
  final GlobalKey _globalKey = GlobalKey();

  int _selectedYear = DateTime.now().year;
  int _selectedIndex = 0;
  ScrollController _gridController = ScrollController();

  @override
  void initState() {
    super.initState();
    _selectedYear = widget.year;
    _yearList();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) => _gridController.position
        .ensureVisible(_globalKey.currentContext.findRenderObject(),
            alignment: 0.5));
  }

  @override
  Widget build(BuildContext context) => _yearGrid();

  Widget _yearGrid() {
    return Container(
      height: 0.5 * MediaQuery.of(context).size.height,
      child: GridView.builder(
        scrollDirection: _scrollDirection,
        controller: _gridController,
        physics: BouncingScrollPhysics(),
        itemCount: labels.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) => labels[index],
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      ),
    );
  }

  List<Widget> _yearList() {
    labels.clear();
    int index = 0;
    for (int y = int.parse(_currentYear); y <= widget.lastYear; y++) {
      index++;
      labels.add(
        Padding(
          key: (_selectedYear == y) ? _globalKey : null,
          padding: const EdgeInsets.all(15.0),
          child: Container(
            child: FlatButton(
              child: Text(
                y.toString(),
                style: TextStyle(
                  fontSize: 20,
                  color: (y == _selectedYear) ? Colors.white : Colors.black,
                ),
              ),
              onPressed: () {
                setState(() {
                  _selectedIndex = index;
                  _selectedYear = y;
                  widget.onTapYear(DateTime(_selectedYear));
                });
              },
              color: (y == _selectedYear)
                  ? AppColors.textColorMaroon
                  : Colors.white,
            ),
          ),
        ),
      );
    }

    return labels;
  }
}
