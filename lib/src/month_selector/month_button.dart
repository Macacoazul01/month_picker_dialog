import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MonthButton extends StatelessWidget {
  const MonthButton({
    super.key,
    required this.openDate,
    required this.selectedDate,
    this.firstDate,
    this.lastDate,
    required this.date,
    required this.theme,
    required this.locale,
    this.selectableMonthPredicate,
    required this.capitalizeFirstLetter,
    required this.selectedMonthBackgroundColor,
    required this.selectedMonthTextColor,
    required this.unselectedMonthTextColor,
    required this.onMonthSelected,
  });

  final ThemeData theme;
  final String locale;
  final ValueChanged<DateTime> onMonthSelected;
  final DateTime? firstDate, lastDate;
  final DateTime selectedDate, openDate, date;
  final bool Function(DateTime)? selectableMonthPredicate;
  final bool capitalizeFirstLetter;
  final Color? selectedMonthBackgroundColor,
      selectedMonthTextColor,
      unselectedMonthTextColor;

  bool _holdsSelectionPredicate(DateTime date) {
    if (selectableMonthPredicate != null) {
      return selectableMonthPredicate!(date);
    } else {
      return true;
    }
  }

  bool _isEnabled(final DateTime date) {
    if ((firstDate == null &&
            (lastDate == null ||
                (lastDate != null && lastDate!.compareTo(date) >= 0))) ||
        (firstDate != null &&
            ((lastDate != null &&
                    firstDate!.compareTo(date) <= 0 &&
                    lastDate!.compareTo(date) >= 0) ||
                (lastDate == null && firstDate!.compareTo(date) <= 0)))) {
      return _holdsSelectionPredicate(date);
    } else
      return false;
  }

  @override
  Widget build(BuildContext context) {
    final bool isEnabled = _isEnabled(date);
    final Color backgroundColor =
        selectedMonthBackgroundColor ?? theme.colorScheme.secondary;
    return TextButton(
      onPressed: isEnabled
          ? () => onMonthSelected(DateTime(date.year, date.month))
          : null,
      style: TextButton.styleFrom(
        foregroundColor: date.month == selectedDate.month &&
                date.year == selectedDate.year
            ? theme.textTheme.labelLarge!
                .copyWith(
                  color:
                      selectedMonthTextColor ?? theme.colorScheme.onSecondary,
                )
                .color
            : date.month == DateTime.now().month &&
                    date.year == DateTime.now().year
                ? backgroundColor
                : unselectedMonthTextColor, backgroundColor:
            date.month == selectedDate.month && date.year == selectedDate.year
                ? backgroundColor
                : null,
        shape: const CircleBorder(),
      ),
      child: Text(
        capitalizeFirstLetter
            ? toBeginningOfSentenceCase(DateFormat.MMM(locale).format(date))!
            : DateFormat.MMM(locale).format(date).toLowerCase(),
      ),
    );
  }
}
