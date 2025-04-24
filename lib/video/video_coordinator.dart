import 'package:flutter/material.dart';

import 'popup/video_component.dart';

extension VideoCoordinator on BuildContext {
  Future<void> showVideoBottom({
    String? videoUrl,
    String? title,
    String? subTitle,
    bool isLoading = false,
    List<Widget> listWidget = const [],
  }) async {
    return VideoComponent.show(
      videoUrl: videoUrl,
      title: title,
      subTitle: subTitle,
    );
  }
}
