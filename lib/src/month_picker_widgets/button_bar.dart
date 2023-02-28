import 'package:flutter/material.dart';
import '/src/helpers/controller.dart';

class PickerButtonBar extends StatelessWidget {
  const PickerButtonBar({
    super.key,
    required this.controller,
  });
  final MonthpickerController controller;

  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      children: <Widget>[
        TextButton(
          onPressed: () => controller.cancelFunction(context),
          child: controller.cancelText ??
              Text(
                'CANCEL',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(color: Theme.of(context).primaryColor),
              ),
        ),
        TextButton(
          onPressed: () => controller.okFunction(context),
          child: controller.confirmText ??
              Text(
                'OK',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(color: Theme.of(context).primaryColor),
              ),
        )
      ],
    );
  }
}
