import 'package:flutter/material.dart';

class VideoButtons extends StatefulWidget {
  const VideoButtons({super.key});

  @override
  State<VideoButtons> createState() => _VideoButtonsState();
}

class _VideoButtonsState extends State<VideoButtons> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class VideoButton extends StatelessWidget {
  final Widget icon;
  final String? label;
  final VoidCallback? onPressed;

  const VideoButton(
      {super.key, required this.icon, this.onPressed, this.label});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
        child: Column(
          children: [
            icon,
            if (label != null) const SizedBox(height: 3),
            if (label != null)
              Text(
                label ?? '',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(color: Colors.white),
              )
          ],
        ),
      ),
    );
  }
}
