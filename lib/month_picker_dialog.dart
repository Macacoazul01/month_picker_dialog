import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import '/src/MonthSelector.dart';
import '/src/YearSelector.dart';
import '/src/common.dart';
import '/src/locale_utils.dart';
import 'package:rxdart/rxdart.dart';

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
}) async {
  final localizations = locale == null
      ? MaterialLocalizations.of(context)
      : await GlobalMaterialLocalizations.delegate.load(locale);
  return await showDialog<DateTime>(
    context: context,
    barrierDismissible: false,
    builder: (context) => _MonthPickerDialog(
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      locale: locale,
      selectableMonthPredicate: selectableMonthPredicate,
      localizations: localizations,
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
    ),
  );
}

class _MonthPickerDialog extends StatefulWidget {
  final DateTime? initialDate, firstDate, lastDate;
  final MaterialLocalizations localizations;
  final Locale? locale;
  final bool Function(DateTime)? selectableMonthPredicate;
  final bool capitalizeFirstLetter;
  final Color? headerColor;
  final Color? headerTextColor;
  final Color? selectedMonthBackgroundColor;
  final Color? selectedMonthTextColor;
  final Color? unselectedMonthTextColor;
  final Text? confirmText;
  final Text? cancelText;
  final double? customHeight;
  final double? customWidth;
  final bool yearFirst;

  const _MonthPickerDialog({
    Key? key,
    required this.initialDate,
    required this.localizations,
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
  }) : super(key: key);

  @override
  _MonthPickerDialogState createState() => _MonthPickerDialogState();
}

class _MonthPickerDialogState extends State<_MonthPickerDialog> {
  final GlobalKey<YearSelectorState> _yearSelectorState = GlobalKey();
  final GlobalKey<MonthSelectorState> _monthSelectorState = GlobalKey();

  PublishSubject<UpDownPageLimit>? _upDownPageLimitPublishSubject;
  PublishSubject<UpDownButtonEnableState>?
      _upDownButtonEnableStatePublishSubject;

  Widget? _selector;
  DateTime? selectedDate, _firstDate, _lastDate;

  @override
  void initState() {
    super.initState();
    selectedDate =
        DateTime(widget.initialDate!.year, widget.initialDate!.month);
    if (widget.firstDate != null)
      _firstDate = DateTime(widget.firstDate!.year, widget.firstDate!.month);
    if (widget.lastDate != null)
      _lastDate = DateTime(widget.lastDate!.year, widget.lastDate!.month);

    _upDownPageLimitPublishSubject = PublishSubject();
    _upDownButtonEnableStatePublishSubject = PublishSubject();

    _selector = widget.yearFirst
        ? YearSelector(
            key: _yearSelectorState,
            initialDate: selectedDate!,
            firstDate: _firstDate,
            lastDate: _lastDate,
            onYearSelected: _onYearSelected,
            upDownPageLimitPublishSubject: _upDownPageLimitPublishSubject!,
            upDownButtonEnableStatePublishSubject:
                _upDownButtonEnableStatePublishSubject!,
            selectedMonthBackgroundColor: widget.selectedMonthBackgroundColor,
            selectedMonthTextColor: widget.selectedMonthTextColor,
            unselectedMonthTextColor: widget.unselectedMonthTextColor,
          )
        : MonthSelector(
            key: _monthSelectorState,
            openDate: selectedDate!,
            selectedDate: selectedDate!,
            selectableMonthPredicate: widget.selectableMonthPredicate,
            upDownPageLimitPublishSubject: _upDownPageLimitPublishSubject!,
            upDownButtonEnableStatePublishSubject:
                _upDownButtonEnableStatePublishSubject!,
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
    _upDownPageLimitPublishSubject!.close();
    _upDownButtonEnableStatePublishSubject!.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var locale = getLocale(context, selectedLocale: widget.locale);
    var header = buildHeader(theme, locale);
    var pager = buildPager(theme, locale);
    var content = Material(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [pager, buildButtonBar(context)],
      ),
      color: theme.dialogBackgroundColor,
    );
    return Theme(
      data:
          Theme.of(context).copyWith(dialogBackgroundColor: Colors.transparent),
      child: Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Builder(builder: (context) {
              if (MediaQuery.of(context).orientation == Orientation.portrait) {
                return IntrinsicWidth(
                  child: Column(children: [header, content]),
                );
              }
              return IntrinsicHeight(
                child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [header, content]),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget buildButtonBar(
    BuildContext context,
  ) {
    return ButtonBar(
      children: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, null),
          child: widget.cancelText ??
              Text(
                widget.localizations.cancelButtonLabel,
                style: Theme.of(context)
                    .textTheme
                    .button!
                    .copyWith(color: Theme.of(context).primaryColor),
              ),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, selectedDate),
          child: widget.confirmText ??
              Text(
                widget.localizations.okButtonLabel,
                style: Theme.of(context)
                    .textTheme
                    .button!
                    .copyWith(color: Theme.of(context).primaryColor),
              ),
        )
      ],
    );
  }

  Widget buildHeader(ThemeData theme, String locale) {
    final _headline5 = widget.headerTextColor == null
        ? theme.primaryTextTheme.headline5
        : theme.primaryTextTheme.headline5!
            .copyWith(color: widget.headerTextColor);
    final _arrowcolors = widget.headerTextColor ?? theme.primaryIconTheme.color;

    return Material(
      color: widget.headerColor ?? theme.primaryColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.capitalizeFirstLetter
                  ? '${toBeginningOfSentenceCase(DateFormat.yMMM(locale).format(selectedDate!))}'
                  : '${DateFormat.yMMM(locale).format(selectedDate!).toLowerCase()}',
              style: widget.headerTextColor == null
                  ? theme.primaryTextTheme.subtitle1
                  : theme.primaryTextTheme.subtitle1!
                      .copyWith(color: widget.headerTextColor),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _selector is MonthSelector
                    ? GestureDetector(
                        onTap: _onSelectYear,
                        child: StreamBuilder<UpDownPageLimit>(
                          stream: _upDownPageLimitPublishSubject,
                          initialData: const UpDownPageLimit(0, 0),
                          builder: (_, snapshot) => Text(
                            '${DateFormat.y(locale).format(DateTime(snapshot.data!.upLimit))}',
                            style: _headline5,
                          ),
                        ),
                      )
                    : StreamBuilder<UpDownPageLimit>(
                        stream: _upDownPageLimitPublishSubject,
                        initialData: const UpDownPageLimit(0, 0),
                        builder: (_, snapshot) => Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '${DateFormat.y(locale).format(DateTime(snapshot.data!.upLimit))}',
                              style: _headline5,
                            ),
                            Text(
                              '-',
                              style: _headline5,
                            ),
                            Text(
                              '${DateFormat.y(locale).format(DateTime(snapshot.data!.downLimit))}',
                              style: _headline5,
                            ),
                          ],
                        ),
                      ),
                StreamBuilder<UpDownButtonEnableState>(
                  stream: _upDownButtonEnableStatePublishSubject,
                  initialData: const UpDownButtonEnableState(true, true),
                  builder: (_, snapshot) => Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.keyboard_arrow_up,
                          color: snapshot.data!.upState
                              ? _arrowcolors
                              : _arrowcolors!.withOpacity(0.5),
                        ),
                        onPressed:
                            snapshot.data!.upState ? _onUpButtonPressed : null,
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: snapshot.data!.downState
                              ? _arrowcolors
                              : _arrowcolors!.withOpacity(0.5),
                        ),
                        onPressed: snapshot.data!.downState
                            ? _onDownButtonPressed
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

  Widget buildPager(ThemeData theme, String locale) {
    return SizedBox(
      height: widget.customHeight ?? 230.0,
      width: widget.customWidth ?? 320.0,
      child: Theme(
        data: theme.copyWith(
          buttonTheme: ButtonThemeData(
            padding: EdgeInsets.all(2.0),
            shape: CircleBorder(),
            minWidth: 4.0,
          ),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          reverseDuration: const Duration(milliseconds: 500),
          transitionBuilder: (Widget child, Animation<double> animation) =>
              ScaleTransition(child: child, scale: animation),
          child: _selector,
        ),
      ),
    );
  }

  void _onSelectYear() => setState(() => _selector = YearSelector(
        key: _yearSelectorState,
        initialDate: selectedDate!,
        firstDate: _firstDate,
        lastDate: _lastDate,
        onYearSelected: _onYearSelected,
        upDownPageLimitPublishSubject: _upDownPageLimitPublishSubject!,
        upDownButtonEnableStatePublishSubject:
            _upDownButtonEnableStatePublishSubject!,
        selectedMonthBackgroundColor: widget.selectedMonthBackgroundColor,
        selectedMonthTextColor: widget.selectedMonthTextColor,
        unselectedMonthTextColor: widget.unselectedMonthTextColor,
      ));

  void _onYearSelected(final int year) =>
      setState(() => _selector = MonthSelector(
            key: _monthSelectorState,
            openDate: DateTime(year),
            selectedDate: selectedDate!,
            selectableMonthPredicate: widget.selectableMonthPredicate,
            upDownPageLimitPublishSubject: _upDownPageLimitPublishSubject!,
            upDownButtonEnableStatePublishSubject:
                _upDownButtonEnableStatePublishSubject!,
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
          openDate: selectedDate!,
          selectedDate: selectedDate!,
          selectableMonthPredicate: widget.selectableMonthPredicate,
          upDownPageLimitPublishSubject: _upDownPageLimitPublishSubject!,
          upDownButtonEnableStatePublishSubject:
              _upDownButtonEnableStatePublishSubject!,
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
