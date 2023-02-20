import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/src/common.dart';
import 'package:rxdart/rxdart.dart';

import 'locale_utils.dart';

class MonthSelector extends StatefulWidget {
  final ValueChanged<DateTime> onMonthSelected;
  final DateTime? openDate, selectedDate, firstDate, lastDate;
  final PublishSubject<UpDownPageLimit> upDownPageLimitPublishSubject;
  final PublishSubject<UpDownButtonEnableState>
      upDownButtonEnableStatePublishSubject;
  final Locale? locale;
  const MonthSelector({
    Key? key,
    required DateTime this.openDate,
    required DateTime this.selectedDate,
    required this.onMonthSelected,
    required this.upDownPageLimitPublishSubject,
    required this.upDownButtonEnableStatePublishSubject,
    this.firstDate,
    this.lastDate,
    this.locale,
  }) : super(key: key);
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
        itemCount: _getPageCount(),
        itemBuilder: _yearGridBuilder,
      );

  Widget _yearGridBuilder(final BuildContext context, final int page) =>
      GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.all(8.0),
        crossAxisCount: 4,
        children: List<Widget>.generate(
          12,
          (final int index) => _getMonthButton(
              DateTime(
                  widget.firstDate != null
                      ? widget.firstDate!.year + page
                      : page,
                  index + 1),
              getLocale(context, selectedLocale: widget.locale)),
        ).toList(growable: false),
      );

  Widget _getMonthButton(final DateTime date, final String locale) {
    final bool isEnabled = _isEnabled(date);
    return TextButton(
      onPressed: isEnabled
          ? () => widget.onMonthSelected(DateTime(date.year, date.month))
          : null,
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll<Color?>(
          date.month == widget.selectedDate!.month &&
                  date.year == widget.selectedDate!.year
              ? Theme.of(context).colorScheme.secondary
              : null,
        ),
        foregroundColor: MaterialStatePropertyAll<Color?>(
          date.month == widget.selectedDate!.month &&
                  date.year == widget.selectedDate!.year
              ? Theme.of(context).colorScheme.onSecondary
              : date.month == DateTime.now().month &&
                      date.year == DateTime.now().year
                  ? Theme.of(context).colorScheme.secondary
                  : null,
        ),
      ),
      child: Text(
        DateFormat.MMM(locale).format(date),
      ),
    );
  }

  void _onPageChange(final int page) {
    widget.upDownPageLimitPublishSubject.add(
      new UpDownPageLimit(
        widget.firstDate != null ? widget.firstDate!.year + page : page,
        0,
      ),
    );
    widget.upDownButtonEnableStatePublishSubject.add(
      new UpDownButtonEnableState(page > 0, page < _getPageCount() - 1),
    );
  }

  int _getPageCount() {
    if (widget.firstDate != null && widget.lastDate != null) {
      return widget.lastDate!.year - widget.firstDate!.year + 1;
    } else if (widget.firstDate != null && widget.lastDate == null) {
      return 9999 - widget.firstDate!.year;
    } else if (widget.firstDate == null && widget.lastDate != null) {
      return widget.lastDate!.year + 1;
    } else
      return 9999;
  }

  @override
  void initState() {
    _pageController = new PageController(
        initialPage: widget.firstDate == null
            ? widget.openDate!.year
            : widget.openDate!.year - widget.firstDate!.year);
    super.initState();
    new Future.delayed(Duration.zero, () {
      widget.upDownPageLimitPublishSubject.add(
        new UpDownPageLimit(
          widget.firstDate == null
              ? _pageController!.page!.toInt()
              : widget.firstDate!.year + _pageController!.page!.toInt(),
          0,
        ),
      );
      widget.upDownButtonEnableStatePublishSubject.add(
        new UpDownButtonEnableState(
          _pageController!.page!.toInt() > 0,
          _pageController!.page!.toInt() < _getPageCount() - 1,
        ),
      );
    });
  }

  @override
  void dispose() {
    _pageController!.dispose();
    super.dispose();
  }

  bool _isEnabled(final DateTime date) {
    if (widget.firstDate == null && widget.lastDate == null)
      return true;
    else if (widget.firstDate != null &&
        widget.lastDate != null &&
        widget.firstDate!.compareTo(date) <= 0 &&
        widget.lastDate!.compareTo(date) >= 0)
      return true;
    else if (widget.firstDate != null &&
        widget.lastDate == null &&
        widget.firstDate!.compareTo(date) <= 0)
      return true;
    else if (widget.firstDate == null &&
        widget.lastDate != null &&
        widget.lastDate!.compareTo(date) >= 0)
      return true;
    else
      return false;
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
