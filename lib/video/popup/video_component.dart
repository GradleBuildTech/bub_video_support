import 'dart:async';

import 'package:bub_video_support/video/popup/flutter_video.dart';
import 'package:bub_video_support/video/popup/video_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'video_overlay_entry.dart';

class VideoComponent {
  Widget? _w;

  VideoOverlayEntry? overlayEntry;

  Widget? get w => _w;

  GlobalKey<VideoContainerState>? _key;
  GlobalKey<VideoContainerState>? _progressKey;

  GlobalKey<VideoContainerState>? get key => _key;
  GlobalKey<VideoContainerState>? get progressKey => _progressKey;

  static final VideoComponent _instance = VideoComponent._internal();

  factory VideoComponent() => _instance;

  VideoComponent._internal();

  static VideoComponent get instance => _instance;

  static bool get isShow => _instance._w != null;

  static TransitionBuilder init({
    TransitionBuilder? builder,
  }) {
    return (BuildContext context, Widget? child) {
      if (builder != null) {
        return builder(context, FluttVideo(child: child));
      }
      return FluttVideo(child: child);
    };
  }

  static Future<void> show({
    Widget? w,
    String? videoUrl,
    String? title,
    String? subTitle,
  }) async {
    return _instance._show(
        videoUrl: videoUrl, title: title, subTitle: subTitle, w: w);
  }

  static Future<void> dismiss({bool clearControlKey = true}) async {
    if (clearControlKey) {
      // injector.get<VideoController>().reset();
    }
    return _instance._dimiss();
  }

  Future<void> _dimiss() async {
    if (key != null && key?.currentState != null) {
      _reset();
      return;
    }
    // return key?.currentState?.dimi
  }

  Future<void> _show({
    Widget? w,
    String? videoUrl,
    String? title,
    String? subTitle,
  }) async {
    assert(overlayEntry != null, "OverlayEntry cannot be null");
    // bool animation = _w == null;
    _progressKey = null;

    if (_key != null) {
      //Do something
    }

    Completer<void> completer = Completer<void>();
    _key = GlobalKey<VideoContainerState>();
    _w = VideoContainer(
        key: _key,
        w: w,
        onDimiss: _reset,
        completer: completer,
        videoUrl: videoUrl,
        title: title,
        suibTitle: subTitle);
    completer.future.whenComplete(() {});
    overlayEntry?.markNeedsBuild();
    return completer.future;
  }

  void _reset() {
    _w = null;
    _key = null;
    _progressKey = null;
    overlayEntry?.markNeedsBuild();
  }
}
