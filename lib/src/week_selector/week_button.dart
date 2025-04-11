import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../helpers/time.dart';
import '/month_picker_dialog.dart';

///The button to be used on the grid of years.
class WeekButton extends StatelessWidget {
  const WeekButton({
    super.key,
    required this.theme,
    required this.controller,
    required this.index,
    required this.onWeekSelected,
    required this.localeString,
    required this.selectWeek,
  });

  final ThemeData theme;
  final MonthpickerController controller;
  final int  index;
  final ValueChanged<Time> onWeekSelected;
  final String localeString;
  final int? selectWeek;

  bool _holdsSelectionPredicate(int year) {
    if (controller.selectableYearPredicate != null) {
      return controller.selectableYearPredicate!(year);
    } else {
      return true;
    }
  }

  bool _isEnabled(final int year) {
    final DateTime? localFirstDate = controller.localFirstDate;
    final DateTime? localLastDate = controller.localLastDate;
    if (localFirstDate == null && localLastDate == null) {
      return true;
    }
    if (localFirstDate != null) {
      if (localLastDate != null) {
        return year >= localFirstDate.year &&
            year <= localLastDate.year &&
            _holdsSelectionPredicate(year);
      } else {
        return year >= localFirstDate.year && _holdsSelectionPredicate(year);
      }
    }
    if (localLastDate != null) {
      return year <= localLastDate.year && _holdsSelectionPredicate(year);
    }

    return false;
  }

  /// From the provided color settings,
  /// build the year button style with the default layout
  ///
  /// If not provided, the customization will be built from the app's theme.
  ButtonStyle _buildDefaultYearStyle(int year,) {
    final bool isTheSelectedYear = year == selectWeek ;
    final Color backgroundColor = controller.monthPickerDialogSettings
        .dateButtonsSettings.selectedMonthBackgroundColor ??
        theme.colorScheme.secondary;
    final ButtonStyle yearStyle = TextButton.styleFrom(
      textStyle: controller
          .monthPickerDialogSettings.dateButtonsSettings.yearTextStyle,
      foregroundColor: isTheSelectedYear
          ? theme.textTheme.labelLarge!
          .copyWith(
        color: controller.monthPickerDialogSettings.dateButtonsSettings
            .selectedYearTextColor ??
            theme.colorScheme.onSecondary,
      )
          .color
          : year == controller.now.year
          ? (controller.monthPickerDialogSettings.dateButtonsSettings
          .currentYearTextColor ??
          backgroundColor)
          : controller.monthPickerDialogSettings.dateButtonsSettings
          .unselectedYearsTextColor,
      backgroundColor: isTheSelectedYear ? backgroundColor : null,
      shape:
      controller.monthPickerDialogSettings.dateButtonsSettings.buttonBorder,
    );
    return yearStyle;
  }

  @override
  Widget build(BuildContext context) {
    final int week = index + 1;
    int year = Provider.of<YearUpDownPageProvider>(context).pageLimit.upLimit;
    final bool isEnabled = _isEnabled(week);
    ButtonStyle yearStyle = _buildDefaultYearStyle(week);
    final ButtonStyle? Function(int)? yearPredicate =
        controller.yearStylePredicate;
    if (yearPredicate != null) {
      final ButtonStyle? value = yearPredicate(week);
      if (value != null) {
        yearStyle = yearStyle.merge(value);
      }
    }

    return Padding(
      padding: EdgeInsets.all(controller
          .monthPickerDialogSettings.dateButtonsSettings.selectedDateRadius),
      child: TextButton(
        onPressed:  () => onWeekSelected(Time(time: week,year:  year)),
        style: yearStyle,
        child: Text(week.toString(),
          textScaler: controller.monthPickerDialogSettings.dialogSettings
              .textScaleFactor !=
              null
              ? TextScaler.linear(controller
              .monthPickerDialogSettings.dialogSettings.textScaleFactor!)
              : null,
        ),
      ),
    );
  }
}
