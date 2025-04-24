import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:video_player/video_player.dart';

import '../video_data.dart';

class VideoPlayerItem extends StatefulWidget {
  final Video video;
  final bool playButtonVisible;
  final Function() onTap;
  const VideoPlayerItem({
    super.key,
    required this.video,
    required this.playButtonVisible,
    required this.onTap,
  });

  @override
  State<VideoPlayerItem> createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  VideoPlayerController? get _videoController =>
      widget.video.videoPlayerController;

  @override
  void initState() {
    super.initState();
    _videoController?.addListener(_videoControllerListner);
    _videoController?.initialize();
  }

  void _videoControllerListner() {
    var duration = _videoController?.value.duration;
    var position = _videoController?.value.position;
    if (duration != null && position != null) {
      if (duration == position) {
        widget.video.videoPlayerController?.pause();
        widget.video.videoPlayerController?.seekTo(const Duration(seconds: 0));
      }
    }

    // if(_videoController?.value.i)
  }

  @override
  void dispose() {
    _videoController?.removeListener(_videoControllerListner);
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: widget.onTap,
      child: Stack(
        children: [
          Container(
            color: Colors.black,
            child: widget.video.videoPlayerController != null
                ? Center(
                    child: AspectRatio(
                      aspectRatio:
                          widget.video.videoPlayerController!.value.aspectRatio,
                      child: VideoPlayer(widget.video.videoPlayerController!),
                    ),
                  )
                : const SizedBox(),
          ),
          if (widget.playButtonVisible)
            Center(
              child: IconButton(
                icon: Icon(
                    (widget.video.videoPlayerController?.value.isPlaying ??
                            false)
                        ? IconsaxPlusBold.play
                        : IconsaxPlusBold.pause,
                    size: 50),
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  if (widget.video.videoPlayerController != null) {
                    if (widget.video.videoPlayerController?.value.isPlaying ??
                        false) {
                      widget.video.videoPlayerController?.pause();
                    } else {
                      widget.video.videoPlayerController?.play();
                    }
                  }
                  widget.onTap.call();
                },
              ),
            ),
        ],
      ),
    );
  }
}
