import 'package:flutter/material.dart';
import '/src/helpers/controller.dart';

import '/src/helpers/common.dart';
import '/src/helpers/initialize.dart';
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
  PageController? _pageController;

  @override
  Widget build(BuildContext context) => PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        physics: const AlwaysScrollableScrollPhysics(),
        onPageChanged: _onPageChange,
        itemCount: getMonthPageCount(
            widget.controller.localFirstDate, widget.controller.localLastDate),
        itemBuilder: (final BuildContext context, final int page) =>
            MonthYearGridBuilder(
          onMonthSelected: widget.onMonthSelected,
          controller: widget.controller,
          page: page,
        ),
      );

  void _onPageChange(final int page) {
    widget.controller.upDownPageLimitPublishSubject.add(
      UpDownPageLimit(
        widget.controller.localFirstDate != null
            ? widget.controller.localFirstDate!.year + page
            : page,
        0,
      ),
    );
    widget.controller.upDownButtonEnableStatePublishSubject.add(
      UpDownButtonEnableState(
          page > 0,
          page <
              getMonthPageCount(widget.controller.localFirstDate,
                      widget.controller.localLastDate) -
                  1),
    );
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
        initialPage: widget.controller.localFirstDate == null
            ? widget.controller.selectedDate.year
            : widget.controller.selectedDate.year -
                widget.controller.localFirstDate!.year);
    initializeMonthSelector(
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
