import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '/src/helpers/controller.dart';
import '/src/helpers/providers.dart';
import '/src/month_picker_widgets/header/header_arrows.dart';

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
  final bool isMonthSelector;
  final VoidCallback onSelectYear;
  final bool portrait;
  final MonthpickerController controller;

  @override
  Widget build(BuildContext context) {
    final TextStyle? headline5 = controller.headerTextColor == null
        ? theme.primaryTextTheme.headlineSmall
        : theme.primaryTextTheme.headlineSmall!
            .copyWith(color: controller.headerTextColor);
    final Color? arrowcolors =
        controller.headerTextColor ?? theme.primaryIconTheme.color;

    final YearUpDownPageProvider yearProvider =
        Provider.of<YearUpDownPageProvider>(context);
    final MonthUpDownPageProvider monthProvider =
        Provider.of<MonthUpDownPageProvider>(context);

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                if (isMonthSelector) ...<Widget>[
                  GestureDetector(
                    onTap: onSelectYear,
                    child: Text(
                      DateFormat.y(localeString)
                          .format(DateTime(monthProvider.pageLimit.upLimit)),
                      style: headline5,
                    ),
                  ),
                  HeaderArrows(
                    arrowcolors: arrowcolors,
                    onUpButtonPressed: controller.onUpButtonPressed,
                    onDownButtonPressed: controller.onDownButtonPressed,
                    downState: monthProvider.enableState.downState,
                    upState: monthProvider.enableState.upState,
                  ),
                ] else ...<Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        DateFormat.y(localeString)
                            .format(DateTime(yearProvider.pageLimit.upLimit)),
                        style: headline5,
                      ),
                      Text(
                        '-',
                        style: headline5,
                      ),
                      Text(
                        DateFormat.y(localeString)
                            .format(DateTime(yearProvider.pageLimit.downLimit)),
                        style: headline5,
                      ),
                    ],
                  ),
                  HeaderArrows(
                    arrowcolors: arrowcolors,
                    onUpButtonPressed: controller.onUpButtonPressed,
                    onDownButtonPressed: controller.onDownButtonPressed,
                    downState: yearProvider.enableState.downState,
                    upState: yearProvider.enableState.upState,
                  ),
                ]
              ],
            ),
          ],
        ),
      ),
    );
  }
}
