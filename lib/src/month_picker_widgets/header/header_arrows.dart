import 'package:flutter/material.dart';

class HeaderArrows extends StatelessWidget {
  const HeaderArrows({
    super.key,
    this.arrowcolors,
    required this.onUpButtonPressed,
    required this.onDownButtonPressed,
    required this.upState,
    required this.downState,
  });
  final Color? arrowcolors;

  final VoidCallback onUpButtonPressed, onDownButtonPressed;
  final bool upState, downState;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
          icon: Icon(
            Icons.keyboard_arrow_up,
            color: upState ? arrowcolors : arrowcolors!.withOpacity(0.5),
          ),
          onPressed: upState ? onUpButtonPressed : null,
        ),
        IconButton(
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: downState ? arrowcolors : arrowcolors!.withOpacity(0.5),
          ),
          onPressed: downState ? onDownButtonPressed : null,
        ),
      ],
    );
  }
}
