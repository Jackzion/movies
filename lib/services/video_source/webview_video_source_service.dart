import 'package:movies/services/video_source/video_source.dart';

/// WebView 取流服务（占位，Phase 1 补全）
/// 目标：输入「分集页 URL」→ 输出「m3u8/mp4 直链」
class WebviewVideoSourceService{
  Future<VideoSource> parseVideoSource(String url) async{
    throw UnimplementedError('Phase 1 实现');
  }

  Future<void> dispose() async{
    throw UnimplementedError('Phase 1 实现');
  }
}