import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/src/helpers/locale_utils.dart';
import '/src/helpers/common.dart';
import 'package:rxdart/rxdart.dart';

class MonthSelector extends StatefulWidget {
  final ValueChanged<DateTime> onMonthSelected;
  final DateTime? openDate, selectedDate, firstDate, lastDate;
  final PublishSubject<UpDownPageLimit> upDownPageLimitPublishSubject;
  final PublishSubject<UpDownButtonEnableState>
      upDownButtonEnableStatePublishSubject;
  final Locale? locale;
  final bool Function(DateTime)? selectableMonthPredicate;
  final bool capitalizeFirstLetter;
  final Color? selectedMonthBackgroundColor;
  final Color? selectedMonthTextColor;
  final Color? unselectedMonthTextColor;

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
    this.selectableMonthPredicate,
    required this.capitalizeFirstLetter,
    required this.selectedMonthBackgroundColor,
    required this.selectedMonthTextColor,
    required this.unselectedMonthTextColor,
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
    final ThemeData theme = Theme.of(context);
    final _backgroundColor =
        widget.selectedMonthBackgroundColor ?? theme.colorScheme.secondary;
    return TextButton(
      onPressed: isEnabled
          ? () => widget.onMonthSelected(DateTime(date.year, date.month))
          : null,
      style: TextButton.styleFrom(
          backgroundColor: date.month == widget.selectedDate!.month &&
                  date.year == widget.selectedDate!.year
              ? _backgroundColor
              : null,
          primary: date.month == widget.selectedDate!.month &&
                  date.year == widget.selectedDate!.year
              ? theme.textTheme.button!
                  .copyWith(
                    color: widget.selectedMonthTextColor ??
                        theme.colorScheme.onSecondary,
                  )
                  .color
              : date.month == DateTime.now().month &&
                      date.year == DateTime.now().year
                  ? _backgroundColor
                  : widget.unselectedMonthTextColor ?? null,
          shape: CircleBorder()),
      child: Text(
        widget.capitalizeFirstLetter
            ? toBeginningOfSentenceCase(DateFormat.MMM(locale).format(date))!
            : DateFormat.MMM(locale).format(date).toLowerCase(),
      ),
    );
  }

  void _onPageChange(final int page) {
    widget.upDownPageLimitPublishSubject.add(
      UpDownPageLimit(
        widget.firstDate != null ? widget.firstDate!.year + page : page,
        0,
      ),
    );
    widget.upDownButtonEnableStatePublishSubject.add(
      UpDownButtonEnableState(page > 0, page < _getPageCount() - 1),
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
    _pageController = PageController(
        initialPage: widget.firstDate == null
            ? widget.openDate!.year
            : widget.openDate!.year - widget.firstDate!.year);
    super.initState();
    Future.delayed(Duration.zero, () {
      widget.upDownPageLimitPublishSubject.add(
        UpDownPageLimit(
          widget.firstDate == null
              ? _pageController!.page!.toInt()
              : widget.firstDate!.year + _pageController!.page!.toInt(),
          0,
        ),
      );
      widget.upDownButtonEnableStatePublishSubject.add(
        UpDownButtonEnableState(
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
    if ((widget.firstDate == null &&
            (widget.lastDate == null ||
                (widget.lastDate != null &&
                    widget.lastDate!.compareTo(date) >= 0))) ||
        (widget.firstDate != null &&
            ((widget.lastDate != null &&
                    widget.firstDate!.compareTo(date) <= 0 &&
                    widget.lastDate!.compareTo(date) >= 0) ||
                (widget.lastDate == null &&
                    widget.firstDate!.compareTo(date) <= 0)))) {
      return holdsSelectionPredicate(date);
    } else
      return false;
  }

  bool holdsSelectionPredicate(DateTime date) {
    if (widget.selectableMonthPredicate != null) {
      return widget.selectableMonthPredicate!(date);
    } else {
      return true;
    }
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
