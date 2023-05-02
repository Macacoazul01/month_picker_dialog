import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/src/month_picker_widgets/header/header_row.dart';

import '/src/helpers/controller.dart';

class PickerHeader extends StatelessWidget {
  const PickerHeader({
    super.key,
    required this.theme,
    required this.localeString,
    required this.isMonthSelector,
    required this.onSelectYear,
    required this.portrait,
    required this.controller,
  });
  final ThemeData theme;
  final String localeString;
  final bool isMonthSelector, portrait;
  final VoidCallback onSelectYear;
  final MonthpickerController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: controller.headerColor ?? theme.primaryColor,
        borderRadius: portrait
            ? BorderRadius.only(
                topLeft: Radius.circular(controller.roundedCornersRadius),
                topRight: Radius.circular(controller.roundedCornersRadius),
              )
            : BorderRadius.only(
                topLeft: Radius.circular(controller.roundedCornersRadius),
                bottomLeft: Radius.circular(controller.roundedCornersRadius),
              ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              controller.capitalizeFirstLetter
                  ? '${toBeginningOfSentenceCase(DateFormat.yMMM(localeString).format(controller.selectedDate))}'
                  : DateFormat.yMMM(localeString)
                      .format(controller.selectedDate)
                      .toLowerCase(),
              style: controller.headerTextColor == null
                  ? theme.primaryTextTheme.titleMedium
                  : theme.primaryTextTheme.titleMedium!
                      .copyWith(color: controller.headerTextColor),
            ),
            HeaderRow(
              theme: theme,
              localeString: localeString,
              isMonthSelector: isMonthSelector,
              onSelectYear: onSelectYear,
              controller: controller,
            ),
          ],
        ),
      ),
    );
  }
}
