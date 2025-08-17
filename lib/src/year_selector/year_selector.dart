import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/month_picker_dialog.dart';

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
  bool _blocked = false;

  int _getFirstYearOfPage(int page) {
    final int yearsPerPage =
        widget.controller.monthPickerDialogSettings.dialogSettings.yearsPerPage;
    return widget.controller.localFirstDate?.year ?? 0 + page * yearsPerPage;
  }

  int _getLastYearOfPage(int page) {
    return _getFirstYearOfPage(page) +
        widget
            .controller.monthPickerDialogSettings.dialogSettings.yearsPerPage -
        1;
  }

  int _getInitialPage() {
    final int selectedYear = widget.controller.selectedDate.year;
    final int yearsPerPage =
        widget.controller.monthPickerDialogSettings.dialogSettings.yearsPerPage;

    if (widget.controller.localFirstDate == null) {
      return (selectedYear / yearsPerPage).floor();
    }
    return ((selectedYear - widget.controller.localFirstDate!.year) /
            yearsPerPage)
        .floor();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: widget.controller.yearPageController,
      scrollDirection: Axis.vertical,
      physics: widget.controller.monthPickerDialogSettings.dialogSettings
              .blockScrolling
          ? const NeverScrollableScrollPhysics()
          : const AlwaysScrollableScrollPhysics(),
      onPageChanged: _onPageChange,
      itemCount: widget.controller.yearPageCount,
      itemBuilder: (final BuildContext context, final int page) => YearGrid(
        page: page,
        onYearSelected: widget.onYearSelected,
        controller: widget.controller,
      ),
    );
  }

  void _onPageChange(int page) {
    final int pageCount = widget.controller.yearPageCount;
    _blocked = !(page > 1 && page < pageCount - 2);

    Provider.of<YearUpDownPageProvider>(context, listen: false).changePage(
      _getLastYearOfPage(page),
      _getFirstYearOfPage(page),
      _blocked ? page < pageCount - 1 : null,
      _blocked ? page > 0 : null,
    );
  }

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  void goDown() {
    final PageController? pageController = widget.controller.yearPageController;
    final int currentPage = pageController?.page?.toInt() ?? 0;
    pageController?.animateToPage(
      currentPage + 1,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  void goUp() {
    final PageController? pageController = widget.controller.yearPageController;
    final int currentPage = pageController?.page?.toInt() ?? 0;
    pageController?.animateToPage(
      currentPage - 1,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  void _initialize() {
    widget.controller.yearPageController =
        PageController(initialPage: _getInitialPage());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final page = widget.controller.yearPageController?.page?.toInt() ?? 0;
      Provider.of<YearUpDownPageProvider>(context, listen: false).changePage(
        _getLastYearOfPage(page),
        _getFirstYearOfPage(page),
        page < widget.controller.yearPageCount - 1,
        page > 0,
      );
    });
  }
}
