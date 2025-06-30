import 'package:flutter/material.dart';
import '/month_picker_dialog.dart';

///The main dialog widget class.
///It needs a `MonthpickerController` controller to be created.
class MonthPickerDialog extends StatefulWidget {
  const MonthPickerDialog({
    super.key,
    required this.controller,
  });
  final MonthpickerController controller;

  @override
  MonthPickerDialogState createState() => MonthPickerDialogState();
}

class MonthPickerDialogState extends State<MonthPickerDialog> {
  late Widget _selector;

  @override
  void initState() {
    super.initState();
    _selector =
        widget.controller.monthPickerDialogSettings.dialogSettings.yearFirst ||
                widget.controller.onlyYear
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
    final String locale = getLocale(context,
        selectedLocale:
            widget.controller.monthPickerDialogSettings.dialogSettings.locale);
    final bool portrait = widget.controller.monthPickerDialogSettings
            .dialogSettings.forcePortrait ||
        MediaQuery.of(context).orientation == Orientation.portrait;
    final Container content = Container(
      decoration: BoxDecoration(
        color: widget.controller.monthPickerDialogSettings.dialogSettings
                .dialogBackgroundColor ??
            widget.controller.theme.dialogTheme.backgroundColor,
        borderRadius: portrait
            ? BorderRadius.only(
                bottomLeft: Radius.circular(widget
                    .controller
                    .monthPickerDialogSettings
                    .dialogSettings
                    .dialogRoundedCornersRadius),
                bottomRight: Radius.circular(widget
                    .controller
                    .monthPickerDialogSettings
                    .dialogSettings
                    .dialogRoundedCornersRadius),
              )
            : BorderRadius.only(
                topRight: Radius.circular(widget
                    .controller
                    .monthPickerDialogSettings
                    .dialogSettings
                    .dialogRoundedCornersRadius),
                bottomRight: Radius.circular(widget
                    .controller
                    .monthPickerDialogSettings
                    .dialogSettings
                    .dialogRoundedCornersRadius),
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
          if (widget.controller.monthPickerDialogSettings.actionBarSettings
                  .customDivider !=
              null)
            widget.controller.monthPickerDialogSettings.actionBarSettings
                .customDivider!,
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
      data: widget.controller.theme,
      child: Dialog(
        insetPadding: widget
            .controller.monthPickerDialogSettings.dialogSettings.insetPadding,
        shape: RoundedRectangleBorder(
          side: widget.controller.monthPickerDialogSettings.dialogSettings
              .dialogBorderSide,
          borderRadius: BorderRadius.circular(widget
              .controller
              .monthPickerDialogSettings
              .dialogSettings
              .dialogRoundedCornersRadius),
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
  //TODO migrate this to _onYearSelected
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
          widget.controller.selectedDate = DateTime(year);
          _selector = YearSelector(
            key: widget.controller.yearSelectorState,
            onYearSelected: _onYearSelected,
            controller: widget.controller,
          );
        } else {
          widget.controller.firstPossibleMonth(year);
          _selector = MonthSelector(
            key: widget.controller.monthSelectorState,
            onMonthSelected: _onMonthSelected,
            controller: widget.controller,
          );
        }
      },
    );
    if (widget.controller.onYearSelected != null) {
      widget.controller.onYearSelected!(year);
    }
  }

  ///Function to be executed when a month is selected.
  void _onMonthSelected(final DateTime date) {
    setState(
      () {
        if (widget.controller.rangeMode) {
          widget.controller.onRangeDateSelect(date);
        }
        widget.controller.selectedDate = date;
        _selector = MonthSelector(
          key: widget.controller.monthSelectorState,
          onMonthSelected: _onMonthSelected,
          controller: widget.controller,
        );
      },
    );
    if (widget.controller.onYearSelected != null) {
      widget.controller.onMonthSelected!(date);
    }
  }
}
