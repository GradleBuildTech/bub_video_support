import 'dart:async';

import 'package:flutter/material.dart';

import '../utils/video_constant.dart';
import '../video_factory.dart';

// ignore: must_be_immutable
class VideoContainer extends StatefulWidget {
  final Widget? w;

  final Completer<void>? completer;

  final String? videoUrl;

  final String? suibTitle;

  final String? title;

  final Function()? onDimiss;

  const VideoContainer({
    super.key,
    this.w,
    this.completer,
    this.videoUrl,
    this.suibTitle,
    this.title,
    this.onDimiss,
  });

  @override
  State<VideoContainer> createState() => VideoContainerState();
}

class VideoContainerState extends State<VideoContainer> {
  double? _postionTop = 0;

  double? _positionLeft = 0;

  bool _displayVideo = true;

  @override
  void initState() {
    super.initState();
  }

  void _onPopUpTap() {
    if (_postionTop == 0) return;
    setState(() {
      _postionTop = 0;
      _displayVideo = true;
    });
  }

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    setState(() {
      _displayVideo = false;
      _postionTop = details.globalPosition.dy - 40;
    });
  }

  void _onVerticalDragEnd(DragEndDetails details) {
    if (_postionTop == null) return;
    setState(() {
      _displayVideo = true;
      if (_postionTop! > context.screenHeight / 2) {
        _postionTop = context.screenHeight -
            kMinLimitVideoPopup -
            (context.bottomHeight + (kToolbarHeight / 2));
      } else {
        _postionTop = 0;
      }
    });
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    if (_postionTop ==
        context.screenHeight -
            kMinLimitVideoPopup -
            (context.bottomHeight + (kToolbarHeight / 2))) {
      setState(() {
        _positionLeft = details.globalPosition.dx - 100;
      });
    } else {
      setState(() {
        _positionLeft = 0;
      });
    }
  }

  void _onHorizontalDragEnd(DragEndDetails details) {}

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          _buildVideoField(context),
          if (_postionTop == 0) ...[
            Align(
              alignment: Alignment.topLeft,
              child: BuildBackButton(onPressed: () => widget.onDimiss?.call()),
            ),
            Positioned(
              top: context.screenWidth / 1.6,
              child: Container(
                width: context.screenWidth,
                height: context.screenHeight -
                    (kBottomNavigationBarHeight + kPosHeight + kToolbarHeight),
                color: context.themeColor.scaffoldBackground,
                child: widget.w,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildVideoField(BuildContext context) {
    return AnimatedPositioned(
      left: _positionLeft ?? 0,
      top: _postionTop ?? 0,
      duration: const Duration(milliseconds: 40),
      child: GestureDetector(
        onTap: _onPopUpTap,
        onVerticalDragUpdate: _onVerticalDragUpdate,
        onVerticalDragEnd: _onVerticalDragEnd,
        // onHorizontalDragUpdate: _onHorizontalDragUpdate,
        // onHorizontalDragEnd: _onHorizontalDragEnd,
        child: _ViewVideoComponent(
          url: widget.videoUrl,
          title: widget.title,
          subTitle: widget.suibTitle,
          fullWidth: context.screenWidth,
          fullHeight: context.screenHeight,
          postionTop: _postionTop ?? 0,
          displayVideo: _displayVideo,
        ),
      ),
    );
  }
}

class _ViewVideoComponent extends StatefulWidget {
  final String? url;
  final String? title;
  final String? subTitle;

  final double fullHeight;
  final double fullWidth;
  final double postionTop;

  final bool displayVideo;
  const _ViewVideoComponent(
      {this.url,
      this.title,
      this.subTitle,
      required this.displayVideo,
      required this.fullWidth,
      required this.fullHeight,
      required this.postionTop});
  @override
  State<_ViewVideoComponent> createState() => __ViewVideoComponentState();
}

class __ViewVideoComponentState extends State<_ViewVideoComponent> {
  TextStyle? get _titleStyle =>
      context.textTheme.titleLarge?.w600.ellipsis.copyWith(color: Colors.white);

  TextStyle? get _subTitleStyle =>
      context.textTheme.titleSmall?.w400.ellipsis.copyWith(color: Colors.white);

  String? _thumbNail = "";

  double? _width;

  double? _height;

  double get width => _width ?? widget.fullWidth;

  double get height => _height ?? (widget.fullWidth / 1.6);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.url != null) {
        setState(() {
          _thumbNail = VideoHelper.getYoutubeThumbnail(widget.url!);
        });
      }
    });
  }

  @override
  void didUpdateWidget(covariant _ViewVideoComponent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.postionTop != oldWidget.postionTop) {
      setState(() {
        final changeWidth =
            ((widget.fullHeight - widget.postionTop) / (widget.fullHeight)) *
                widget.fullWidth;
        if ((changeWidth / 1.6) >= kMinLimitVideoPopup) {
          _width = changeWidth;
          _height = (changeWidth / 1.6) < kMinLimitVideoPopup
              ? kMinLimitVideoPopup
              : changeWidth / 1.6;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.screenWidth,
      height: height,
      color: context.themeColor.hintColor.withOpacity(0.86),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (_thumbNail?.isNotEmpty ?? false)
            VideoFactory.createVideoComponent(
              videoUrl: widget.url.orEmpty,
              onTap: () {},
              thumbNail: _thumbNail,
              width: width,
              height: height,
              videoListner: ({isFullScreen, position}) {},
            ),
          if (!(width == widget.fullWidth)) ...[
            const SizedBox(width: LayoutConstants.spacingVertical),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(widget.title ?? "", style: _titleStyle, maxLines: 1),
                  if (widget.subTitle?.isNotEmpty ?? false) ...[
                    const SizedBox(height: LayoutConstants.spacingVertical),
                    Text(widget.subTitle ?? "",
                        style: _subTitleStyle, maxLines: 2),
                  ]
                ],
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () => VideoComponent.dismiss(),
                icon: const Icon(Icons.close, color: Colors.white, size: 16.0),
              ),
            )
          ],
        ],
      ),
    );
  }
}
