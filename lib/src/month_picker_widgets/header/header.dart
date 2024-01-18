import 'package:flutter/material.dart';

import '/src/helpers/controller.dart';
import '/src/month_picker_widgets/header/header_row.dart';
import '/src/month_picker_widgets/header/header_selected_date.dart';

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
      width: portrait ? controller.customWidth : null,
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
        child: controller.hideHeaderRow
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  HeaderSelectedDate(
                    theme: theme,
                    localeString: localeString,
                    controller: controller,
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  HeaderSelectedDate(
                    theme: theme,
                    localeString: localeString,
                    controller: controller,
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
