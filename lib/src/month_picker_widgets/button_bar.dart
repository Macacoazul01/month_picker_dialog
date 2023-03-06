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
          child: controller.cancelWidget ?? Text('CANCEL'),
        ),
        TextButton(
          onPressed: () => controller.okFunction(context),
          child: controller.confirmWidget ?? Text('OK'),
        )
      ],
    );
  }
}
