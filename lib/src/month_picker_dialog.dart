import 'package:flutter/material.dart';
import '/month_picker_dialog.dart';

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
    final bool portrait = widget.controller.forcePortrait || MediaQuery.of(context).orientation == Orientation.portrait;
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
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          PickerPager(
            selector: _selector,
            theme: widget.controller.theme,
            controller: widget.controller,
          ),
          if (widget.controller.customDivider != null)
            widget.controller.customDivider!,
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
        shape: RoundedRectangleBorder(
          side: widget.controller.dialogBorderSide,
          borderRadius:
              BorderRadius.circular(widget.controller.roundedCornersRadius),
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
          widget.controller.selectedDate = date;
          _selector = MonthSelector(
            key: widget.controller.monthSelectorState,
            onMonthSelected: _onMonthSelected,
            controller: widget.controller,
          );
        },
      );
}
