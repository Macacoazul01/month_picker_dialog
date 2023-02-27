import 'package:flutter/material.dart';
import '/src/year_selector/year_grid.dart';
import '/src/helpers/controller.dart';

import '/src/helpers/common.dart';
import '/src/helpers/initialize.dart';

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
  PageController? _pageController;

  @override
  Widget build(BuildContext context) => PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        physics: const AlwaysScrollableScrollPhysics(),
        onPageChanged: _onPageChange,
        itemCount: getYearPageCount(
            widget.controller.localFirstDate, widget.controller.localLastDate),
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
    if (page == 0 ||
        page ==
            getYearPageCount(widget.controller.localFirstDate,
                    widget.controller.localLastDate) -
                1) {
      widget.controller.upDownButtonEnableStatePublishSubject.add(
        UpDownButtonEnableState(
            page > 0,
            page <
                getYearPageCount(widget.controller.localFirstDate,
                        widget.controller.localLastDate) -
                    1),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: widget.controller.localFirstDate == null
          ? (widget.controller.selectedDate.year / 12).floor()
          : ((widget.controller.selectedDate.year -
                      widget.controller.localFirstDate!.year) /
                  12)
              .floor(),
    );
    initializeYearSelector(
        _pageController,
        widget.controller.localFirstDate,
        widget.controller.localLastDate,
        widget.controller.upDownPageLimitPublishSubject,
        widget.controller.upDownButtonEnableStatePublishSubject);
  }

  @override
  void dispose() {
    _pageController!.dispose();
    super.dispose();
  }

  void goDown() {
    _pageController!.animateToPage(
      _pageController!.page!.toInt() + 1,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  void goUp() {
    _pageController!.animateToPage(
      _pageController!.page!.toInt() - 1,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }
}
