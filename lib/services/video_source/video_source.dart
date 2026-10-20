enum VideoSourceFormat {
  /// 让播放器自己猜（mp4 等）
  auto,

  /// 已确认是 HLS（m3u8）
  hls,
}

/// 视频解析结果：一次 resolve 的最终产物
class VideoSource{
  /// 真实媒体直链（mp4/m3u8 等）
  final String url;

  /// 格式；Windows 原生事件里 m3u8 走 hls，其余 auto
  final VideoSourceFormat format;
  
  const VideoSource(this.url, {this.format = VideoSourceFormat.auto});

  @override
  String toString() => 'VideoSource(url: $url, format: $format)';
}

/// 解析超时 Exception ， 用于提示用户等待时间过长
class VideoSourceTimeoutException implements Exception{
  final Duration timeout;
  const VideoSourceTimeoutException(this.timeout);

  @override
  String toString() => '视频解析超时(timeout: $timeout)';
}

/// 主动取消：换集、关页面、调用方 cancel()
class VideoSourceCanceledException implements Exception{
  const VideoSourceCanceledException();
  
  @override
  String toString() => '视频解析已取消';
}
 