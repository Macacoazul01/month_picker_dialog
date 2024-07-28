import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '/month_picker_dialog.dart';
//TODO fix
///The button to be used on the grid of years.
class YearButton extends StatelessWidget {
  const YearButton({
    super.key,
    required this.theme,
    required this.controller,
    required this.page,
    required this.index,
    required this.onYearSelected,
    required this.localeString,
  });

  final ThemeData theme;
  final MonthpickerController controller;
  final int page, index;
  final ValueChanged<int> onYearSelected;
  final String localeString;

  bool _isEnabled(final int year) {
    final DateTime? localFirstDate = controller.localFirstDate;
    final DateTime? localLastDate = controller.localLastDate;
    if (localFirstDate == null && localLastDate == null) {
      return true;
    }
    if (localFirstDate != null) {
      if (localLastDate != null) {
        return year >= localFirstDate.year && year <= localLastDate.year;
      } else {
        return year >= localFirstDate.year;
      }
    }
    if (localLastDate != null) {
      return year <= localLastDate.year;
    }

    return false;
  }

  /// From the provided color settings,
  /// build the year button style with the default layout
  ///
  /// If not provided, the customization will be built from the app's theme.
  ButtonStyle _buildDefaultYearStyle(int year) {
    final bool isTheSelectedYear = year == controller.selectedDate.year;
    final Color backgroundColor = controller.monthPickerDialogSettings
            .buttonsSettings.selectedMonthBackgroundColor ??
        theme.colorScheme.secondary;
    final ButtonStyle yearStyle = TextButton.styleFrom(
      foregroundColor: isTheSelectedYear
          ? theme.textTheme.labelLarge!
              .copyWith(
                color: controller.monthPickerDialogSettings.buttonsSettings
                        .selectedMonthTextColor ??
                    theme.colorScheme.onSecondary,
              )
              .color
          : year == controller.now.year
              ? (controller.monthPickerDialogSettings.buttonsSettings
                      .currentMonthTextColor ??
                  backgroundColor)
              : controller.monthPickerDialogSettings.buttonsSettings
                  .unselectedMonthsTextColor,
      backgroundColor:
          isTheSelectedYear ? backgroundColor : null,
      shape: controller.monthPickerDialogSettings.buttonsSettings.buttonBorder,
    );
    return yearStyle;
  }

  @override
  Widget build(BuildContext context) {
    final int year = (controller.localFirstDate == null
            ? 0
            : controller.localFirstDate!.year) +
        page * 12 +
        index;
    final bool isEnabled = _isEnabled(year);
    ButtonStyle yearStyle = _buildDefaultYearStyle(year);
    final ButtonStyle? Function(int)? yearPredicate =
        controller.yearStylePredicate;
    if (yearPredicate != null) {
      final ButtonStyle? value = yearPredicate(year);
      if (value != null) {
        yearStyle = yearStyle.merge(value);
      }
    }

    return Padding(
      padding: EdgeInsets.all(controller
          .monthPickerDialogSettings.buttonsSettings.selectedDatePadding),
      child: TextButton(
        onPressed: isEnabled ? () => onYearSelected(year) : null,
        style: yearStyle,
        child: Text(
          DateFormat.y(localeString).format(DateTime(year)),
          style: yearStyle.textStyle?.resolve({}),
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
