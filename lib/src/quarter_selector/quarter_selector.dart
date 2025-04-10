import 'package:flutter/material.dart';
import 'package:month_picker_dialog/src/helpers/time.dart';
import 'package:month_picker_dialog/src/quarter_selector/quarter_year_grid.dart';
import 'package:month_picker_dialog/src/week_selector/week_year_grid.dart';
import 'package:provider/provider.dart';

import '/month_picker_dialog.dart';

///The widget that will hold the month grid selector.
class QuarterSelector extends StatefulWidget {
  const QuarterSelector({
    super.key,
    required this.onQuarterSelected,
    required this.controller,
  });

  final ValueChanged<Time> onQuarterSelected;
  final MonthpickerController controller;

  @override
  State<StatefulWidget> createState() => QuarterSelectorState();
}

class QuarterSelectorState extends State<QuarterSelector> {
  bool _blocked = false;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: widget.controller.quarterPageController,
      scrollDirection: Axis.vertical,
      physics: const AlwaysScrollableScrollPhysics(),
      onPageChanged: _onPageChange,
      itemCount: widget.controller.quarterPageCount,
      itemBuilder: (final BuildContext context, final int page) => QuarterYearGridBuilder(
        onQuarterSelected: widget.onQuarterSelected,
        controller: widget.controller,
      ),
    );
  }

  ///Function to check if the page has reached the limit of the month list.
  void _onPageChange(final int page) {
    _blocked = !(page - 1 > 0 && page + 1 < widget.controller.quarterPageCount - 1);

    Provider.of<YearUpDownPageProvider>(context, listen: false).changePage(
      0,
      widget.controller.localFirstDate != null ? widget.controller.localFirstDate!.year + page : page,
      _blocked ? page < widget.controller.quarterPageCount - 1 : null,
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
    widget.controller.quarterPageController?.animateToPage(
      widget.controller.quarterPageController!.page!.toInt() + 1,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  ///Function to go to the previous page of the grid.
  void goUp() {
    widget.controller.quarterPageController?.animateToPage(
      widget.controller.quarterPageController!.page!.toInt() - 1,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  ///Function to initialize the grid.
  void initialize() {
    widget.controller.quarterPageController = PageController(
      initialPage: widget.controller.localFirstDate == null
          ? widget.controller.selectQuarter.year ?? 0
          : widget.controller.selectQuarter.year! - widget.controller.localFirstDate!.year,
    );
    Future<void>.delayed(
      Duration.zero,
      () {
        // ignore: use_build_context_synchronously
        Provider.of<YearUpDownPageProvider>(context, listen: false).changePage(
          0,
          widget.controller.localFirstDate == null
              ? widget.controller.quarterPageController!.page!.toInt()
              : widget.controller.localFirstDate!.year + widget.controller.quarterPageController!.page!.toInt(),
          widget.controller.quarterPageController!.page!.toInt() < widget.controller.yearPageCount - 1,
          widget.controller.quarterPageController!.page!.toInt() > 0,
        );
      },
    );
  }
}
