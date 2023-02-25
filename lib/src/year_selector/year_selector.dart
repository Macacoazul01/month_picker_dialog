import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

import '/src/helpers/common.dart';
import '/src/helpers/initialize.dart';
import '/src/helpers/locale_utils.dart';

class YearSelector extends StatefulWidget {

  const YearSelector({
    super.key,
    required this.initialDate,
    required this.onYearSelected,
    required this.upDownPageLimitPublishSubject,
    required this.upDownButtonEnableStatePublishSubject,
    this.firstDate,
    this.lastDate,
    this.locale,
    required this.selectedMonthBackgroundColor,
    required this.selectedMonthTextColor,
    required this.unselectedMonthTextColor,
  });

  final ValueChanged<int> onYearSelected;
  final DateTime initialDate;
  final DateTime? firstDate, lastDate;
  final PublishSubject<UpDownPageLimit> upDownPageLimitPublishSubject;
  final PublishSubject<UpDownButtonEnableState>
      upDownButtonEnableStatePublishSubject;
  final Locale? locale;
  final Color? selectedMonthBackgroundColor,
      selectedMonthTextColor,
      unselectedMonthTextColor;
      
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
        itemCount: getYearPageCount(widget.firstDate, widget.lastDate),
        itemBuilder: _yearGridBuilder,
      );

  Widget _yearGridBuilder(final BuildContext context, final int page) =>
      GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(8.0),
        crossAxisCount: 4,
        children: List<Widget>.generate(
          12,
          (final int index) => _getYearButton(
              page, index, getLocale(context, selectedLocale: widget.locale)),
        ).toList(growable: false),
      );

  Widget _getYearButton(final int page, final int index, final String locale) {
    final int year = (widget.firstDate == null ? 0 : widget.firstDate!.year) +
        page * 12 +
        index;
    final bool isEnabled = _isEnabled(year);
    final ThemeData theme = Theme.of(context);
    final Color backgroundColor =
        widget.selectedMonthBackgroundColor ?? theme.colorScheme.secondary;
    return TextButton(
      onPressed: isEnabled ? () => widget.onYearSelected(year) : null,
      style: TextButton.styleFrom(
          foregroundColor: year == widget.initialDate.year
              ? theme.textTheme.labelLarge!
                  .copyWith(
                    color: widget.selectedMonthTextColor ??
                        theme.colorScheme.onSecondary,
                  )
                  .color
              : year == DateTime.now().year
                  ? backgroundColor
                  : widget.unselectedMonthTextColor,
          backgroundColor:
              year == widget.initialDate.year ? backgroundColor : null,
          shape: const CircleBorder()),
      child: Text(
        DateFormat.y(locale).format(DateTime(year)),
      ),
    );
  }

  void _onPageChange(final int page) {
    widget.upDownPageLimitPublishSubject.add(UpDownPageLimit(
        widget.firstDate == null
            ? page * 12
            : widget.firstDate!.year + page * 12,
        widget.firstDate == null
            ? page * 12 + 11
            : widget.firstDate!.year + page * 12 + 11));
    if (page == 0 || page == getYearPageCount(widget.firstDate, widget.lastDate) - 1) {
      widget.upDownButtonEnableStatePublishSubject.add(
        UpDownButtonEnableState(page > 0, page < getYearPageCount(widget.firstDate, widget.lastDate) - 1),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: widget.firstDate == null
          ? (widget.initialDate.year / 12).floor()
          : ((widget.initialDate.year - widget.firstDate!.year) / 12).floor());
    initializeYearSelector(_pageController,widget.firstDate, widget.lastDate, widget.upDownPageLimitPublishSubject, widget.upDownButtonEnableStatePublishSubject);
  }

  @override
  void dispose() {
    _pageController!.dispose();
    super.dispose();
  }

  bool _isEnabled(final int year) {
    if (widget.firstDate == null && widget.lastDate == null)
      return true;
    else if (widget.firstDate != null &&
        widget.lastDate != null &&
        year >= widget.firstDate!.year &&
        year <= widget.lastDate!.year)
      return true;
    else if (widget.firstDate != null &&
        widget.lastDate == null &&
        year >= widget.firstDate!.year)
      return true;
    else if (widget.firstDate == null &&
        widget.lastDate != null &&
        year <= widget.lastDate!.year)
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
