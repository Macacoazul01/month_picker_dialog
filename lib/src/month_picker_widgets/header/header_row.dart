import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '/month_picker_dialog.dart';

///The main part of the header. Where arrows and current interval are presented.
class HeaderRow extends StatelessWidget {
  const HeaderRow({
    super.key,
    required this.theme,
    required this.localeString,
    required this.isMonthSelector,
    required this.onSelectYear,
    required this.controller,
    required this.portrait,
  });

  final ThemeData theme;
  final String localeString;
  final bool isMonthSelector, portrait;
  final VoidCallback onSelectYear;
  final MonthpickerController controller;

  @override
  Widget build(BuildContext context) {
    final TextStyle? headline5 = controller.monthPickerDialogSettings.headerSettings.headerCurrentPageTextStyle ?? theme.primaryTextTheme.headlineSmall;
    final Color? arrowcolors = controller.monthPickerDialogSettings.headerSettings.headerIconsColor ??
        (controller.monthPickerDialogSettings.headerSettings.headerCurrentPageTextStyle?.color ?? theme.primaryIconTheme.color);


    final YearUpDownPageProvider yearProvider = Provider.of<YearUpDownPageProvider>(context);
    final MonthUpDownPageProvider monthProvider = Provider.of<MonthUpDownPageProvider>(context);
    final List<Widget> mainWidgets = isMonthSelector
        ? <Widget>[
            if (!controller.monthPickerDialogSettings.headerSettings.hideHeaderArrows)
              HeaderArrows(
                arrowcolors: arrowcolors,
                onUpButtonPressed: controller.onUpButtonPressed,
                onDownButtonPressed: controller.onDownButtonPressed,
                downState: monthProvider.enableState.downState,
                upState: monthProvider.enableState.upState,
                arrowSize: controller.monthPickerDialogSettings.headerSettings.headerIconsSize,
                previousIcon: controller.monthPickerDialogSettings.headerSettings.previousIcon,
                nextIcon: controller.monthPickerDialogSettings.headerSettings.nextIcon,
              ),
            ElevatedButton(
              onPressed: () {
                controller.onResetPressed();
              },
              child: Text(
                controller.textToday ?? "Today",
                style: headline5,
              ),
            ),
          ]
        : <Widget>[

            if (!controller.monthPickerDialogSettings.headerSettings.hideHeaderArrows)
              HeaderArrows(
                arrowcolors: arrowcolors,
                onUpButtonPressed: controller.onUpButtonPressed,
                onDownButtonPressed: controller.onDownButtonPressed,
                downState: yearProvider.enableState.downState,
                upState: yearProvider.enableState.upState,
                arrowSize: controller.monthPickerDialogSettings.headerSettings.headerIconsSize,
                previousIcon: controller.monthPickerDialogSettings.headerSettings.previousIcon,
                nextIcon: controller.monthPickerDialogSettings.headerSettings.nextIcon,
              ),
            ElevatedButton(
              onPressed: () {
                controller.onResetPressed();
              },
              child: Text(
                controller.textToday ?? "Today",
                style: headline5,
              ),
            ),
          ];
    return portrait
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: mainWidgets,
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: mainWidgets,
          );
  }
}
