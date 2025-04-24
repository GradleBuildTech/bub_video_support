import 'package:flutter/material.dart';

import 'video_component.dart';
import 'video_overlay_entry.dart';

class FluttVideo extends StatefulWidget {
  final Widget? child;
  const FluttVideo({super.key, this.child})
      : assert(child != null, "Child cannot be null");

  @override
  State<FluttVideo> createState() => _FluttVideoState();
}

class _FluttVideoState extends State<FluttVideo> {
  late VideoOverlayEntry _videoOverlayEntry;

  @override
  void initState() {
    super.initState();
    _videoOverlayEntry = VideoOverlayEntry(
        builder: (context) => VideoComponent.instance.w ?? Container());

    VideoComponent.instance.overlayEntry = _videoOverlayEntry;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Overlay(
      initialEntries: [
        VideoOverlayEntry(
          builder: (BuildContext context) {
            if (widget.child != null) {
              return widget.child!;
            } else {
              return Container();
            }
          },
        ),
        _videoOverlayEntry
      ],
    ));
  }
}
