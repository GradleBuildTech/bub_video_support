import 'package:flutter/material.dart';

import '../video_factory.dart';

class BuildVideoLayout extends StatefulWidget {
  final bool isLoading;
  final List<Widget> listWidget;
  final String videoUrl;
  final String? videoTitle;
  final String? subVideoTitle;
  const BuildVideoLayout({
    super.key,
    this.isLoading = false,
    this.videoTitle,
    this.subVideoTitle,
    required this.videoUrl,
    this.listWidget = const [],
  });

  @override
  State<BuildVideoLayout> createState() => _BuildVideoLayoutState();
}

class _BuildVideoLayoutState extends State<BuildVideoLayout> {
  late ScrollController _scrollController;

  Color get _scaffoldBackgroundColor => context.themeColor.scaffoldBackground;

  @override
  void initState() {
    _scrollController = ScrollController()..addListener(_scrollListner);

    super.initState();
  }

  void _scrollListner() {}

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListner);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BuildTemplateScreenStackScroll(
      color: _scaffoldBackgroundColor,
      scrollController: _scrollController,
      sliverAppBar: _buildAppBar(),
      children: [...widget.listWidget.map((e) => SliverToBoxAdapter(child: e))],
    );
  }

  Widget _buildAppBar() {
    return BuildSliverAppBar(
      title: const [BuildBackButton()],
      pinned: true,
      floating: false,
      elevation: 0.8,
      backgroundColor: _scaffoldBackgroundColor,
      expandedHeight: LayoutConstants.sliverExpandAppBarHeight,
      widgetExpanded: widget.isLoading
          ? BuildSkeleton.rounded(
              width: double.infinity,
              height: double.infinity,
              borderRadius: BorderRadius.circular(0))
          : VideoFactory.createVideoComponent(
              videoUrl: widget.videoUrl,
              onTap: () {},
              videoListner: ({isFullScreen, position}) {},
            ),
    );
  }
}
