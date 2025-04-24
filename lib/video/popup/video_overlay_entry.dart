import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

T? _ambiguate<T>(T? value) => value;

class VideoOverlayEntry extends OverlayEntry {
  final WidgetBuilder builder;

  VideoOverlayEntry({required this.builder}) : super(builder: builder);

  ///[markNeedsBuild] is used to mark the overlay entry as needing a rebuild.
  ///It checks if the current scheduler phase is [SchedulerPhase.persistentCallbacks].
  ///If it is, it adds a post-frame callback to rebuild the overlay entry after the current frame.
  ///Otherwise, it calls the superclass method to mark the entry as needing a rebuild immediately.
  @override
  void markNeedsBuild() {
    if (_ambiguate(SchedulerBinding.instance)?.schedulerPhase ==
        SchedulerPhase.persistentCallbacks) {
      _ambiguate(SchedulerBinding.instance)?.addPostFrameCallback((_) {
        super.markNeedsBuild();
      });
    } else {
      super.markNeedsBuild();
    }
  }
}
