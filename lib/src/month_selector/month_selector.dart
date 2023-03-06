import 'package:flutter/material.dart';
import '/src/helpers/providers.dart';
import 'package:provider/provider.dart';

import '/src/helpers/controller.dart';
import '/src/month_selector/month_year_grid.dart';

class MonthSelector extends StatefulWidget {
  const MonthSelector({
    super.key,
    required this.onMonthSelected,
    required this.controller,
  });

  final ValueChanged<DateTime> onMonthSelected;
  final MonthpickerController controller;

  @override
  State<StatefulWidget> createState() => MonthSelectorState();
}

class MonthSelectorState extends State<MonthSelector> {
  bool _blocked = false;
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: widget.controller.monthPageController,
      scrollDirection: Axis.vertical,
      physics: const AlwaysScrollableScrollPhysics(),
      onPageChanged: _onPageChange,
      itemCount: widget.controller.monthPageCount,
      itemBuilder: (final BuildContext context, final int page) =>
          MonthYearGridBuilder(
        onMonthSelected: widget.onMonthSelected,
        controller: widget.controller,
        page: page,
      ),
    );
  }

  void _onPageChange(final int page) {
    _blocked =
        !(page - 1 > 0 && page + 1 < widget.controller.monthPageCount - 1);

    Provider.of<monthUpDownPageProvider>(context, listen: false).changePage(
      0,
      widget.controller.localFirstDate != null
          ? widget.controller.localFirstDate!.year + page
          : page,
      _blocked ? page < widget.controller.monthPageCount - 1 : null,
      _blocked ? page > 0 : null,
    );
  }

  @override
  void initState() {
    super.initState();
    initialize();
  }

  void goDown() {
    widget.controller.monthPageController?.animateToPage(
      widget.controller.monthPageController!.page!.toInt() + 1,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  void goUp() {
    widget.controller.monthPageController?.animateToPage(
      widget.controller.monthPageController!.page!.toInt() - 1,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  void initialize() {
    widget.controller.monthPageController = PageController(
      initialPage: widget.controller.localFirstDate == null
          ? widget.controller.selectedDate.year
          : widget.controller.selectedDate.year -
              widget.controller.localFirstDate!.year,
    );
    Future<void>.delayed(
      Duration.zero,
      () {
        Provider.of<monthUpDownPageProvider>(context, listen: false).changePage(
          0,
          widget.controller.localFirstDate == null
              ? widget.controller.monthPageController!.page!.toInt()
              : widget.controller.localFirstDate!.year +
                  widget.controller.monthPageController!.page!.toInt(),
          widget.controller.monthPageController!.page!.toInt() <
              widget.controller.monthPageCount - 1,
          widget.controller.monthPageController!.page!.toInt() > 0,
        );
      },
    );
  }
}
