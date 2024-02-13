import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/month_picker_dialog.dart';

class HeaderSelectedDate extends StatelessWidget {
  const HeaderSelectedDate({
    super.key,
    required this.theme,
    required this.localeString,
    required this.controller,
  });
  final ThemeData theme;
  final String localeString;
  final MonthpickerController controller;

  @override
  Widget build(BuildContext context) {
    return Text(
      controller.capitalizeFirstLetter
          ? '${toBeginningOfSentenceCase(DateFormat.yMMM(localeString).format(controller.selectedDate))}'
          : DateFormat.yMMM(localeString)
              .format(controller.selectedDate)
              .toLowerCase(),
      textScaler: controller.textScaleFactor != null
          ? TextScaler.linear(controller.textScaleFactor!)
          : null,
      style: controller.headerTextColor == null
          ? theme.primaryTextTheme.titleMedium
          : theme.primaryTextTheme.titleMedium!
              .copyWith(color: controller.headerTextColor),
    );
  }
}
