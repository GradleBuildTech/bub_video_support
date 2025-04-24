import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

typedef VideoListner = Function({bool? isFullScreen, Duration? position});

class Video {
  String? videUrl;

  VideoPlayerController? videoPlayerController;

  YoutubePlayerController? youtubePlayerController;

  VideoListner? videoListner;

  Video(
      {this.videUrl,
      this.videoPlayerController,
      this.youtubePlayerController,
      this.videoListner})
      : assert(
          (videoPlayerController != null && youtubePlayerController == null) ||
              (videoPlayerController == null &&
                  youtubePlayerController != null),
          'Either videoPlayerController or youtubePlayerController must be provided, not both.',
        );
}
