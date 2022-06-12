import 'package:flutter/material.dart';

class PickerButtonBar extends StatelessWidget {
  const PickerButtonBar(
      {Key? key,
      this.cancelText,
      this.confirmText,
      required this.defaultcancelButtonLabel,
      required this.defaultokButtonLabel,
      required this.cancelFunction,
      required this.okFunction})
      : super(key: key);
  final Text? cancelText;
  final Text? confirmText;
  final String defaultcancelButtonLabel;
  final String defaultokButtonLabel;
  final VoidCallback cancelFunction;
  final VoidCallback okFunction;

  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      children: <Widget>[
        TextButton(
          onPressed: cancelFunction,
          child: cancelText ??
              Text(
                defaultcancelButtonLabel,
                style: Theme.of(context)
                    .textTheme
                    .button!
                    .copyWith(color: Theme.of(context).primaryColor),
              ),
        ),
        TextButton(
          onPressed: okFunction,
          child: confirmText ??
              Text(
                defaultokButtonLabel,
                style: Theme.of(context)
                    .textTheme
                    .button!
                    .copyWith(color: Theme.of(context).primaryColor),
              ),
        )
      ],
    );
  }
}
