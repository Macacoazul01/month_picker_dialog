import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/month_picker_dialog.dart';

///The button to be used on the grid of months.
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
    Color? backgroundColor;
    Color? foregroundColor = controller.unselectedMonthTextColor;

    if (date.month == controller.selectedDate.month &&
        date.year == controller.selectedDate.year) {
      backgroundColor = controller.selectedMonthBackgroundColor ??
          theme.colorScheme.secondary;
      foregroundColor = theme.textTheme.labelLarge!
          .copyWith(
            color: controller.selectedMonthTextColor ??
                theme.colorScheme.onSecondary,
          )
          .color;
    }

    if (controller.rangeMode) {
      if (controller.firstRangeDate != null) {
        if (date.month == controller.firstRangeDate!.month &&
            date.year == controller.firstRangeDate!.year &&
            date.month != controller.selectedDate.month) {
          backgroundColor = controller.selectedMonthBackgroundColor ??
              theme.colorScheme.secondary;
          foregroundColor = theme.textTheme.labelLarge!
              .copyWith(
                color: controller.selectedMonthTextColor ??
                    theme.colorScheme.onSecondary,
              )
              .color;
        }
      }
    }

    if (controller.rangeMode) {
      if (controller.firstRangeDate != null &&
          controller.secondRangeDate != null) {
        if (date.isAfter(controller.firstRangeDate!) &&
            date.isBefore(controller.secondRangeDate!)) {
          backgroundColor = HSLColor.fromColor(
                  controller.selectedMonthBackgroundColor ??
                      theme.colorScheme.secondary)
              .withLightness(.7)
              .toColor();
          foregroundColor = theme.textTheme.labelLarge!
              .copyWith(
                color: controller.selectedMonthTextColor ??
                    theme.colorScheme.onSecondary,
              )
              .color;
        }
      }
    }

    if (date.month == DateTime.now().month &&
        date.year == DateTime.now().year &&
        date.month != controller.selectedDate.month) {
      foregroundColor = controller.currentMonthTextColor ?? backgroundColor;
    }

    final ButtonStyle monthStyle = TextButton.styleFrom(
      foregroundColor: foregroundColor,
      backgroundColor: backgroundColor,
      shape: controller.buttonBorder,
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
      final ButtonStyle? value = monthPredicate(date);
      if (value != null) {
        monthStyle = monthStyle.merge(value);
      }
    }

    return Padding(
      padding: EdgeInsets.all(controller.selectedMonthPadding),
      child: TextButton(
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
          textScaler: controller.textScaleFactor != null
              ? TextScaler.linear(controller.textScaleFactor!)
              : null,
        ),
      ),
    );
  }
}
