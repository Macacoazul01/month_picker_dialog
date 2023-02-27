import 'package:flutter/widgets.dart';
import '/src/helpers/common.dart';
import '/src/helpers/extensions.dart';
import '/src/month_selector/month_selector.dart';
import '/src/year_selector/year_selector.dart';
import 'package:rxdart/rxdart.dart';

class MonthpickerController {
  MonthpickerController({
    required this.initialDate,
    this.firstDate,
    this.lastDate,
    this.locale,
    this.selectableMonthPredicate,
    required this.capitalizeFirstLetter,
    this.headerColor,
    this.headerTextColor,
    this.selectedMonthBackgroundColor,
    this.selectedMonthTextColor,
    this.unselectedMonthTextColor,
    this.confirmText,
    this.cancelText,
    this.customHeight,
    this.customWidth,
    required this.yearFirst,
    required this.roundedCornersRadius,
  });

  //User defined variables
  final DateTime? firstDate, lastDate, initialDate;
  final Locale? locale;
  final bool Function(DateTime)? selectableMonthPredicate;
  final bool capitalizeFirstLetter, yearFirst;
  final Color? headerColor,
      headerTextColor,
      selectedMonthBackgroundColor,
      selectedMonthTextColor,
      unselectedMonthTextColor;
  final Text? confirmText, cancelText;
  final double? customHeight, customWidth;
  final double roundedCornersRadius;

  //local variables
  final GlobalKey<YearSelectorState> yearSelectorState = GlobalKey();
  final GlobalKey<MonthSelectorState> monthSelectorState = GlobalKey();

  final PublishSubject<UpDownPageLimit> upDownPageLimitPublishSubject =
      PublishSubject();
  final PublishSubject<UpDownButtonEnableState>
      upDownButtonEnableStatePublishSubject = PublishSubject();

  DateTime selectedDate = DateTime.now().firstDayOfMonth();
  DateTime? localFirstDate, localLastDate;

  void initialize() {
    if (initialDate != null) {
      selectedDate = initialDate!.firstDayOfMonth();
    }
    if (firstDate != null)
      localFirstDate = DateTime(firstDate!.year, firstDate!.month);
    if (lastDate != null)
      localLastDate = DateTime(lastDate!.year, lastDate!.month);
  }

  void dispose() {
    upDownPageLimitPublishSubject.close();
    upDownButtonEnableStatePublishSubject.close();
  }
}
