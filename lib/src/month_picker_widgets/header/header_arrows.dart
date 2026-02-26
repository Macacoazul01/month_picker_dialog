import 'package:flutter/material.dart';

///The arrows that are used on the header to change between the pages of the grid.
class HeaderArrows extends StatelessWidget {
  const HeaderArrows({
    super.key,
    this.arrowcolors,
    this.arrowSize,
    required this.onUpButtonPressed,
    required this.onDownButtonPressed,
    required this.upState,
    required this.downState,
    this.previousIcon,
    this.nextIcon,
    required this.arrowAlpha,
    required this.verticalScrolling,
    this.previousButtonSemanticsLabel,
    this.nextButtonSemanticsLabel,
  });
  final Color? arrowcolors;
  final double? arrowSize;
  final double arrowAlpha;
  final VoidCallback onUpButtonPressed, onDownButtonPressed;
  final bool upState, downState;
  final IconData? previousIcon;
  final IconData? nextIcon;
  final bool verticalScrolling;
  final String? previousButtonSemanticsLabel;
  final String? nextButtonSemanticsLabel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Semantics(
          label: previousButtonSemanticsLabel ??
              MaterialLocalizations.of(context).previousMonthTooltip,
          button: true,
          excludeSemantics: true,
          child: IconButton(
            icon: Icon(
              previousIcon ??
                  (verticalScrolling
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_left),
              color: upState
                  ? arrowcolors
                  : arrowcolors!.withValues(alpha: arrowAlpha),
              size: arrowSize,
            ),
            onPressed: upState ? onUpButtonPressed : null,
          ),
        ),
        Semantics(
          label: nextButtonSemanticsLabel ??
              MaterialLocalizations.of(context).nextMonthTooltip,
          button: true,
          excludeSemantics: true,
          child: IconButton(
            icon: Icon(
              nextIcon ??
                  (verticalScrolling
                      ? Icons.keyboard_arrow_down
                      : Icons.keyboard_arrow_right),
              color: downState
                  ? arrowcolors
                  : arrowcolors!.withValues(alpha: arrowAlpha),
              size: arrowSize,
            ),
            onPressed: downState ? onDownButtonPressed : null,
          ),
        ),
      ],
    );
  }
}
