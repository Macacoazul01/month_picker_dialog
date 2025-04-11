import 'package:flutter/material.dart';
import 'package:month_picker_dialog/src/quarter_selector/quarter_selector.dart';
import 'package:month_picker_dialog/src/week_selector/week_selector.dart';
import 'package:provider/provider.dart';
import '/month_picker_dialog.dart';
import 'helpers/time.dart';

///The main dialog widget class.
///It needs a `MonthpickerController` controller to be created.
class MonthPickerDialog extends StatefulWidget {
  const MonthPickerDialog({super.key, required this.controller});

  final MonthpickerController controller;

  @override
  MonthPickerDialogState createState() => MonthPickerDialogState();
}

class MonthPickerDialogState extends State<MonthPickerDialog> {
  late Widget _selector;

  @override
  void initState() {
    super.initState();
    _selector = widget.controller.monthPickerDialogSettings.dialogSettings.yearFirst || widget.controller.onlyYear
        ? YearSelector(
            key: widget.controller.yearSelectorState,
            onYearSelected: _onYearSelected,
            controller: widget.controller,
          )
        : widget.controller.isWeek
            ? WeekSelector(
                key: widget.controller.weekSelectorState,
                onWeekSelected: _onWeekSelected,
                controller: widget.controller,
              )
            : widget.controller.isQuarter
                ? QuarterSelector(
                    key: widget.controller.quarterSelectorState,
                    onQuarterSelected: _onQuarterSelected,
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
    final String locale = getLocale(context, selectedLocale: widget.controller.monthPickerDialogSettings.dialogSettings.locale);
    final bool portrait =
        widget.controller.monthPickerDialogSettings.dialogSettings.forcePortrait || MediaQuery.of(context).orientation == Orientation.portrait;
    final Container content = Container(
      decoration: BoxDecoration(
        color: widget.controller.monthPickerDialogSettings.dialogSettings.dialogBackgroundColor ?? widget.controller.theme.dialogBackgroundColor,
        borderRadius: portrait
            ? BorderRadius.only(
                bottomLeft: Radius.circular(widget.controller.monthPickerDialogSettings.dialogSettings.dialogRoundedCornersRadius),
                bottomRight: Radius.circular(widget.controller.monthPickerDialogSettings.dialogSettings.dialogRoundedCornersRadius),
              )
            : BorderRadius.only(
                topRight: Radius.circular(widget.controller.monthPickerDialogSettings.dialogSettings.dialogRoundedCornersRadius),
                bottomRight: Radius.circular(widget.controller.monthPickerDialogSettings.dialogSettings.dialogRoundedCornersRadius),
              ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          PickerPager(
            selector: _selector,
            theme: widget.controller.theme,
            controller: widget.controller,
          ),
          if (widget.controller.monthPickerDialogSettings.actionBarSettings.customDivider != null)
            widget.controller.monthPickerDialogSettings.actionBarSettings.customDivider!,
          PickerActionBar(
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
      data: widget.controller.theme.copyWith(dialogBackgroundColor: Colors.transparent),
      child: Dialog(
        insetPadding: widget.controller.monthPickerDialogSettings.dialogSettings.insetPadding,
        shape: RoundedRectangleBorder(
          side: widget.controller.monthPickerDialogSettings.dialogSettings.dialogBorderSide,
          borderRadius: BorderRadius.circular(widget.controller.monthPickerDialogSettings.dialogSettings.dialogRoundedCornersRadius),
        ),
        child: Builder(
          builder: (BuildContext context) {
            if (portrait) {
              return SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: IntrinsicWidth(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[header, content],
                  ),
                ),
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

  ///Function to change the grid to the year selector.
  void _onSelectYear() => setState(
        () => _selector = YearSelector(
          key: widget.controller.yearSelectorState,
          onYearSelected: _onYearSelected,
          controller: widget.controller,
        ),
      );

  ///Function to be executed when a year is selected.
  void _onYearSelected(final int year) {
    setState(
      () {
        if (widget.controller.onlyYear) {
          widget.controller.selectedDate.value = DateTime(year);
          _selector = YearSelector(
            key: widget.controller.yearSelectorState,
            onYearSelected: _onYearSelected,
            controller: widget.controller,
          );
          return;
        }
        widget.controller.firstPossibleMonth(year);
        _selector = MonthSelector(
          key: widget.controller.monthSelectorState,
          onMonthSelected: _onMonthSelected,
          controller: widget.controller,
        );
      },
    );
  }

  ///Function to be executed when a month is selected.
  void _onMonthSelected(final DateTime date) => setState(
        () {
          if (widget.controller.rangeMode) {
            widget.controller.onRangeDateSelect(date);
          }
          widget.controller.selectedDate.value = date;
          _selector = MonthSelector(
            key: widget.controller.monthSelectorState,
            onMonthSelected: _onMonthSelected,
            controller: widget.controller,
          );
        },
      );

  void _onWeekSelected(final Time time) => setState(
        () {
          widget.controller.selectWeek.value = time;
          _selector = WeekSelector(
            key: widget.controller.weekSelectorState,
            onWeekSelected: _onWeekSelected,
            controller: widget.controller,
          );
        },
      );

  void _onQuarterSelected(final Time time) => setState(
        () {
          widget.controller.selectQuarter.value = time;
          _selector = QuarterSelector(
            key: widget.controller.quarterSelectorState,
            onQuarterSelected: _onQuarterSelected,
            controller: widget.controller,
          );
        },
      );
}
