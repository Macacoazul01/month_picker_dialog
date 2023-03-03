import 'package:flutter/material.dart';

import '/src/helpers/common.dart';
import '/src/helpers/controller.dart';
import '/src/helpers/initialize.dart';
import '/src/year_selector/year_grid.dart';

class YearSelector extends StatefulWidget {
  const YearSelector({
    super.key,
    required this.controller,
    required this.onYearSelected,
  });

  final MonthpickerController controller;
  final ValueChanged<int> onYearSelected;

  @override
  State<StatefulWidget> createState() => YearSelectorState();
}

class YearSelectorState extends State<YearSelector> {

  @override
  Widget build(BuildContext context) => PageView.builder(
        controller: widget.controller.yearPageController,
        scrollDirection: Axis.vertical,
        physics: const AlwaysScrollableScrollPhysics(),
        onPageChanged: _onPageChange,
        itemCount: widget.controller.yearPageCount,
        itemBuilder: (final BuildContext context, final int page) => YearGrid(
            page: page,
            onYearSelected: widget.onYearSelected,
            controller: widget.controller),
      );

  void _onPageChange(final int page) {
    widget.controller.upDownPageLimitPublishSubject.add(UpDownPageLimit(
        widget.controller.localFirstDate == null
            ? page * 12
            : widget.controller.localFirstDate!.year + page * 12,
        widget.controller.localFirstDate == null
            ? page * 12 + 11
            : widget.controller.localFirstDate!.year + page * 12 + 11));
    if (page == 0 || page == widget.controller.yearPageCount - 1) {
      widget.controller.upDownButtonEnableStatePublishSubject.add(
        UpDownButtonEnableState(
            page > 0, page < widget.controller.yearPageCount - 1),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    widget.controller.yearPageController = PageController(
      initialPage: widget.controller.localFirstDate == null
          ? (widget.controller.selectedDate.year / 12).floor()
          : ((widget.controller.selectedDate.year -
                      widget.controller.localFirstDate!.year) /
                  12)
              .floor(),
    );
    initializeYearSelector(
      widget.controller,
    );
  }

  @override
  void dispose() {
    widget.controller.yearPageController.dispose();
    super.dispose();
  }

  void goDown() {
    widget.controller.yearPageController.animateToPage(
      widget.controller.yearPageController.page!.toInt() + 1,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  void goUp() {
    widget.controller.yearPageController.animateToPage(
      widget.controller.yearPageController.page!.toInt() - 1,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }
}
