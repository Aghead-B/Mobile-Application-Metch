import 'package:flutter/material.dart';

abstract class Button extends StatelessWidget {
  const Button({
    super.key,
    this.onPressed,
    required this.child,
    this.color,
  });

  final void Function()? onPressed;
  final Widget child;
  final Color? color;
}
