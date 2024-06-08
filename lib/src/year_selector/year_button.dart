import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/month_picker_dialog.dart';

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
    if (localFirstDate == null && localLastDate == null)
      return true;
    else if (localFirstDate != null &&
        localLastDate != null &&
        year >= localFirstDate.year &&
        year <= localLastDate.year)
      return true;
    else if (localFirstDate != null &&
        localLastDate == null &&
        year >= localFirstDate.year)
      return true;
    else if (localFirstDate == null &&
        localLastDate != null &&
        year <= localLastDate.year)
      return true;
    else
      return false;
  }

  /// From the provided color settings,
  /// build the year button style with the default layout
  ///
  /// If not provided, the customization will be built from the app's theme.
  ButtonStyle _buildDefaultYearStyle(int year) {
    final Color backgroundColor =
        controller.selectedMonthBackgroundColor ?? theme.colorScheme.secondary;
    final ButtonStyle yearStyle = TextButton.styleFrom(
      foregroundColor: year == controller.selectedDate.year
          ? theme.textTheme.labelLarge!
              .copyWith(
                color: controller.selectedMonthTextColor ??
                    theme.colorScheme.onSecondary,
              )
              .color
          : year == controller.now.year
              ? (controller.currentMonthTextColor ?? backgroundColor)
              : controller.unselectedMonthTextColor,
      backgroundColor:
          year == controller.selectedDate.year ? backgroundColor : null,
      shape: controller.buttonBorder,
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
      padding: EdgeInsets.all(controller.selectedMonthPadding),
      child: TextButton(
        onPressed: isEnabled ? () => onYearSelected(year) : null,
        style: yearStyle,
        child: Text(
          DateFormat.y(localeString).format(DateTime(year)),
          style: yearStyle.textStyle?.resolve({}),
          textScaler: controller.textScaleFactor != null
              ? TextScaler.linear(controller.textScaleFactor!)
              : null,
        ),
      ),
    );
  }
}
