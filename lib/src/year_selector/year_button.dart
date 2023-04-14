import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/src/helpers/controller.dart';

class YearButton extends StatelessWidget {
  const YearButton({
    super.key,
    required this.controller,
    required this.page,
    required this.index,
    required this.onYearSelected,
    required this.localeString,
  });
  final MonthpickerController controller;
  final int page;
  final int index;
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

  @override
  Widget build(BuildContext context) {
    final int year = (controller.localFirstDate == null
            ? 0
            : controller.localFirstDate!.year) +
        page * 12 +
        index;
    final bool isEnabled = _isEnabled(year);
    final ThemeData theme = Theme.of(context);
    final Color backgroundColor =
        controller.selectedMonthBackgroundColor ?? theme.colorScheme.secondary;
    ButtonStyle yearStyle = TextButton.styleFrom(
      foregroundColor: year == controller.selectedDate.year
          ? theme.textTheme.labelLarge!
              .copyWith(
                color: controller.selectedMonthTextColor ??
                    theme.colorScheme.onSecondary,
              )
              .color
          : year == DateTime.now().year
              ? backgroundColor
              : controller.unselectedMonthTextColor,
      backgroundColor:
          year == controller.selectedDate.year ? backgroundColor : null,
      shape: const CircleBorder(),
    );

    if (controller.yearStylePredicate != null) {
      yearStyle = yearStyle.merge(controller.yearStylePredicate!(year));
    }

    return TextButton(
      onPressed: isEnabled ? () => onYearSelected(year) : null,
      style: yearStyle,
      child: Text(
        DateFormat.y(localeString).format(DateTime(year)),
      ),
    );
  }
}
