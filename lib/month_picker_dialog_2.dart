import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '/src/helpers/common.dart';
import '/src/helpers/locale_utils.dart';
import '/src/month_picker_widgets/button_bar.dart';
import '/src/month_picker_widgets/header.dart';
import '/src/month_picker_widgets/pager.dart';
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
/// [confirmText] lets you set a custom confirm text widget.
///
/// [cancelText] lets you set a custom cancel text widget.
///
/// [customHeight] lets you set a custom height for the calendar widget.
///
/// [customWidth] lets you set a custom width for the calendar widget.
///
/// [yearFirst] lets you define that the user must select first the year, then the month.
/// 
/// [dismissible] lets you define if the dialog will be dismissible by clicking outside it.
///
Future<DateTime?> showMonthPicker({
  required BuildContext context,
  required DateTime initialDate,
  DateTime? firstDate,
  DateTime? lastDate,
  Locale? locale,
  bool Function(DateTime)? selectableMonthPredicate,
  bool capitalizeFirstLetter = true,
  Color? headerColor,
  Color? headerTextColor,
  Color? selectedMonthBackgroundColor,
  Color? selectedMonthTextColor,
  Color? unselectedMonthTextColor,
  Text? confirmText,
  Text? cancelText,
  double? customHeight,
  double? customWidth,
  bool yearFirst = false,
  bool dismissible = false
  //bool isCupertino = false,
}) async {
  return await showDialog<DateTime>(
    context: context,
    barrierDismissible: dismissible,
    builder: (BuildContext context) => _MonthPickerDialog(
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      locale: locale,
      selectableMonthPredicate: selectableMonthPredicate,
      capitalizeFirstLetter: capitalizeFirstLetter,
      headerColor: headerColor,
      headerTextColor: headerTextColor,
      selectedMonthBackgroundColor: selectedMonthBackgroundColor,
      selectedMonthTextColor: selectedMonthTextColor,
      unselectedMonthTextColor: unselectedMonthTextColor,
      confirmText: confirmText,
      cancelText: cancelText,
      customHeight: customHeight,
      customWidth: customWidth,
      yearFirst: yearFirst,
      //isCupertino: isCupertino,
    ),
  );
}

class _MonthPickerDialog extends StatefulWidget {
  final DateTime initialDate;
  final DateTime? firstDate, lastDate;
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
  //final bool isCupertino;

  const _MonthPickerDialog({
    Key? key,
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
    //required this.isCupertino,
  }) : super(key: key);

  @override
  _MonthPickerDialogState createState() => _MonthPickerDialogState();
}

class _MonthPickerDialogState extends State<_MonthPickerDialog> {
  final GlobalKey<YearSelectorState> _yearSelectorState = GlobalKey();
  final GlobalKey<MonthSelectorState> _monthSelectorState = GlobalKey();

  final PublishSubject<UpDownPageLimit> _upDownPageLimitPublishSubject =
      PublishSubject();
  final PublishSubject<UpDownButtonEnableState>
      _upDownButtonEnableStatePublishSubject = PublishSubject();

  late Widget _selector;
  late DateTime selectedDate;
  DateTime? _firstDate, _lastDate;

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime(widget.initialDate.year, widget.initialDate.month);
    if (widget.firstDate != null)
      _firstDate = DateTime(widget.firstDate!.year, widget.firstDate!.month);
    if (widget.lastDate != null)
      _lastDate = DateTime(widget.lastDate!.year, widget.lastDate!.month);

    _selector = widget.yearFirst
        ? YearSelector(
            key: _yearSelectorState,
            initialDate: selectedDate,
            firstDate: _firstDate,
            lastDate: _lastDate,
            onYearSelected: _onYearSelected,
            upDownPageLimitPublishSubject: _upDownPageLimitPublishSubject,
            upDownButtonEnableStatePublishSubject:
                _upDownButtonEnableStatePublishSubject,
            selectedMonthBackgroundColor: widget.selectedMonthBackgroundColor,
            selectedMonthTextColor: widget.selectedMonthTextColor,
            unselectedMonthTextColor: widget.unselectedMonthTextColor,
          )
        : MonthSelector(
            key: _monthSelectorState,
            openDate: selectedDate,
            selectedDate: selectedDate,
            selectableMonthPredicate: widget.selectableMonthPredicate,
            upDownPageLimitPublishSubject: _upDownPageLimitPublishSubject,
            upDownButtonEnableStatePublishSubject:
                _upDownButtonEnableStatePublishSubject,
            firstDate: _firstDate,
            lastDate: _lastDate,
            onMonthSelected: _onMonthSelected,
            locale: widget.locale,
            capitalizeFirstLetter: widget.capitalizeFirstLetter,
            selectedMonthBackgroundColor: widget.selectedMonthBackgroundColor,
            selectedMonthTextColor: widget.selectedMonthTextColor,
            unselectedMonthTextColor: widget.unselectedMonthTextColor,
          );
  }

  void dispose() {
    _upDownPageLimitPublishSubject.close();
    _upDownButtonEnableStatePublishSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final String locale = getLocale(context, selectedLocale: widget.locale);

    final Material content = Material(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          PickerPager(
            selector: _selector,
            theme: theme,
            customHeight: widget.customHeight,
            customWidth: widget.customWidth,
          ),
          PickerButtonBar(
            cancelText: widget.cancelText,
            confirmText: widget.confirmText,
            defaultcancelButtonLabel: 'CANCEL',
            defaultokButtonLabel: 'OK',
            cancelFunction: () => Navigator.pop(context, null),
            okFunction: () => Navigator.pop(context, selectedDate),
          ),
        ],
      ),
      color: theme.dialogBackgroundColor,
    );

    final PickerHeader header = PickerHeader(
      theme: theme,
      locale: locale,
      headerColor: widget.headerColor,
      headerTextColor: widget.headerTextColor,
      capitalizeFirstLetter: widget.capitalizeFirstLetter,
      selectedDate: selectedDate,
      isMonthSelector: _selector is MonthSelector,
      onDownButtonPressed: _onDownButtonPressed,
      onSelectYear: _onSelectYear,
      onUpButtonPressed: _onUpButtonPressed,
      upDownButtonEnableStatePublishSubject:
          _upDownButtonEnableStatePublishSubject,
      upDownPageLimitPublishSubject: _upDownPageLimitPublishSubject,
    );

    return Theme(
      data: theme.copyWith(dialogBackgroundColor: Colors.transparent),
      child: Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Builder(
              builder: (BuildContext context) {
                if (MediaQuery.of(context).orientation ==
                    Orientation.portrait) {
                  return IntrinsicWidth(
                    child: Column(
                      children: [header, content],
                    ),
                  );
                }
                return IntrinsicHeight(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [header, content],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _onSelectYear() => setState(() => _selector = YearSelector(
        key: _yearSelectorState,
        initialDate: selectedDate,
        firstDate: _firstDate,
        lastDate: _lastDate,
        onYearSelected: _onYearSelected,
        upDownPageLimitPublishSubject: _upDownPageLimitPublishSubject,
        upDownButtonEnableStatePublishSubject:
            _upDownButtonEnableStatePublishSubject,
        selectedMonthBackgroundColor: widget.selectedMonthBackgroundColor,
        selectedMonthTextColor: widget.selectedMonthTextColor,
        unselectedMonthTextColor: widget.unselectedMonthTextColor,
      ));

  void _onYearSelected(final int year) =>
      setState(() => _selector = MonthSelector(
            key: _monthSelectorState,
            openDate: DateTime(year),
            selectedDate: selectedDate,
            selectableMonthPredicate: widget.selectableMonthPredicate,
            upDownPageLimitPublishSubject: _upDownPageLimitPublishSubject,
            upDownButtonEnableStatePublishSubject:
                _upDownButtonEnableStatePublishSubject,
            firstDate: _firstDate,
            lastDate: _lastDate,
            onMonthSelected: _onMonthSelected,
            locale: widget.locale,
            capitalizeFirstLetter: widget.capitalizeFirstLetter,
            selectedMonthBackgroundColor: widget.selectedMonthBackgroundColor,
            selectedMonthTextColor: widget.selectedMonthTextColor,
            unselectedMonthTextColor: widget.unselectedMonthTextColor,
          ));

  void _onMonthSelected(final DateTime date) => setState(() {
        selectedDate = date;
        _selector = MonthSelector(
          key: _monthSelectorState,
          openDate: selectedDate,
          selectedDate: selectedDate,
          selectableMonthPredicate: widget.selectableMonthPredicate,
          upDownPageLimitPublishSubject: _upDownPageLimitPublishSubject,
          upDownButtonEnableStatePublishSubject:
              _upDownButtonEnableStatePublishSubject,
          firstDate: _firstDate,
          lastDate: _lastDate,
          onMonthSelected: _onMonthSelected,
          locale: widget.locale,
          capitalizeFirstLetter: widget.capitalizeFirstLetter,
          selectedMonthBackgroundColor: widget.selectedMonthBackgroundColor,
          selectedMonthTextColor: widget.selectedMonthTextColor,
          unselectedMonthTextColor: widget.unselectedMonthTextColor,
        );
      });

  void _onUpButtonPressed() {
    if (_yearSelectorState.currentState != null) {
      _yearSelectorState.currentState!.goUp();
    } else {
      _monthSelectorState.currentState!.goUp();
    }
  }

  void _onDownButtonPressed() {
    if (_yearSelectorState.currentState != null) {
      _yearSelectorState.currentState!.goDown();
    } else {
      _monthSelectorState.currentState!.goDown();
    }
  }
}
