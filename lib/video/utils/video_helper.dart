import 'package:bub_video_support/video/utils/video_constant.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoHelper {
  static String? getYoutubeVideoId(String url) {
    try {
      return YoutubePlayer.convertUrlToId(url);
    } on Exception catch (_) {
      return null;
    } catch (error) {
      return null;
    }
  }

  static String? getYoutubeThumbnail(String url,
      {String quality = kDefaultThumbnail}) {
    try {
      String? videoId = getYoutubeVideoId(url);
      if (videoId != null) {
        return '$kDefaultYtbThumbnailUrl$videoId/$quality';
      }
    } on Exception catch (_) {
      return null;
    } catch (error) {
      return null;
    }
    return null;
  }
}
