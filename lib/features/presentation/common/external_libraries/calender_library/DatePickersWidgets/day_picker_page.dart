import 'package:ceylife_digital/features/presentation/common/external_libraries/calender_library/color_picker_dialog.dart';
import 'package:ceylife_digital/features/presentation/common/external_libraries/calender_library/event.dart';
import 'package:ceylife_digital/features/presentation/common/external_libraries/calender_library/flutter_date_pickers.dart'
    as dp;
import 'package:flutter/material.dart';

class DayPickerPage extends StatefulWidget {
  final List<Event> events;
  final Function(DateTime) onTapDay;
  final int year;
  final int month;
  final int day;
  final DateTime lastDate;

  const DayPickerPage(
      {Key key,
      this.events,
      this.onTapDay,
      this.year,
      this.month,
      this.day,
      this.lastDate})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _DayPickerPageState();
}

class _DayPickerPageState extends State<DayPickerPage> {
  DateTime _selectedDate;
  DateTime _firstDate;
  DateTime _lastDate;
  Color selectedDateStyleColor;
  Color selectedSingleDateDecorationColor;

  @override
  void initState() {
    super.initState();

    _selectedDate = DateTime.utc(widget.year, widget.month, widget.day);
    _firstDate = DateTime.now();
    _lastDate = widget.lastDate;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    selectedDateStyleColor = Color(0xff790013);
    selectedSingleDateDecorationColor = Color(0xff790013);
  }

  @override
  Widget build(BuildContext context) {
    // add selected colors to default settings
    dp.DatePickerStyles styles = dp.DatePickerRangeStyles(
        selectedDateStyle: Theme.of(context)
            .accentTextTheme
            .bodyText1
            .copyWith(color: Colors.white),
        selectedSingleDateDecoration:
            BoxDecoration(color: selectedSingleDateDecorationColor));

    return Flex(
      direction: MediaQuery.of(context).orientation == Orientation.portrait
          ? Axis.vertical
          : Axis.horizontal,
      children: <Widget>[
        Expanded(
          child: dp.DayPicker(
            selectedDate:
                _selectedDate.isAfter(_lastDate) ? _lastDate : _selectedDate,
            onChanged: _onSelectedDateChanged,
            firstDate: _firstDate,
            lastDate: _lastDate.isBefore(_firstDate) ? _firstDate : _lastDate,
            datePickerStyles: styles,
            datePickerLayoutSettings:
                dp.DatePickerLayoutSettings(maxDayPickerRowCount: 2),
            selectableDayPredicate: _isSelectableCustom,

            ///Event removed
//            eventDecorationBuilder: _eventDecorationBuilder,
          ),
        ),
      ],
    );
  }

  // select text color of the selected date
  void _showSelectedDateDialog() async {
    Color newSelectedColor = await showDialog(
        context: context,
        builder: (_) => ColorPickerDialog(
              selectedColor: selectedDateStyleColor,
            ));

    if (newSelectedColor != null)
      setState(() {
        selectedDateStyleColor = newSelectedColor;
      });
  }

  // select background color of the selected date
  void _showSelectedBackgroundColorDialog() async {
    Color newSelectedColor = await showDialog(
        context: context,
        builder: (_) => ColorPickerDialog(
              selectedColor: selectedSingleDateDecorationColor,
            ));

    if (newSelectedColor != null)
      setState(() {
        selectedSingleDateDecorationColor = newSelectedColor;
      });
  }

  // add callback to get current date
  void _onSelectedDateChanged(DateTime newDate) {
    setState(() {
      _selectedDate = newDate;
      widget.onTapDay(_selectedDate);
    });
  }

  bool _isSelectableCustom(DateTime day) {
    return day.day < 29;
  }

  dp.EventDecoration _eventDecorationBuilder(DateTime date) {
    List<DateTime> eventsDates =
        widget.events?.map<DateTime>((Event e) => e.date)?.toList();
    bool isEventDate = eventsDates?.any((DateTime d) =>
            date.year == d.year &&
            date.month == d.month &&
            d.day == date.day) ??
        false;

    // BoxDecoration roundedBorder = BoxDecoration(
    //     border: Border.all(
    //       color: Colors.deepOrange,
    //     ),
    //     borderRadius: BorderRadius.all(Radius.circular(3.0)));

    // return isEventDate
    //     ? dp.EventDecoration(boxDecoration: roundedBorder)
    //     : null;
  }
}
