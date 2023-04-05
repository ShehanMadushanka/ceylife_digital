import 'package:ceylife_digital/features/presentation/common/external_libraries/calender_library/color_picker_dialog.dart';
import 'package:ceylife_digital/features/presentation/common/external_libraries/calender_library/flutter_date_pickers.dart'
    as dp;
import 'package:flutter/material.dart';

class MonthPickerPage extends StatefulWidget {
  final Function(DateTime) onTapCalender;
  final int year;
  final int month;
  MonthPickerPage({this.onTapCalender, this.year, this.month});

  @override
  State<StatefulWidget> createState() => _MonthPickerPageState();
}

class _MonthPickerPageState extends State<MonthPickerPage> {
  DateTime _firstDate;
  DateTime _lastDate;
  DateTime _selectedDate;

  Color selectedDateStyleColor;
  Color selectedSingleDateDecorationColor;

  @override
  void initState() {
    super.initState();

    // pass selected date
    _firstDate = DateTime.utc(widget.year);
    //_lastDate = DateTime.now().add(Duration(days: 365));
    _lastDate = _firstDate.add(Duration(days: 1000));
    _selectedDate = DateTime.utc(widget.year, widget.month);
    //_selectedDate = DateTime.now();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // defaults for styles
    selectedDateStyleColor = Theme.of(context).accentTextTheme.bodyText1.color;
    selectedSingleDateDecorationColor = Color(0xff790013);
  }

  @override
  Widget build(BuildContext context) {
    // add selected colors to default settings
    Function function = widget.onTapCalender;
    dp.DatePickerStyles styles = dp.DatePickerStyles(
        selectedDateStyle: Theme.of(context)
            .accentTextTheme
            .bodyText1
            .copyWith(color: selectedDateStyleColor),
        selectedSingleDateDecoration: BoxDecoration(
          color: selectedSingleDateDecorationColor,
          shape: BoxShape.rectangle,
          // borderRadius: BorderRadius.circular(20)
        ));

    return Flex(
      direction: MediaQuery.of(context).orientation == Orientation.portrait
          ? Axis.vertical
          : Axis.horizontal,
      children: <Widget>[
        Expanded(
          child: dp.MonthPicker(
            onTapCalender: function,
            selectedDate: _selectedDate,
            onChanged: _onSelectedDateChanged,
            firstDate: _firstDate,
            lastDate: _lastDate,
            datePickerStyles: styles,
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

  void _onSelectedDateChanged(DateTime newDate) {
    setState(() {
      _selectedDate = newDate;
    });
  }
}
