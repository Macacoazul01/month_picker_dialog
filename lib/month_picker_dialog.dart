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
/// [initialDate] is the initially selected month.
/// [firstDate] is the optional lower bound for month selection.
/// [lastDate] is the optional upper bound for month selection.
/// [selectableMonthPredicate] lets you control enabled months just like the official selectableDayPredicate.
/// [capitalizeFirstLetter] lets you control if your months names are capitalized or not.
Future<DateTime?> showMonthPicker({
  required BuildContext context,
  required DateTime initialDate,
  DateTime? firstDate,
  DateTime? lastDate,
  Locale? locale,
  bool Function(DateTime)? selectableMonthPredicate,
  bool capitalizeFirstLetter = true,
}) async {
  final localizations = locale == null
      ? MaterialLocalizations.of(context)
      : await GlobalMaterialLocalizations.delegate.load(locale);
  return await showDialog<DateTime>(
    context: context,
    builder: (context) => _MonthPickerDialog(
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      locale: locale,
      selectableMonthPredicate: selectableMonthPredicate,
      localizations: localizations,
      capitalizeFirstLetter: capitalizeFirstLetter,
    ),
  );
}

class _MonthPickerDialog extends StatefulWidget {
  final DateTime? initialDate, firstDate, lastDate;
  final MaterialLocalizations localizations;
  final Locale? locale;
  final bool Function(DateTime)? selectableMonthPredicate;
  final bool capitalizeFirstLetter;

  const _MonthPickerDialog({
    Key? key,
    required this.initialDate,
    required this.localizations,
    this.firstDate,
    this.lastDate,
    this.locale,
    this.selectableMonthPredicate,
    required this.capitalizeFirstLetter,
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
    selectedDate = DateTime(widget.initialDate!.year, widget.initialDate!.month);
    if (widget.firstDate != null)
      _firstDate = DateTime(widget.firstDate!.year, widget.firstDate!.month);
    if (widget.lastDate != null)
      _lastDate = DateTime(widget.lastDate!.year, widget.lastDate!.month);

    _upDownPageLimitPublishSubject = PublishSubject();
    _upDownButtonEnableStatePublishSubject = PublishSubject();

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
          child: Text(
            widget.localizations.cancelButtonLabel,
            style: Theme.of(context)
                .textTheme
                .button!
                .copyWith(color: Theme.of(context).primaryColor),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, selectedDate),
          child: Text(
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
    return Material(
      color: theme.primaryColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text( widget.capitalizeFirstLetter ? '${toBeginningOfSentenceCase(DateFormat.yMMM(locale).format(selectedDate!))}' :
              '${DateFormat.yMMM(locale).format(selectedDate!).toLowerCase()}',
              style: theme.primaryTextTheme.subtitle1,
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
                            style: theme.primaryTextTheme.headline5,
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
                              style: theme.primaryTextTheme.headline5,
                            ),
                            Text(
                              '-',
                              style: theme.primaryTextTheme.headline5,
                            ),
                            Text(
                              '${DateFormat.y(locale).format(DateTime(snapshot.data!.downLimit))}',
                              style: theme.primaryTextTheme.headline5,
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
                              ? theme.primaryIconTheme.color
                              : theme.primaryIconTheme.color!.withOpacity(0.5),
                        ),
                        onPressed:
                            snapshot.data!.upState ? _onUpButtonPressed : null,
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: snapshot.data!.downState
                              ? theme.primaryIconTheme.color
                              : theme.primaryIconTheme.color!.withOpacity(0.5),
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
      height: 230.0,
      width: 300.0,
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
