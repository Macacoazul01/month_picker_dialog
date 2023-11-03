import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/src/helpers/controller.dart';
import '/src/helpers/locale_utils.dart';
import '/src/helpers/providers.dart';
import '/src/month_picker_widgets/button_bar.dart';
import '/src/month_picker_widgets/pager.dart';
import 'src/month_picker_widgets/header/header.dart';
import 'src/month_selector/month_selector.dart';
import 'src/year_selector/year_selector.dart';

/// Displays month picker dialog.
///
/// [initialDate] is the initially selected month.
///
/// [firstDate] is the optional lower bound for month selection.
///
/// [lastDate] is the optional upper bound for month selection.
///
/// [selectableMonthPredicate] lets you control enabled months just like the official selectableDayPredicate.
///
/// [monthStylePredicate] allows you to individually customize each month.
///
/// [yearStylePredicate] allows you to individually customize each year.
///
/// [capitalizeFirstLetter] lets you control if your months names are capitalized or not.
///
/// [headerColor] lets you control the calendar header color.
///
/// [headerTextColor] lets you control the calendar header text and arrows color.
///
/// [selectedMonthBackgroundColor] lets you control the current selected month/year background color.
///
/// [selectedMonthTextColor] lets you control the text color of the current selected month/year.
///
/// [unselectedMonthTextColor] lets you control the text color of the current unselected months/years.
///
/// [selectedMonthPadding] lets you control the size of the current selected month/year circle by increasing the padding of it (default is 0).
///
/// [confirmWidget] lets you set a custom confirm widget.
///
/// [cancelWidget] lets you set a custom cancel widget.
///
/// [customHeight] lets you set a custom height for the calendar widget (default is 240).
///
/// [customWidth] lets you set a custom width for the calendar widget (default is 320).
///
/// [yearFirst] lets you define that the user must select first the year, then the month.
///
/// [roundedCornersRadius] lets you define the Radius of the rounded dialog (default is 0).
///
/// [dismissible] lets you define if the dialog will be dismissible by clicking outside it.
///
/// [forceSelectedDate] lets you define that the current selected date will be returned if the user clicks outside of the dialog. Needs `dismissible = true`.
///
/// [animationMilliseconds] lets you define the speed of the page transition animation (default is 450).
///
/// [hideHeaderRow] lets you hide the row with the arrows + years/months page range from the header, forcing the user to scroll to change the page (default is false).
///
Future<DateTime?> showMonthPicker({
  required BuildContext context,
  DateTime? initialDate,
  DateTime? firstDate,
  DateTime? lastDate,
  Locale? locale,
  bool Function(DateTime)? selectableMonthPredicate,
  ButtonStyle? Function(DateTime)? monthStylePredicate,
  ButtonStyle? Function(int)? yearStylePredicate,
  bool capitalizeFirstLetter = true,
  Color? headerColor,
  Color? headerTextColor,
  Color? selectedMonthBackgroundColor,
  Color? selectedMonthTextColor,
  Color? unselectedMonthTextColor,
  double selectedMonthPadding = 0,
  Color? backgroundColor,
  Widget? confirmWidget,
  Widget? cancelWidget,
  double? customHeight,
  double? customWidth,
  bool yearFirst = false,
  bool dismissible = false,
  double roundedCornersRadius = 0,
  bool forceSelectedDate = false,
  int animationMilliseconds = 450,
  bool hideHeaderRow = false,
  double? textScaleFactor,
}) async {
  assert(forceSelectedDate == dismissible || !forceSelectedDate,
      'forceSelectedDate can only be used with dismissible = true');
  final ThemeData theme = Theme.of(context);
  final MonthpickerController controller = MonthpickerController(
    initialDate: initialDate,
    firstDate: firstDate,
    lastDate: lastDate,
    locale: locale,
    selectableMonthPredicate: selectableMonthPredicate,
    monthStylePredicate: monthStylePredicate,
    yearStylePredicate: yearStylePredicate,
    capitalizeFirstLetter: capitalizeFirstLetter,
    headerColor: headerColor,
    headerTextColor: headerTextColor,
    selectedMonthBackgroundColor: selectedMonthBackgroundColor,
    selectedMonthTextColor: selectedMonthTextColor,
    unselectedMonthTextColor: unselectedMonthTextColor,
    selectedMonthPadding: selectedMonthPadding,
    backgroundColor: backgroundColor,
    confirmWidget: confirmWidget,
    cancelWidget: cancelWidget,
    customHeight: customHeight,
    customWidth: customWidth,
    yearFirst: yearFirst,
    roundedCornersRadius: roundedCornersRadius,
    forceSelectedDate: forceSelectedDate,
    animationMilliseconds: animationMilliseconds,
    hideHeaderRow: hideHeaderRow,
    theme: theme,
    useMaterial3: theme.useMaterial3,
    textScaleFactor: textScaleFactor
  );
  final DateTime? dialogDate = await showDialog<DateTime>(
    context: context,
    barrierDismissible: dismissible,
    builder: (BuildContext context) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: YearUpDownPageProvider(),
          ),
          ChangeNotifierProvider.value(
            value: MonthUpDownPageProvider(),
          ),
        ],
        child: _MonthPickerDialog(controller: controller),
      );
    },
  );
  if (dismissible && forceSelectedDate && dialogDate == null) {
    return controller.selectedDate;
  }
  return dialogDate;
}

class _MonthPickerDialog extends StatefulWidget {
  const _MonthPickerDialog({required this.controller});
  final MonthpickerController controller;
  @override
  _MonthPickerDialogState createState() => _MonthPickerDialogState();
}

class _MonthPickerDialogState extends State<_MonthPickerDialog> {
  late Widget _selector;

  @override
  void initState() {
    super.initState();
    widget.controller.initialize();
    _selector = widget.controller.yearFirst
        ? YearSelector(
            key: widget.controller.yearSelectorState,
            onYearSelected: _onYearSelected,
            controller: widget.controller,
          )
        : MonthSelector(
            key: widget.controller.monthSelectorState,
            onMonthSelected: _onMonthSelected,
            controller: widget.controller,
          );
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String locale =
        getLocale(context, selectedLocale: widget.controller.locale);
    final bool portrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final Container content = Container(
      decoration: BoxDecoration(
        color: widget.controller.backgroundColor ??
            widget.controller.theme.dialogBackgroundColor,
        borderRadius: portrait
            ? BorderRadius.only(
                bottomLeft:
                    Radius.circular(widget.controller.roundedCornersRadius),
                bottomRight:
                    Radius.circular(widget.controller.roundedCornersRadius),
              )
            : BorderRadius.only(
                topRight:
                    Radius.circular(widget.controller.roundedCornersRadius),
                bottomRight:
                    Radius.circular(widget.controller.roundedCornersRadius),
              ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          PickerPager(
            selector: _selector,
            theme: widget.controller.theme,
            controller: widget.controller,
          ),
          PickerButtonBar(
            controller: widget.controller,
          ),
        ],
      ),
    );

    final PickerHeader header = PickerHeader(
      theme: widget.controller.theme,
      localeString: locale,
      isMonthSelector: _selector is MonthSelector,
      onSelectYear: _onSelectYear,
      portrait: portrait,
      controller: widget.controller,
    );

    return Theme(
      data: widget.controller.theme
          .copyWith(dialogBackgroundColor: Colors.transparent),
      child: Dialog(
        child: Builder(
          builder: (BuildContext context) {
            if (portrait) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[header, content],
              );
            }
            return IntrinsicHeight(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[header, content],
              ),
            );
          },
        ),
      ),
    );
  }

  void _onSelectYear() => setState(
        () => _selector = YearSelector(
          key: widget.controller.yearSelectorState,
          onYearSelected: _onYearSelected,
          controller: widget.controller,
        ),
      );

  void _onYearSelected(final int year) {
    setState(
      () {
        widget.controller.firstPossibleMonth(year);
        _selector = MonthSelector(
          key: widget.controller.monthSelectorState,
          onMonthSelected: _onMonthSelected,
          controller: widget.controller,
        );
      },
    );
  }

  void _onMonthSelected(final DateTime date) => setState(
        () {
          widget.controller.selectedDate = date;
          _selector = MonthSelector(
            key: widget.controller.monthSelectorState,
            onMonthSelected: _onMonthSelected,
            controller: widget.controller,
          );
        },
      );
}
