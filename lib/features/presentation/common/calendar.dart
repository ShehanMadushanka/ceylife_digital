import 'package:ceylife_digital/features/presentation/common/calender_widget.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_icons_icons.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_primary_button.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:ceylife_digital/utils/app_localizations.dart';
import 'package:ceylife_digital/utils/enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:intl/intl.dart' show DateFormat;

const kAppBarGradient = LinearGradient(
  colors: [Color(0xff790013), Color(0xff790013)],
  begin: const FractionalOffset(0.0, 0.0),
  end: const FractionalOffset(0.0, 3.0),
  stops: [0.0, 5.0],
);

class Calendar extends StatefulWidget {
  final DateTime premiumCessDate;
  final Function(DateTime) selectedDate;

  const Calendar({Key key, this.premiumCessDate, this.selectedDate})
      : super(key: key);

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  bool isCalender = true;
  bool isMonth = false;
  bool isYear = false;
  bool isAvailableMonth = true;
  DateTime newMonthValFromVoidCallBack;
  DateTime newYearValFromVoidCallBack;

  String selectedDayForPass;
  String selectedYearForPass;
  String _currentMonth;
  String _currentMonthShowing;
  String _currentYearShowing;
  String _currentYear;
  int selectedMonth;
  int selectedYear;
  int selectedDay;
  DateTime _selectedDate;

  @override
  void initState() {
    selectedYear = DateTime.now().year;
    selectedMonth = DateTime.now().month;
    selectedDay = DateTime.now().day;

    if (selectedDay == 29 || selectedDay == 30 || selectedDay == 31) {
      _selectedDate = DateTime(selectedYear, selectedMonth + 1, 1);
    } else {
      _selectedDate = DateTime(selectedYear, selectedMonth, selectedDay);
    }

    selectedYear = _selectedDate.year;
    selectedMonth = _selectedDate.month;
    selectedDay = _selectedDate.day;

    _currentMonth = DateFormat.MMMM().format(_selectedDate);
    _currentYearShowing = DateFormat.y().format(_selectedDate);
    _currentYear = DateFormat.y().format(_selectedDate);
    _currentMonthShowing =
        DateFormat.MMM().format(DateTime(selectedYear, selectedMonth));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    return Container(
      child: _buildBody(),
      height: MediaQuery.of(context).size.height * 0.89,
      color: Colors.white,
    );
  }

  Widget _buildBody() {
    return ListView(
      shrinkWrap: true,
      children: [
        SizedBox(
          height: 5,
        ),
        _buildTitle(),
        _buildMonthAndYear(),
        SizedBox(
          height: 10,
        ),
        isCalender
            ? CalenderWidget(
                onTapCalender: (value) {
                  setState(() {
                    selectedDay = value.day;
                    selectedDayForPass = DateFormat.d().format(value);
                    passSelectedDay();
                  });
                },
                year: passYearToSelectDay(),
                month: passMonthToSelectDay(),
                day: passDayToSelectDay(),
                lastDate: widget.premiumCessDate,
              )
            : isMonth
                ? MonthWidget(
                    onTapCalender: (value) {
                      setState(
                        () {
                          DateTime selectedDate =
                              DateTime(value.year, value.month, value.day);

                          if (selectedDate.isAfter(widget.premiumCessDate)) {
                            newMonthValFromVoidCallBack =
                                widget.premiumCessDate;
                          } else {
                            newMonthValFromVoidCallBack = value;
                          }

                          String month = DateFormat.M()
                              .format(newMonthValFromVoidCallBack);
                          int mon = int.parse(month);
                          selectedMonth = mon;
                          isAvailableMonth = checkMonthIsAvailable(
                              mon, int.parse(_currentYearShowing));
                          String _currentMonthCreate = DateFormat.MMMM()
                              .format(newMonthValFromVoidCallBack);
                          String currentMonthIfNotAvailable =
                              DateFormat.MMM().format(_selectedDate);
                          _currentMonthShowing = isAvailableMonth
                              ? _currentMonthCreate
                              : currentMonthIfNotAvailable;
                          isCalender = true;
                          isMonth = false;
                          isYear = false;
                        },
                      );
                    },
                    year: passYearToSelectDay(),
                    month: passMonthToSelectDay(),
                  )
                : isYear
                    ? YearWidget(
                        year: passYearToSelectDay(),
                        lastYear: widget.premiumCessDate.year,
                        onTapYear: (value) {
                          setState(
                            () {
                              DateTime selectedDate = DateTime(
                                  value.year, selectedMonth, selectedDay);

                              if (selectedDate
                                  .isAfter(widget.premiumCessDate)) {
                                newYearValFromVoidCallBack =
                                    widget.premiumCessDate;
                                selectedYearForPass = DateFormat.y()
                                    .format(widget.premiumCessDate);
                                selectedDayForPass = DateFormat.d()
                                    .format(widget.premiumCessDate);
                                selectedYear = widget.premiumCessDate.year;
                                selectedMonth = widget.premiumCessDate.month;
                                selectedDay = widget.premiumCessDate.day;
                              } else {
                                newYearValFromVoidCallBack = value;
                                selectedYearForPass =
                                    DateFormat.y().format(value);
                                selectedYear = value.year;
                              }

                              String _currentYearCreate = DateFormat.y()
                                  .format(newYearValFromVoidCallBack);
                              _currentYearShowing = _currentYearCreate;
                              _currentMonthShowing = DateFormat.MMM().format(
                                  DateTime(selectedYear, selectedMonth));
                              isCalender = true;
                              isMonth = false;
                              isYear = false;
                            },
                          );
                        },
                      )
                    : SizedBox(),
        SizedBox(
          height: 20,
        ),
        _buildMessage(),
        SizedBox(
          height: 5,
        ),
        _buildSaveButton(),
      ],
    );
  }

  ///Widgets in Screen
  Widget _buildTitle() {
    return Stack(
      children: [
        Positioned(
          left: 10,
          right: 10,
          top: 8,
          child: Text(
            AppLocalizations.of(context)
                .translate("star_date_label"),
            style: TextStyle(
                color: AppColors.textColorMaroon,
                fontSize: 20,
                fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.close,
                size: 25,
                color: AppColors.chiliRed,
              ),
              color: AppColors.textColorMaroon,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMonthAndYear() {
    return Container(
      color: AppColors.textColorMaroon,
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isCalender
                      ? changeToMonth()
                      : isYear
                          ? changeToMonth()
                          : changeToCalendar();
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _monthShowing(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    color: Color.fromRGBO(212, 165, 166, 1.0),
                    size: 43,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                isCalender
                    ? changeToYear()
                    : isMonth
                        ? changeToYear()
                        : changeToCalendar();
                setState(() {});
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    _showCurrentYear(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    color: Color.fromRGBO(212, 165, 166, 1.0),
                    size: 43,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSaveButton() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: CeylifePrimaryButton(
        buttonLabel: AppLocalizations.of(context)
            .translate("label_button_select_date"),
        buttonType: (isMonth ||
                isYear ||
                selectedDay == 29 ||
                selectedDay == 30 ||
                selectedDay == 31)
            ? ButtonType.DISABLED
            : ButtonType.ENABLED,
        onTap: () {
          DateTime selectedDate =
              DateTime(selectedYear, selectedMonth, selectedDay);
          widget.selectedDate(selectedDate.isAfter(widget.premiumCessDate)
              ? widget.premiumCessDate
              : selectedDate);
          Navigator.pop(context);
        },
      ),
    );
  }

  ///Methods for Calender(day selection) widget
  String passSelectedDay() {
    if (selectedDayForPass == null) {
      String day = DateFormat.d().format(_selectedDate);
      return day;
    } else {
      return selectedDayForPass;
    }
  }

  int passYearToSelectDay() {
    if (selectedYear == null) {
      String year1 = DateFormat.y().format(_selectedDate);
      int year = int.parse(year1);
      return year;
    } else {
      return selectedYear;
    }
  }

  int passDayToSelectDay() {
    if (selectedDay == null) {
      String day1 = DateFormat.d().format(_selectedDate);
      int day = int.parse(day1);
      return day;
    } else {
      return selectedDay;
    }
  }

  int passMonthToSelectDay() {
    if (selectedMonth == null) {
      String month1 = DateFormat.M().format(_selectedDate);
      int month = int.parse(month1);
      return month;
    } else {
      return selectedMonth;
    }
  }

  ///Methods for Month(month selection) widget
  bool checkMonthIsAvailable(int month, int currentYear) {
    String currentMonthForCheck = DateFormat.M().format(_selectedDate);
    int currentMonForCheck = int.parse(currentMonthForCheck);
    String currentYearForCheck = DateFormat.y().format(_selectedDate);
    int currentYForCheck = int.parse(currentYearForCheck);
    if (currentYear == currentYForCheck) {
      if (month < currentMonForCheck) {
        return false;
      } else {
        return true;
      }
    } else {
      return true;
    }
  }

  /// Changing widgets among day, month ad year
  void changeToMonth() {
    setState(() {
      isCalender = false;
      isMonth = true;
      isYear = false;
    });
  }

  void changeToCalendar() {
    setState(() {
      isCalender = true;
      isMonth = false;
      isYear = false;
    });
  }

  void changeToYear() {
    setState(() {
      isCalender = false;
      isMonth = false;
      isYear = true;
    });
  }

  ///other supporting methods

  String _monthShowing() {
    if (_currentMonthShowing == null) {
      return _currentMonth;
    } else {
      return _currentMonthShowing;
    }
  }

  String _showCurrentYear() {
    if (_currentYearShowing == null) {
      return _currentYear;
    } else {
      return _currentYearShowing;
    }
  }

  String passSelectedYear() {
    if (selectedYearForPass == null) {
      String year = DateFormat.y().format(_selectedDate);
      return year;
    } else {
      return selectedYearForPass;
    }
  }

  Widget _buildMessage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                CeylifeIcons.ic_info,
                size: 25,
              ),
              color: AppColors.textColorMaroon,
            ),
            Text(
              AppLocalizations.of(context)
                  .translate("label_payment_calender_avoid"),
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textColorMaroon,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ],
    );
  }
}
