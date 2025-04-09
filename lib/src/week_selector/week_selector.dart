import 'package:flutter/material.dart';
import 'package:month_picker_dialog/src/helpers/time.dart';
import 'package:month_picker_dialog/src/week_selector/week_year_grid.dart';
import 'package:provider/provider.dart';

import '/month_picker_dialog.dart';

///The widget that will hold the month grid selector.
class WeekSelector extends StatefulWidget {
  const WeekSelector({
    super.key,
    required this.onWeekSelected,
    required this.controller,
  });

  final ValueChanged<Time> onWeekSelected;
  final MonthpickerController controller;

  @override
  State<StatefulWidget> createState() => WeekSelectorState();
}

class WeekSelectorState extends State<WeekSelector> {
  bool _blocked = false;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: widget.controller.weekPageController,
      scrollDirection: Axis.vertical,
      physics: const AlwaysScrollableScrollPhysics(),
      onPageChanged: _onPageChange,
      itemCount: widget.controller.weekPageCount,
      itemBuilder: (final BuildContext context, final int page) => WeekYearGridBuilder(
        onWeekSelected: widget.onWeekSelected,
        controller: widget.controller,
      ),
    );
  }

  ///Function to check if the page has reached the limit of the month list.
  void _onPageChange(final int page) {
    _blocked = !(page - 1 > 0 && page + 1 < widget.controller.weekPageCount - 1);

    Provider.of<YearUpDownPageProvider>(context, listen: false).changePage(
      0,
      widget.controller.localFirstDate != null ? widget.controller.localFirstDate!.year + page : page,
      _blocked ? page < widget.controller.weekPageCount - 1 : null,
      _blocked ? page > 0 : null,
    );
  }

  @override
  void initState() {
    super.initState();
    initialize();
  }

  ///Function to go to the next page of the grid.
  void goDown() {
    widget.controller.weekPageController?.animateToPage(
      widget.controller.weekPageController!.page!.toInt() + 1,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  ///Function to go to the previous page of the grid.
  void goUp() {
    widget.controller.weekPageController?.animateToPage(
      widget.controller.weekPageController!.page!.toInt() - 1,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  ///Function to initialize the grid.
  void initialize() {
    widget.controller.weekPageController = PageController(
      initialPage: widget.controller.localFirstDate == null
          ? widget.controller.selectWeek.year ?? 0
          : widget.controller.selectedDate.year - widget.controller.localFirstDate!.year,
    );
    Future<void>.delayed(
      Duration.zero,
      () {
        // ignore: use_build_context_synchronously
        Provider.of<YearUpDownPageProvider>(context, listen: false).changePage(
          0,
          widget.controller.localFirstDate == null
              ? widget.controller.weekPageController!.page!.toInt()
              : widget.controller.localFirstDate!.year + widget.controller.weekPageController!.page!.toInt(),
          widget.controller.weekPageController!.page!.toInt() < widget.controller.yearPageCount - 1,
          widget.controller.weekPageController!.page!.toInt() > 0,
        );
      },
    );
  }
}
