import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '/src/helpers/common.dart';
import '/src/helpers/initialize.dart';
import '/src/month_selector/month_year_grid.dart';

class MonthSelector extends StatefulWidget {

  const MonthSelector({
    super.key,
    required this.openDate,
    required this.selectedDate,
    required this.onMonthSelected,
    required this.upDownPageLimitPublishSubject,
    required this.upDownButtonEnableStatePublishSubject,
    this.firstDate,
    this.lastDate,
    this.locale,
    this.selectableMonthPredicate,
    required this.capitalizeFirstLetter,
    required this.selectedMonthBackgroundColor,
    required this.selectedMonthTextColor,
    required this.unselectedMonthTextColor,
  });

  final ValueChanged<DateTime> onMonthSelected;
  final DateTime? firstDate, lastDate;
  final DateTime selectedDate, openDate;
  final PublishSubject<UpDownPageLimit> upDownPageLimitPublishSubject;
  final PublishSubject<UpDownButtonEnableState>
      upDownButtonEnableStatePublishSubject;
  final Locale? locale;
  final bool Function(DateTime)? selectableMonthPredicate;
  final bool capitalizeFirstLetter;
  final Color? selectedMonthBackgroundColor,
      selectedMonthTextColor,
      unselectedMonthTextColor;

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
        itemCount: getMonthPageCount(widget.firstDate, widget.lastDate),
        itemBuilder: (final BuildContext context, final int page) =>
            MonthYearGridBuilder(
          capitalizeFirstLetter: widget.capitalizeFirstLetter,
          onMonthSelected: widget.onMonthSelected,
          openDate: widget.openDate,
          page: page,
          selectedDate: widget.selectedDate,
          firstDate: widget.firstDate,
          lastDate: widget.lastDate,
          locale: widget.locale,
          selectableMonthPredicate: widget.selectableMonthPredicate,
          selectedMonthBackgroundColor: widget.selectedMonthBackgroundColor,
          selectedMonthTextColor: widget.selectedMonthTextColor,
          unselectedMonthTextColor: widget.unselectedMonthTextColor,
        ),
      );

  void _onPageChange(final int page) {
    widget.upDownPageLimitPublishSubject.add(
      UpDownPageLimit(
        widget.firstDate != null ? widget.firstDate!.year + page : page,
        0,
      ),
    );
    widget.upDownButtonEnableStatePublishSubject.add(
      UpDownButtonEnableState(page > 0, page < getMonthPageCount(widget.firstDate, widget.lastDate) - 1),
    );
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
        initialPage: widget.firstDate == null
            ? widget.openDate.year
            : widget.openDate.year - widget.firstDate!.year);
    initializeMonthSelector(_pageController,widget.firstDate, widget.lastDate, widget.upDownPageLimitPublishSubject, widget.upDownButtonEnableStatePublishSubject);
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
