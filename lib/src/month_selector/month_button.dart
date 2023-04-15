import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/src/helpers/controller.dart';

class MonthButton extends StatelessWidget {
  const MonthButton({
    super.key,
    required this.theme,
    required this.localeString,
    required this.onMonthSelected,
    required this.controller,
    required this.date,
  });

  final ThemeData theme;
  final String localeString;
  final ValueChanged<DateTime> onMonthSelected;
  final MonthpickerController controller;
  final DateTime date;

  bool _holdsSelectionPredicate(DateTime mes) {
    if (controller.selectableMonthPredicate != null) {
      return controller.selectableMonthPredicate!(mes);
    } else {
      return true;
    }
  }

  bool _isEnabled(final DateTime mes) {
    if ((controller.localFirstDate == null &&
            (controller.localLastDate == null ||
                (controller.localLastDate != null &&
                    controller.localLastDate!.compareTo(mes) >= 0))) ||
        (controller.localFirstDate != null &&
            ((controller.localLastDate != null &&
                    controller.localFirstDate!.compareTo(mes) <= 0 &&
                    controller.localLastDate!.compareTo(mes) >= 0) ||
                (controller.localLastDate == null &&
                    controller.localFirstDate!.compareTo(mes) <= 0)))) {
      return _holdsSelectionPredicate(mes);
    } else
      return false;
  }

  /// From the provided color settings,
  /// build the month button style with the default layout
  ///
  /// If not provided, the customization will be built from the app's theme.
  ButtonStyle _buildDefaultMonthStyle() {
    final Color backgroundColor =
        controller.selectedMonthBackgroundColor ?? theme.colorScheme.secondary;
    final ButtonStyle monthStyle = TextButton.styleFrom(
      foregroundColor: date.month == controller.selectedDate.month &&
              date.year == controller.selectedDate.year
          ? theme.textTheme.labelLarge!
              .copyWith(
                color: controller.selectedMonthTextColor ??
                    theme.colorScheme.onSecondary,
              )
              .color
          : date.month == DateTime.now().month &&
                  date.year == DateTime.now().year
              ? backgroundColor
              : controller.unselectedMonthTextColor,
      backgroundColor: date.month == controller.selectedDate.month &&
              date.year == controller.selectedDate.year
          ? backgroundColor
          : null,
      shape: const CircleBorder(),
    );
    return monthStyle;
  }

  @override
  Widget build(BuildContext context) {
    final bool isEnabled = _isEnabled(date);
    ButtonStyle monthStyle = _buildDefaultMonthStyle();
    final ButtonStyle? Function(DateTime)? monthPredicate =
        controller.monthStylePredicate;
    if (monthPredicate != null) {
      final value = monthPredicate(date);
      if (value != null) {
        monthStyle = monthStyle.merge(value);
      }
    }

    return TextButton(
      onPressed: isEnabled
          ? () => onMonthSelected(DateTime(date.year, date.month))
          : null,
      style: monthStyle,
      child: Text(
        controller.capitalizeFirstLetter
            ? toBeginningOfSentenceCase(
                DateFormat.MMM(localeString).format(date))!
            : DateFormat.MMM(localeString).format(date).toLowerCase(),
        style: monthStyle.textStyle?.resolve({}),
      ),
    );
  }
}
