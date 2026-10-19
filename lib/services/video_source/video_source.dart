enum VideoSourceFormat {
  /// 让播放器自己猜（mp4 等）
  auto,

  /// 已确认是 HLS（m3u8）
  hls,
}

// 视频解析结果
class VideoSource{
  final String url;
  const VideoSource(this.url);

  @override
  String toString() => url;
}