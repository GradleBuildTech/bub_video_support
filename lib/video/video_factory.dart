import 'package:bub_video_support/video/utils/string_extension.dart';
import 'package:bub_video_support/video/utils/video_helper.dart';
import 'package:bub_video_support/video/video_data.dart';
import 'package:flutter/material.dart';

import 'widgets/video_player_item.dart';

class VideoFactory {
  static Widget createVideoComponent({
    String? thumbNail,
    double? width,
    double? height,
    VideoListner? videoListner,
    bool showThumbNail = false,
    required String videoUrl,
    required Function() onTap,
  }) {
    if (videoUrl.isEmpty) {
      return const SizedBox.shrink();
    }
    if (videoUrl.isYoutubeVideoUrl) {
      final videoId = VideoHelper.getYoutubeVideoId(videoUrl);
      if (videoId == null) {
        return const SizedBox.shrink();
      }
      return YoutubeVideoPlayerItem(
        playButtonVisible: false,
        onTap: onTap,
        thumbNail: thumbNail,
        width: width,
        showThumbNail: showThumbNail,
        height: height,
        video: Video(
          videUrl: videoUrl,
          videoListner: videoListner,
          youtubePlayerController: YoutubePlayerController(
              initialVideoId: videoId,
              flags: const YoutubePlayerFlags(autoPlay: false, mute: false)),
        ),
      );
    }

    return VideoPlayerItem(
      video: Video(
        videoListner: videoListner,
        videoPlayerController: VideoPlayerController.networkUrl(
          Uri.parse(videoUrl),
        ),
        videUrl: videoUrl,
      ),
      playButtonVisible: true,
      onTap: onTap,
    );
  }
}
