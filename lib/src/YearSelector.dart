import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/src/common.dart';
import 'package:rxdart/rxdart.dart';

import 'locale_utils.dart';

class YearSelector extends StatefulWidget {
  final ValueChanged<int> onYearSelected;
  final DateTime initialDate, firstDate, lastDate;
  final PublishSubject<UpDownPageLimit> upDownPageLimitPublishSubject;
  final PublishSubject<UpDownButtonEnableState>
      upDownButtonEnableStatePublishSubject;
  final Locale locale;
  const YearSelector({
    Key key,
    @required this.initialDate,
    @required this.onYearSelected,
    @required this.upDownPageLimitPublishSubject,
    @required this.upDownButtonEnableStatePublishSubject,
    this.firstDate,
    this.lastDate,
    this.locale,
  })  : assert(initialDate != null),
        assert(onYearSelected != null),
        assert(upDownPageLimitPublishSubject != null),
        assert(upDownButtonEnableStatePublishSubject != null),
        super(key: key);
  @override
  State<StatefulWidget> createState() => YearSelectorState();
}

class YearSelectorState extends State<YearSelector> {
  PageController _pageController;

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
          (final int index) => _getYearButton(page, index, getLocale(context, selectedLocale: widget.locale)),
        ).toList(growable: false),
      );

  Widget _getYearButton(final int page, final int index, final String locale) {
    final int year = (widget.firstDate == null ? 0 : widget.firstDate.year) +
        page * 12 +
        index;
    final bool isEnabled = _isEnabled(year);
    return FlatButton(
      onPressed: isEnabled ? () => widget.onYearSelected(year) : null,
      color: year == widget.initialDate.year
          ? Theme.of(context).accentColor
          : null,
      textColor: year == widget.initialDate.year
          ? Theme.of(context).accentTextTheme.button.color
          : year == DateTime.now().year ? Theme.of(context).accentColor : null,
      child: Text(
        DateFormat.y(locale).format(DateTime(year)),
      ),
    );
  }

  void _onPageChange(final int page) {
    widget.upDownPageLimitPublishSubject.add(new UpDownPageLimit(
        widget.firstDate == null
            ? page * 12
            : widget.firstDate.year + page * 12,
        widget.firstDate == null
            ? page * 12 + 11
            : widget.firstDate.year + page * 12 + 11));
    if (page == 0 || page == _getPageCount() - 1) {
      widget.upDownButtonEnableStatePublishSubject.add(
        new UpDownButtonEnableState(page > 0, page < _getPageCount() - 1),
      );
    }
  }

  int _getPageCount() {
    if (widget.firstDate != null && widget.lastDate != null) {
      if (widget.lastDate.year - widget.firstDate.year <= 12)
        return 1;
      else
        return ((widget.lastDate.year - widget.firstDate.year + 1) / 12).ceil();
    } else if (widget.firstDate != null && widget.lastDate == null) {
      return (_getItemCount() / 12).ceil();
    } else if (widget.firstDate == null && widget.lastDate != null) {
      return (_getItemCount() / 12).ceil();
    } else
      return (9999 / 12).ceil();
  }

  int _getItemCount() {
    if (widget.firstDate != null && widget.lastDate != null) {
      return widget.lastDate.year - widget.firstDate.year + 1;
    } else if (widget.firstDate != null && widget.lastDate == null) {
      return (9999 - widget.firstDate.year);
    } else if (widget.firstDate == null && widget.lastDate != null) {
      return widget.lastDate.year;
    } else
      return 9999;
  }

  @override
  void initState() {
    _pageController = new PageController(
        initialPage: widget.firstDate == null
            ? (widget.initialDate.year / 12).floor()
            : ((widget.initialDate.year - widget.firstDate.year) / 12).floor());
    super.initState();
    new Future.delayed(Duration.zero, () {
      widget.upDownPageLimitPublishSubject.add(new UpDownPageLimit(
        widget.firstDate == null
            ? _pageController.page.toInt() * 12
            : widget.firstDate.year + _pageController.page.toInt() * 12,
        widget.firstDate == null
            ? _pageController.page.toInt() * 12 + 11
            : widget.firstDate.year + _pageController.page.toInt() * 12 + 11,
      ));
      widget.upDownButtonEnableStatePublishSubject.add(
        new UpDownButtonEnableState(_pageController.page.toInt() > 0,
            _pageController.page.toInt() < _getPageCount() - 1),
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  bool _isEnabled(final int year) {
    if (widget.firstDate == null && widget.lastDate == null)
      return true;
    else if (widget.firstDate != null &&
        widget.lastDate != null &&
        year >= widget.firstDate.year &&
        year <= widget.lastDate.year)
      return true;
    else if (widget.firstDate != null &&
        widget.lastDate == null &&
        year >= widget.firstDate.year)
      return true;
    else if (widget.firstDate == null &&
        widget.lastDate != null &&
        year <= widget.lastDate.year)
      return true;
    else
      return false;
  }

  void goDown() {
    _pageController.animateToPage(
      _pageController.page.toInt() + 1,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  void goUp() {
    _pageController.animateToPage(
      _pageController.page.toInt() - 1,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }
}
