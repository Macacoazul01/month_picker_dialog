import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/src/helpers/controller.dart';
import '/src/helpers/common.dart';

class PickerHeader extends StatelessWidget {
  const PickerHeader({
    super.key,
    required this.theme,
    required this.localeString,
    required this.isMonthSelector,
    required this.onDownButtonPressed,
    required this.onSelectYear,
    required this.onUpButtonPressed,
    required this.portrait,
    required this.controller,
  });
  final ThemeData theme;
  final String localeString;
  final bool isMonthSelector;
  final VoidCallback onSelectYear, onUpButtonPressed, onDownButtonPressed;
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
                if (isMonthSelector)
                  GestureDetector(
                    onTap: onSelectYear,
                    child: StreamBuilder<UpDownPageLimit>(
                      stream: controller.upDownPageLimitPublishSubject,
                      initialData: const UpDownPageLimit(0, 0),
                      builder: (_, AsyncSnapshot<UpDownPageLimit> snapshot) =>
                          Text(
                        DateFormat.y(localeString)
                            .format(DateTime(snapshot.data!.upLimit)),
                        style: headline5,
                      ),
                    ),
                  )
                else
                  StreamBuilder<UpDownPageLimit>(
                    stream: controller.upDownPageLimitPublishSubject,
                    initialData: const UpDownPageLimit(0, 0),
                    builder: (_, AsyncSnapshot<UpDownPageLimit> snapshot) =>
                        Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          DateFormat.y(localeString)
                              .format(DateTime(snapshot.data!.upLimit)),
                          style: headline5,
                        ),
                        Text(
                          '-',
                          style: headline5,
                        ),
                        Text(
                          DateFormat.y(localeString)
                              .format(DateTime(snapshot.data!.downLimit)),
                          style: headline5,
                        ),
                      ],
                    ),
                  ),
                StreamBuilder<UpDownButtonEnableState>(
                  stream: controller.upDownButtonEnableStatePublishSubject,
                  initialData: const UpDownButtonEnableState(true, true),
                  builder:
                      (_, AsyncSnapshot<UpDownButtonEnableState> snapshot) =>
                          Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.keyboard_arrow_up,
                          color: snapshot.data!.upState
                              ? arrowcolors
                              : arrowcolors!.withOpacity(0.5),
                        ),
                        onPressed:
                            snapshot.data!.upState ? onUpButtonPressed : null,
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: snapshot.data!.downState
                              ? arrowcolors
                              : arrowcolors!.withOpacity(0.5),
                        ),
                        onPressed: snapshot.data!.downState
                            ? onDownButtonPressed
                            : null,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
