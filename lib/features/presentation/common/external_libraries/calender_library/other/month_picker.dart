import 'dart:async';

import 'package:ceylife_digital/features/presentation/common/external_libraries/calender_library/flutter_date_pickers.dart';
import 'package:ceylife_digital/features/presentation/common/external_libraries/calender_library/other/date_picker_keys.dart';
import 'package:ceylife_digital/features/presentation/common/external_libraries/calender_library/other/layout_settings.dart';
import 'package:ceylife_digital/features/presentation/common/external_libraries/calender_library/other/semantic_sorting.dart';
import 'package:ceylife_digital/features/presentation/common/external_libraries/calender_library/other/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart' as intl;
import 'package:intl/intl.dart' show DateFormat;

import 'date_picker_styles.dart';

// Styles for current displayed period (year): Theme.of(context).textTheme.subhead
//
// Styles for date picker cell:
// current date: Theme.of(context).textTheme.body2.copyWith(color: themeData.accentColor)
// if date disabled: Theme.of(context).textTheme.body1.copyWith(color: themeData.disabledColor)
// if date selected:
//  text - Theme.of(context).accentTextTheme.body2
//  for box decoration - color is Theme.of(context).accentColor and box shape is circle

class MonthPicker extends StatefulWidget {
  final Function(DateTime) onTapCalender;
  MonthPicker({
    Key key,
    this.onTapCalender,
    @required this.selectedDate,
    @required this.onChanged,
    @required this.firstDate,
    @required this.lastDate,
    this.datePickerLayoutSettings = const DatePickerLayoutSettings(),
    this.datePickerKeys,
    this.datePickerStyles,
  })  : assert(selectedDate != null),
        assert(onChanged != null),
        assert(!firstDate.isAfter(lastDate)),
        assert(selectedDate.isAfter(firstDate) ||
            selectedDate.isAtSameMomentAs(firstDate)),
        assert(selectedDate.isBefore(lastDate) ||
            selectedDate.isAtSameMomentAs(lastDate)),
        super(key: key);

  /// The currently selected date.
  ///
  /// This date is highlighted in the picker.
  final DateTime selectedDate;

  /// Called when the user picks a month.
  final ValueChanged<DateTime> onChanged;

  /// The earliest date the user is permitted to pick.
  final DateTime firstDate;

  /// The latest date the user is permitted to pick.
  final DateTime lastDate;

  /// Layout settings what can be customized by user
  final DatePickerLayoutSettings datePickerLayoutSettings;

  /// Some keys useful for integration tests
  final DatePickerKeys datePickerKeys;

  /// Styles what can be customized by user
  final DatePickerStyles datePickerStyles;

  @override
  State<StatefulWidget> createState() => _MonthPickerState();
}

class _MonthPickerState extends State<MonthPicker> {
  Function function;
  MaterialLocalizations localizations;
  TextDirection textDirection;

  DateTime _todayDate;
  DateTime _currentDisplayedYearDate;
  Timer _timer;
  PageController _monthPickerController;

  /// True if the earliest allowable year is displayed.
  bool get _isDisplayingFirstYear =>
      !_currentDisplayedYearDate.isAfter(DateTime(widget.firstDate.year));

  /// True if the latest allowable year is displayed.
  bool get _isDisplayingLastYear =>
      !_currentDisplayedYearDate.isBefore(DateTime(widget.lastDate.year));

  DateTime _previousYearDate;
  DateTime _nextYearDate;

  @override
  void initState() {
    super.initState();
    function = widget.onTapCalender;
    // Initially display the pre-selected date.
    final int yearPage =
        DatePickerUtils.yearDelta(widget.firstDate, widget.selectedDate);
    _monthPickerController = PageController(initialPage: yearPage);
    _handleYearPageChanged(yearPage);
    _updateCurrentDate();
  }

  @override
  void didUpdateWidget(MonthPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedDate != oldWidget.selectedDate) {
      final int yearPage =
          DatePickerUtils.yearDelta(widget.firstDate, widget.selectedDate);
      _monthPickerController = PageController(initialPage: yearPage);
      _handleYearPageChanged(yearPage);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    localizations = MaterialLocalizations.of(context);
    textDirection = Directionality.of(context);
  }

  void _updateCurrentDate() {
    _todayDate = DateTime.now();
    final DateTime tomorrow =
        DateTime(_todayDate.year, _todayDate.month, _todayDate.day + 1);
    Duration timeUntilTomorrow = tomorrow.difference(_todayDate);
    timeUntilTomorrow +=
        const Duration(seconds: 1); // so we don't miss it by rounding
    _timer?.cancel();
    _timer = Timer(timeUntilTomorrow, () {
      setState(() {
        _updateCurrentDate();
      });
    });
  }

  /// Add years to a year truncated date.
  DateTime _addYearsToYearDate(DateTime yearDate, int yearsToAdd) {
    return DateTime(yearDate.year + yearsToAdd);
  }

  Widget _buildItems(BuildContext context, int index) {
    final DateTime year = _addYearsToYearDate(widget.firstDate, index);

    final ThemeData theme = Theme.of(context);
    DatePickerStyles styles = widget.datePickerStyles ?? DatePickerStyles();
    styles = styles.fulfillWithTheme(theme);

    return _MonthPicker(
      onTapCalender: function,
      key: ValueKey<DateTime>(year),
      selectedDate: widget.selectedDate,
      currentDate: _todayDate,
      onChanged: widget.onChanged,
      firstDate: widget.firstDate,
      lastDate: widget.lastDate,
      datePickerLayoutSettings: widget.datePickerLayoutSettings,
      displayedYear: year,
      selectedPeriodKey: widget.datePickerKeys?.selectedPeriodKeys,
      datePickerStyles: styles,
    );
  }

  void _handleNextYear() {
    if (!_isDisplayingLastYear) {
      SemanticsService.announce(
          localizations.formatYear(_nextYearDate), textDirection);
      _monthPickerController.nextPage(
          duration: widget.datePickerLayoutSettings.pagesScrollDuration,
          curve: Curves.ease);
      //_monthPickerController.jumpToPage();
    }
  }

  void _handlePreviousYear() {
    if (!_isDisplayingFirstYear) {
      SemanticsService.announce(
          localizations.formatYear(_previousYearDate), textDirection);
      _monthPickerController.previousPage(
          duration: widget.datePickerLayoutSettings.pagesScrollDuration,
          curve: Curves.ease);
    }
  }

  void _handleYearPageChanged(int yearPage) {
    setState(() {
      _previousYearDate = _addYearsToYearDate(widget.firstDate, yearPage - 1);
      _currentDisplayedYearDate =
          _addYearsToYearDate(widget.firstDate, yearPage);
      _nextYearDate = _addYearsToYearDate(widget.firstDate, yearPage + 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.datePickerLayoutSettings.monthPickerPortraitWidth,
      height: widget.datePickerLayoutSettings.maxDayPickerHeight,
      child: Stack(
        children: <Widget>[
          Semantics(
            sortKey: YearPickerSortKey.calendar,
            child: PageView.builder(
              key: ValueKey<DateTime>(widget.selectedDate),
              controller: _monthPickerController,
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount:
                  DatePickerUtils.yearDelta(widget.firstDate, widget.lastDate) +
                      1,
              itemBuilder: _buildItems,
              onPageChanged: _handleYearPageChanged,
            ),
          ),
        ],
      ),
    );
  }
}

class _MonthPicker extends StatelessWidget {
  /// The month whose days are displayed by this picker.
  final DateTime displayedYear;

  /// The earliest date the user is permitted to pick.
  final DateTime firstDate;

  /// The latest date the user is permitted to pick.
  final DateTime lastDate;

  /// The currently selected date.
  ///
  /// This date is highlighted in the picker.
  final DateTime selectedDate;

  /// The current date at the time the picker is displayed.
  final DateTime currentDate;

  /// Layout settings what can be customized by user
  final DatePickerLayoutSettings datePickerLayoutSettings;

  /// Called when the user picks a day.
  final ValueChanged<DateTime> onChanged;

  ///  Key fo selected month (useful for integration tests)
  final Key selectedPeriodKey;

  /// Styles what can be customized by user
  final DatePickerStyles datePickerStyles;

  //TODO-Newly added for void callback
  final Function(DateTime) onTapCalender;

  _MonthPicker(
      {@required this.displayedYear,
      @required this.firstDate,
      @required this.lastDate,
      @required this.selectedDate,
      @required this.currentDate,
      @required this.onChanged,
      @required this.datePickerLayoutSettings,
      @required this.selectedPeriodKey,
      @required this.datePickerStyles,
      Key key,
      this.onTapCalender})
      : assert(displayedYear != null),
        assert(selectedDate != null),
        assert(currentDate != null),
        assert(firstDate != null),
        assert(datePickerLayoutSettings != null),
        assert(lastDate != null),
        assert(!firstDate.isAfter(lastDate)),
        assert(selectedDate.isAfter(firstDate) ||
            selectedDate.isAtSameMomentAs(firstDate)),
        super(key: key);

  // we only wondering to know if month of passed day before the month of the firstDate or after the month of the lastDate
  // don't need to compare day and time
  bool _isDisabled(DateTime month) {
    DateTime beginningOfTheFirstDateMonth =
        DateTime(firstDate.year, firstDate.month);
    DateTime endOfTheLastDateMonth = DateTime(lastDate.year, lastDate.month + 1)
        .subtract(Duration(microseconds: 1));

    return month.isAfter(endOfTheLastDateMonth) ||
        month.isBefore(beginningOfTheFirstDateMonth);
  }

  @override
  Widget build(BuildContext context) {
    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);
    final Locale locale = Localizations.localeOf(context);

    bool localeExist = true;

    try {
      localeExist = intl.DateFormat.localeExists(locale.languageCode);
    } catch (e) {
      localeExist = false;
    }

    String localeChecked = localeExist ? locale.languageCode : "en_US";

    final ThemeData themeData = Theme.of(context);
    final int monthsInYear = 12;
    final int year = displayedYear.year;
    final int day = 1;

    final List<Widget> labels = <Widget>[];

    for (int i = 0; i < monthsInYear; i += 1) {
      final int month = i + 1;
      final DateTime monthToBuild = DateTime(year, month, day);

      final bool disabled = _isDisabled(monthToBuild);
      final bool isSelectedMonth =
          selectedDate.year == year && selectedDate.month == month;

      BoxDecoration decoration;
      TextStyle itemStyle = themeData.textTheme.bodyText2;

      if (isSelectedMonth) {
        // The selected month gets a circle background highlight, and a contrasting text color.
        itemStyle = datePickerStyles.selectedDateStyle;
        decoration = datePickerStyles.selectedSingleDateDecoration;
      } else if (disabled) {
        itemStyle = datePickerStyles.disabledDateStyle;
      } else if (currentDate.year == year && currentDate.month == month) {
        // The current month gets a different text color.
        itemStyle = datePickerStyles.currentDateStyle;
      } else {
        itemStyle = datePickerStyles.defaultDateTextStyle;
      }

      String monthStr = intl.DateFormat.MMM(localeChecked).format(monthToBuild);

      Widget monthWidget = Container(
        decoration: decoration,
        child: Center(
          child: Semantics(
            // We want the day of month to be spoken first irrespective of the
            // locale-specific preferences or TextDirection. This is because
            // an accessibility user is more likely to be interested in the
            // day of month before the rest of the date, as they are looking
            // for the day of month. To do that we prepend day of month to the
            // formatted full date.
            label:
                '${localizations.formatDecimal(month)}, ${localizations.formatFullDate(monthToBuild)}',
            selected: isSelectedMonth,
            child: ExcludeSemantics(
              child: Text(monthStr.toUpperCase(), style: itemStyle),
            ),
          ),
        ),
      );

      if (!disabled) {
        monthWidget = GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            //TODO - get month from here and navigate calender to that month
            DateTime newMonth = DateTime(year, month);
            String _currentMonth = DateFormat.MMMM().format(newMonth);
            onTapCalender(newMonth);

            DatePickerUtils.sameMonth(firstDate, monthToBuild)
                ? onChanged(firstDate)
                : onChanged(monthToBuild);
          },
          child: monthWidget,
        );
      }
      labels.add(monthWidget);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: <Widget>[
          Flexible(
            child: GridView.count(
              physics: datePickerLayoutSettings.scrollPhysics,
              crossAxisCount: 4,
              children: labels,
            ),
          ),
        ],
      ),
    );
  }
}
