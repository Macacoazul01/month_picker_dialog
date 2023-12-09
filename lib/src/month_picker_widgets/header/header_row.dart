import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '/src/helpers/controller.dart';
import '/src/helpers/providers.dart';
import '/src/month_picker_widgets/header/header_arrows.dart';

class HeaderRow extends StatelessWidget {
  const HeaderRow({
    super.key,
    required this.theme,
    required this.localeString,
    required this.isMonthSelector,
    required this.onSelectYear,
    required this.controller,
  });
  final ThemeData theme;
  final String localeString;
  final bool isMonthSelector;
  final VoidCallback onSelectYear;
  final MonthpickerController controller;

  @override
  Widget build(BuildContext context) {
    final TextStyle? headline5 = controller.headerTextColor == null
        ? theme.primaryTextTheme.headlineSmall
        : theme.primaryTextTheme.headlineSmall!
            .copyWith(color: controller.headerTextColor);
    final Color? arrowcolors =
        controller.headerTextColor ?? theme.primaryIconTheme.color;

    final TextScaler? scaler = controller.textScaleFactor != null
        ? TextScaler.linear(controller.textScaleFactor!)
        : null;

    final YearUpDownPageProvider yearProvider =
        Provider.of<YearUpDownPageProvider>(context);
    final MonthUpDownPageProvider monthProvider =
        Provider.of<MonthUpDownPageProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        if (isMonthSelector) ...<Widget>[
          GestureDetector(
            onTap: onSelectYear,
            child: Text(
              DateFormat.y(localeString)
                  .format(DateTime(monthProvider.pageLimit.upLimit)),
              style: headline5,
              textScaler: scaler,
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
                textScaler: scaler,
              ),
              Text(
                '-',
                style: headline5,
                textScaler: scaler,
              ),
              Text(
                DateFormat.y(localeString)
                    .format(DateTime(yearProvider.pageLimit.downLimit)),
                style: headline5,
                textScaler: scaler,
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
    );
  }
}
