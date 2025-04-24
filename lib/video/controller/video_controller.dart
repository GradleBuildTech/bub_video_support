import 'package:edu_code_league_mobile/data/object/entities/lessons/lesson.dart';
import 'package:flutter/material.dart';

enum VideoStatus { play, pause, stop }

//Singleton class
class VideoController {
  static final VideoController _instance = VideoController._internal();

  static VideoController get instance => _instance;

  factory VideoController() {
    return _instance;
  }

  VideoController._internal();

  // Add your properties and methods here
  VideoStatus status = VideoStatus.stop;

  Duration currentPosition = Duration.zero;

  String videoUrl = "";

  String videoTitle = "";

  String subVideoTitle = "";

  Lesson? lesson;

  GlobalKey<State>? screenControlKey;

  ///[Action]
  void play() => status = VideoStatus.play;

  void pause() => status = VideoStatus.pause;

  void stop() => status = VideoStatus.stop;

  void seekTo(Duration position) {
    currentPosition = position;
  }

  void setVideoUrl(String url) {
    videoUrl = url;
  }

  void setVideoTitle(String title) {
    videoTitle = title;
  }

  void setSubVideoTitle(String title) {
    subVideoTitle = title;
  }

  void setLesson(Lesson lesson) {
    this.lesson = lesson;
    videoUrl = lesson.videoURL ?? "";
    videoTitle = lesson.title ?? "";
  }

  void setScreenControlKey(GlobalKey<State>? key) {
    screenControlKey = key;
  }

  void reset() {
    status = VideoStatus.stop;
    videoUrl = "";
    videoTitle = "";
    subVideoTitle = "";
    currentPosition = Duration.zero;
    lesson = null;
  }
}
