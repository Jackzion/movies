import 'package:movies/data/database/models/rules_model.dart';
import 'package:movies/data/models/source_rule.dart';

class PlayContext {
  /// Bangumi 条目 ID（历史/续播 key 以后用）
  final int animeId;

  /// 搜索结果标题（站内名）
  final String title;

  /// 命中的规则（UA/Referer/解析都靠它）
  final SourceRule? rule;

  /// 详情页绝对 URL（调试/回跳用）
  final String detailUrl;

  /// 线路列表：每条线路下是分集 **HTML 页** URL，不是 m3u8
  final List<Road> roads;

  /// 用户在详情页点的集号（1-based）；Sheet 未指定则为 null
  final int? preferredEpisode;

  PlayContext({
    required this.animeId,
    required this.title,
    required this.detailUrl,
    required this.roads,
    this.rule,              // ← 可选命名参数，不传就是 null
    this.preferredEpisode,
  });

  /// 解析「真正要播的集下标」：优先 preferredEpisode，否则第 1 集
  /// 返回 (roadIndex, episodeIndex)；无合法数据返回 null
  (int, int)? resolveStartIndices({int roadIndex = 0}) {
    if (roads.isEmpty) return null;
    // roadIndex 超界时取第 1 条
    final road = roads[roadIndex < roads.length ? roadIndex : 0];
    if (road.data.isEmpty) return null;

    // preferredEpisode -> roadIndex
    final ep = preferredEpisode;
    var episodeIndex = 0;
    if (ep != null && ep >= 1 && ep <= road.data.length) {
      episodeIndex = ep - 1;
    }
    return (roadIndex < roads.length ? roadIndex : 0, episodeIndex);
  }

    /// 按下标取分集页 URL
  String episodePageUrl(int roadIndex, int episodeIndex) {
    return roads[roadIndex].data[episodeIndex];
  }

  @override
  String toString() =>
      'PlayContext(${rule?.name} / $title / ${roads.length} 线路)';
}
