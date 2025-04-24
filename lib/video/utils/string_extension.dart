extension ColorExtension on String {
  bool compareString(String value) => toLowerCase() == value.toLowerCase();

  bool get isYoutubeVideoUrl =>
      contains('youtube.com/watch') || contains('youtu.be/');
}
