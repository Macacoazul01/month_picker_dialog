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
  });
  final Color? arrowcolors;
  final double? arrowSize;
  final VoidCallback onUpButtonPressed, onDownButtonPressed;
  final bool upState, downState;
  final IconData? previousIcon;
  final IconData? nextIcon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
          icon: Icon(
            previousIcon ?? Icons.keyboard_arrow_up,
            color: upState ? arrowcolors : arrowcolors!.withOpacity(0.5),
            size: arrowSize,
          ),
          onPressed: upState ? onUpButtonPressed : null,
        ),
        IconButton(
          icon: Icon(
            nextIcon ?? Icons.keyboard_arrow_down,
            color: downState ? arrowcolors : arrowcolors!.withOpacity(0.5),
            size: arrowSize,
          ),
          onPressed: downState ? onDownButtonPressed : null,
        ),
      ],
    );
  }
}
