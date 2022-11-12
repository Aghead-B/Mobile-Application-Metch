import 'package:flutter/material.dart';
import 'package:metch_ui_kit/src/elements/buttons/button.dart';
import '../../theme/colors.dart';

class ButtonDefault extends Button {
  const ButtonDefault({
    void Function()? onPressed,
    required Widget child,
    Color? color,
    Key? key,
  }) : super(key: key, onPressed: onPressed, child: child, color: color);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      fillColor: color ?? primary500,
      onPressed: onPressed,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4.0))),
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 32.0),
          child: child),
    );
  }
}
