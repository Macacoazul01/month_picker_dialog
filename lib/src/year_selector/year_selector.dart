import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/src/helpers/controller.dart';
import '/src/helpers/providers.dart';
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
  bool _blocked = false;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: widget.controller.yearPageController,
      scrollDirection: Axis.vertical,
      physics: const AlwaysScrollableScrollPhysics(),
      onPageChanged: _onPageChange,
      itemCount: widget.controller.yearPageCount,
      itemBuilder: (final BuildContext context, final int page) => YearGrid(
        page: page,
        onYearSelected: widget.onYearSelected,
        controller: widget.controller,
      ),
    );
  }

  void _onPageChange(final int page) {
    _blocked =
        !(page - 1 > 0 && page + 1 < widget.controller.yearPageCount - 1);
    Provider.of<YearUpDownPageProvider>(context, listen: false).changePage(
      widget.controller.localFirstDate == null
          ? page * 12 + 11
          : widget.controller.localFirstDate!.year + page * 12 + 11,
      widget.controller.localFirstDate == null
          ? page * 12
          : widget.controller.localFirstDate!.year + page * 12,
      _blocked ? page < widget.controller.yearPageCount - 1 : null,
      _blocked ? page > 0 : null,
    );
  }

  @override
  void initState() {
    super.initState();
    initialize();
  }

  void goDown() {
    widget.controller.yearPageController?.animateToPage(
      widget.controller.yearPageController!.page!.toInt() + 1,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  void goUp() {
    widget.controller.yearPageController?.animateToPage(
      widget.controller.yearPageController!.page!.toInt() - 1,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  void initialize() {
    widget.controller.yearPageController = PageController(
      initialPage: widget.controller.localFirstDate == null
          ? (widget.controller.selectedDate.year / 12).floor()
          : ((widget.controller.selectedDate.year -
                      widget.controller.localFirstDate!.year) /
                  12)
              .floor(),
    );
    Future<void>.delayed(
      Duration.zero,
      () {
        Provider.of<YearUpDownPageProvider>(context, listen: false).changePage(
          widget.controller.localFirstDate == null
              ? widget.controller.yearPageController!.page!.toInt() * 12 + 11
              : widget.controller.localFirstDate!.year +
                  widget.controller.yearPageController!.page!.toInt() * 12 +
                  11,
          widget.controller.localFirstDate == null
              ? widget.controller.yearPageController!.page!.toInt() * 12
              : widget.controller.localFirstDate!.year +
                  widget.controller.yearPageController!.page!.toInt() * 12,
          widget.controller.yearPageController!.page!.toInt() <
              widget.controller.yearPageCount - 1,
          widget.controller.yearPageController!.page!.toInt() > 0,
        );
      },
    );
  }
}
