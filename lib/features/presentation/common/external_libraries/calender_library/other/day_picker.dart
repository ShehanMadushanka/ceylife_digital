import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ceylife_digital/features/presentation/common/external_libraries/calender_library/other/date_picker_keys.dart';
import 'package:ceylife_digital/features/presentation/common/external_libraries/calender_library/other/date_picker_styles.dart';
import 'package:ceylife_digital/features/presentation/common/external_libraries/calender_library/other/day_based_changable_picker.dart';
import 'package:ceylife_digital/features/presentation/common/external_libraries/calender_library/other/event_decoration.dart';
import 'package:ceylife_digital/features/presentation/common/external_libraries/calender_library/other/i_selectable_picker.dart';
import 'package:ceylife_digital/features/presentation/common/external_libraries/calender_library/other/layout_settings.dart';
import 'package:ceylife_digital/features/presentation/common/external_libraries/calender_library/flutter_date_pickers.dart';


// Styles for current displayed period (month) title: Theme.of(context).textTheme.subhead
//
// Styles for date picker cell:
// current date: Theme.of(context).textTheme.body2.copyWith(color: themeData.accentColor)
// if date disabled: Theme.of(context).textTheme.body1.copyWith(color: themeData.disabledColor)
// if date selected:
//  text - Theme.of(context).accentTextTheme.body2
//  for box decoration - color is Theme.of(context).accentColor and box shape is circle

// selectedDate must be between firstDate and lastDate

/// Date picker for selection one day.
class DayPicker extends StatelessWidget {
  /// Creates a day picker.
  DayPicker(
      {Key key,
      @required this.selectedDate,
      @required this.onChanged,
      @required this.firstDate,
      @required this.lastDate,
      this.datePickerLayoutSettings = const DatePickerLayoutSettings(),
      this.datePickerStyles = const DatePickerRangeStyles(),
      this.datePickerKeys,
      this.selectableDayPredicate,
      this.eventDecorationBuilder})
      : assert(selectedDate != null),
        assert(onChanged != null),
        assert(!firstDate.isAfter(lastDate)),
        assert(!lastDate.isBefore(firstDate)),
        //assert(!selectedDate.isBefore(firstDate)),
        assert(!selectedDate.isAfter(lastDate)),
        super(key: key);

  /// The currently selected date.
  ///
  /// This date is highlighted in the picker.
  final DateTime selectedDate;

  /// Called when the user picks a day.
  final ValueChanged<DateTime> onChanged;

  /// The earliest date the user is permitted to pick.
  final DateTime firstDate;

  /// The latest date the user is permitted to pick.
  final DateTime lastDate;

  /// Layout settings what can be customized by user
  final DatePickerLayoutSettings datePickerLayoutSettings;

  /// Styles what can be customized by user
  final DatePickerStyles datePickerStyles;

  /// Some keys useful for integration tests
  final DatePickerKeys datePickerKeys;

  /// Function returns if day can be selected or not.
  final SelectableDayPredicate selectableDayPredicate;

  /// Builder to get event decoration for each date.
  ///
  /// All event styles are overriden by selected styles
  /// except days with dayType is [DayType.notSelected].
  final EventDecorationBuilder eventDecorationBuilder;

  @override
  Widget build(BuildContext context){
    ISelectablePicker<DateTime> daySelectablePicker = DaySelectable(
      selectedDate,
      firstDate,
      lastDate,
      selectableDayPredicate: selectableDayPredicate
    );

    return DayBasedChangeablePicker<DateTime>(
      selectablePicker: daySelectablePicker,
      selectedDate: selectedDate,
      firstDate: firstDate,
      lastDate: lastDate,
      onChanged: onChanged,
      datePickerLayoutSettings: datePickerLayoutSettings,
      datePickerStyles: datePickerStyles,
      datePickerKeys: datePickerKeys,
      eventDecorationBuilder: eventDecorationBuilder,
    );
  }
}