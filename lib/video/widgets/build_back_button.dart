import 'package:bub_video_support/video/utils/platform_helpers.dart';
import 'package:flutter/material.dart';

class BuildBackButton extends StatelessWidget {
  final IconData? initialIcon;
  final Color? color;

  final Function()? onPressed;
  const BuildBackButton(
      {super.key, this.initialIcon, this.color, this.onPressed});

  IconData get icon =>
      initialIcon ?? (isAndroid ? Icons.arrow_back : Icons.arrow_back_ios);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(icon, color: color),
        onPressed: () {
          if (onPressed != null) {
            onPressed!();
          } else {
            Navigator.of(context).pop();
          }
        });
  }
}
