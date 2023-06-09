import 'dart:async';
import 'dart:developer';

import 'package:ceylife_digital/features/presentation/common/external_libraries/calender_library/other/basic_day_based_widget.dart';
import 'package:ceylife_digital/features/presentation/common/external_libraries/calender_library/other/date_picker_keys.dart';
import 'package:ceylife_digital/features/presentation/common/external_libraries/calender_library/other/date_picker_styles.dart';
import 'package:ceylife_digital/features/presentation/common/external_libraries/calender_library/other/event_decoration.dart';
import 'package:ceylife_digital/features/presentation/common/external_libraries/calender_library/other/i_selectable_picker.dart';
import 'package:ceylife_digital/features/presentation/common/external_libraries/calender_library/other/layout_settings.dart';
import 'package:ceylife_digital/features/presentation/common/external_libraries/calender_library/other/semantic_sorting.dart';
import 'package:ceylife_digital/features/presentation/common/external_libraries/calender_library/other/typedefs.dart';
import 'package:ceylife_digital/features/presentation/common/external_libraries/calender_library/other/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

/// Date picker based on [DayBasedPicker] picker (for days, weeks, ranges).
/// Allows select previous/next month.
class DayBasedChangeablePicker<T> extends StatefulWidget {
  /// The currently selected date.
  ///
  /// This date is highlighted in the picker.
  final DateTime selectedDate;

  /// Called when the user picks a new T.
  final ValueChanged<T> onChanged;

  /// Called when the error was thrown after user selection.
  final OnSelectionError onSelectionError;

  /// The earliest date the user is permitted to pick.
  final DateTime firstDate;

  /// The latest date the user is permitted to pick.
  final DateTime lastDate;

  /// Layout settings what can be customized by user
  final DatePickerLayoutSettings datePickerLayoutSettings;

  /// Styles what can be customized by user
  final DatePickerRangeStyles datePickerStyles;

  /// Some keys useful for integration tests
  final DatePickerKeys datePickerKeys;

  /// Logic for date selections.
  final ISelectablePicker<T> selectablePicker;

  /// Builder to get event decoration for each date.
  ///
  /// All event styles are overridden by selected styles
  /// except days with dayType is [DayType.notSelected].
  final EventDecorationBuilder eventDecorationBuilder;

  const DayBasedChangeablePicker(
      {Key key,
      this.selectedDate,
      this.onChanged,
      @required this.firstDate,
      @required this.lastDate,
      @required this.datePickerLayoutSettings,
      @required this.datePickerStyles,
      @required this.selectablePicker,
      this.datePickerKeys,
      this.onSelectionError,
      this.eventDecorationBuilder})
      : assert(datePickerLayoutSettings != null),
        assert(datePickerStyles != null),
        super(key: key);

  @override
  State<DayBasedChangeablePicker<T>> createState() =>
      _DayBasedChangeablePickerState<T>();
}

// todo: Check initial selection and call onSelectionError in case it has error (ISelectablePicker.curSelectionIsCorrupted);
class _DayBasedChangeablePickerState<T>
    extends State<DayBasedChangeablePicker<T>> {
  MaterialLocalizations localizations;
  TextDirection textDirection;

  DateTime _todayDate;
  DateTime _currentDisplayedMonthDate;
  DateTime _previousMonthDate;
  DateTime _nextMonthDate;

  // Styles from widget fulfilled with current Theme.
  DatePickerStyles _resultStyles;

  Timer _timer;
  PageController _dayPickerController;

  StreamSubscription<T> _changesSubscription;

  /// True if the first permitted month is displayed.
  bool get _isDisplayingFirstMonth => !_currentDisplayedMonthDate
      .isAfter(DateTime(widget.firstDate.year, widget.firstDate.month));

  /// True if the last permitted month is displayed.
  bool get _isDisplayingLastMonth => !_currentDisplayedMonthDate
      .isBefore(DateTime(widget.lastDate.year, widget.lastDate.month));

  @override
  void initState() {
    super.initState();
    // Initially display the pre-selected date.
    final int monthPage =
        DatePickerUtils.monthDelta(widget.firstDate, widget.selectedDate);
    _dayPickerController = PageController(initialPage: monthPage);

    _changesSubscription = widget.selectablePicker.onUpdate
        .listen((newSelectedDate) => widget.onChanged?.call(newSelectedDate))
          ..onError((e) => widget.onSelectionError != null
              ? widget.onSelectionError(e)
              : log(e.toString()));

    _handleMonthPageChanged(monthPage);
    _updateCurrentDate();
  }

  @override
  void didUpdateWidget(DayBasedChangeablePicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedDate != oldWidget.selectedDate) {
      final int monthPage =
          DatePickerUtils.monthDelta(widget.firstDate, widget.selectedDate);
      _dayPickerController = PageController(initialPage: monthPage);
      _handleMonthPageChanged(monthPage);
    }

    if (widget.datePickerStyles != oldWidget.datePickerStyles) {
      final ThemeData theme = Theme.of(context);
      _resultStyles = widget.datePickerStyles.fulfillWithTheme(theme);
    }

    if (widget.selectablePicker != oldWidget.selectablePicker) {
      _changesSubscription = widget.selectablePicker.onUpdate
          .listen((newSelectedDate) => widget.onChanged?.call(newSelectedDate))
            ..onError((e) => widget.onSelectionError != null
                ? widget.onSelectionError(e)
                : log(e.toString()));
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    localizations = MaterialLocalizations.of(context);
    textDirection = Directionality.of(context);

    final ThemeData theme = Theme.of(context);
    _resultStyles = widget.datePickerStyles.fulfillWithTheme(theme);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.datePickerLayoutSettings.monthPickerPortraitWidth,
      height: widget.datePickerLayoutSettings.maxDayPickerHeight,
      child: Column(
        children: <Widget>[
          Expanded(
            child: Semantics(
              sortKey: MonthPickerSortKey.calendar,
              child: PageView.builder(
                key: ValueKey<DateTime>(widget.selectedDate),
                physics: NeverScrollableScrollPhysics(),
                controller: _dayPickerController,
                scrollDirection: Axis.horizontal,
                itemCount: DatePickerUtils.monthDelta(
                        widget.firstDate, widget.lastDate) +
                    1,
                itemBuilder: _buildCalendar,
                onPageChanged: _handleMonthPageChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _dayPickerController?.dispose();
    _changesSubscription.cancel();
    widget.selectablePicker.dispose();
    super.dispose();
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

  Widget _buildCalendar(BuildContext context, int index) {
    final DateTime targetDate =
        DatePickerUtils.addMonthsToMonthDate(widget.firstDate, index);

    return DayBasedPicker(
      key: ValueKey<DateTime>(targetDate),
      selectablePicker: widget.selectablePicker,
      currentDate: _todayDate,
      firstDate: widget.firstDate,
      lastDate: widget.lastDate,
      displayedMonth: targetDate,
      datePickerLayoutSettings: widget.datePickerLayoutSettings,
      selectedPeriodKey: widget.datePickerKeys?.selectedPeriodKeys,
      datePickerStyles: _resultStyles,
      eventDecorationBuilder: widget.eventDecorationBuilder,
    );
  }

  void _handleNextMonth() {
    if (!_isDisplayingLastMonth) {
      SemanticsService.announce(
          localizations.formatMonthYear(_nextMonthDate), textDirection);
      _dayPickerController.nextPage(
          duration: widget.datePickerLayoutSettings.pagesScrollDuration,
          curve: Curves.ease);
    }
  }

  void _handlePreviousMonth() {
    if (!_isDisplayingFirstMonth) {
      SemanticsService.announce(
          localizations.formatMonthYear(_previousMonthDate), textDirection);
      _dayPickerController.previousPage(
          duration: widget.datePickerLayoutSettings.pagesScrollDuration,
          curve: Curves.ease);
    }
  }

  void _handleMonthPageChanged(int monthPage) {
    setState(() {
      _previousMonthDate =
          DatePickerUtils.addMonthsToMonthDate(widget.firstDate, monthPage - 1);
      _currentDisplayedMonthDate =
          DatePickerUtils.addMonthsToMonthDate(widget.firstDate, monthPage);
      _nextMonthDate =
          DatePickerUtils.addMonthsToMonthDate(widget.firstDate, monthPage + 1);
    });
  }
}
