import 'package:bub_video_support/video/widgets/build_image_custom.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../video_data.dart';

class YoutubeVideoPlayerItem extends StatefulWidget {
  final Video? video;
  final bool playButtonVisible;
  final Function()? onTap;

  final String? thumbNail;
  final double? width;
  final double? height;

  final bool showThumbNail;

  const YoutubeVideoPlayerItem(
      {super.key,
      this.video,
      required this.playButtonVisible,
      this.onTap,
      this.thumbNail,
      this.width,
      this.showThumbNail = false,
      this.height})
      : assert((showThumbNail) ? thumbNail != null : true,
            'Thumbnail must be provided when showThumbNail is true');

  @override
  State<YoutubeVideoPlayerItem> createState() => _YoutubeVideoPlayerItemState();
}

class _YoutubeVideoPlayerItemState extends State<YoutubeVideoPlayerItem> {
  YoutubePlayerController? get _youtubeController =>
      widget.video?.youtubePlayerController;

  @override
  void initState() {
    super.initState();
    _youtubeController?.addListener(_videoControllerListener);
  }

  void _videoControllerListener() {
    final position = _youtubeController?.value.position;
    final isFullScreen = _youtubeController?.value.isFullScreen;
    widget.video?.videoListner
        ?.call(isFullScreen: isFullScreen, position: position);
  }

  @override
  void dispose() {
    _youtubeController?.removeListener(_videoControllerListener);
    _youtubeController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if ((widget.thumbNail?.isNotEmpty ?? false) && widget.showThumbNail) {
      return BuildImageCustom(
          imageUrl: widget.thumbNail!,
          width: widget.width,
          height: widget.height,
          fit: BoxFit.cover,
          isNetworkImage: true);
    }
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: widget.onTap,
      child: Stack(
        children: [
          Container(
            color: Colors.black,
            width: widget.width,
            height: widget.height,
            child: widget.video?.youtubePlayerController != null
                ? YoutubePlayer(
                    controller: _youtubeController!,
                    showVideoProgressIndicator: true,
                    progressIndicatorColor: Colors.white,
                    progressColors: const ProgressBarColors(
                      playedColor: Colors.white,
                      handleColor: Colors.white,
                    ),
                  )
                : const SizedBox(),
          ),
          if (widget.playButtonVisible)
            Center(
              child: IconButton(
                onPressed: () {
                  if (_youtubeController != null) {
                    if (_youtubeController?.value.isPlaying ?? false) {
                      _youtubeController?.pause();
                    } else {
                      _youtubeController?.play();
                    }
                  }
                  widget.onTap?.call();
                },
                color: Theme.of(context).primaryColor,
                icon: Icon(
                    (_youtubeController?.value.isPlaying ?? false)
                        ? IconsaxPlusBold.play
                        : IconsaxPlusBold.pause,
                    size: 50,
                    color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }
}
