/// 搜索结果一条：详情页
class SearchItem {
  /// 页面上显示的标题
  final String name;

  /// 详情页**绝对** URL（后面 queryChapters 用）
  final String src;

  const SearchItem({required this.name, required this.src});

  @override
  String toString() => 'SearchItem($name)';
}

/// 一条播放线路（站内「线路1 / 线路2」）
class Road {
  /// 线路名，例如 '播放线路1'
  final String name;

  /// 该线路下每一集的分集页**绝对** URL，下标 = 集号-1 或与 identifier 对齐
  final List<String> data;

  /// 集名列表（'第01话' 等），长度通常与 data 相同
  final List<String> identifier;

  const Road({
    required this.name,
    required this.data,
    required this.identifier,
  });

  /// 集数（若 identifier 与 data 等长，优先用 identifier 数量）
  int get episodeCount => data.length;

  @override
  String toString() => 'Road($name, ${data.length} 集)';
}

/// 搜索结果为空
class NoResultException implements Exception {
  final String message;
  const NoResultException([this.message = '没有搜索结果']);

  @override
  String toString() => message;
}

/// 没有任何有效线路 / 分集（详情页 XPath 失效或页面异常）
class ChapterEmptyException implements Exception {
  final String message;
  const ChapterEmptyException([this.message = '没有有效线路 / 分集']);

  @override
  String toString() => message;
}

/// HTTP 或 HTML 结构异常（站点改版、超时、非 HTML 响应等）
class RuleEngineException implements Exception {
  final String message;
  final Object? cause;
  const RuleEngineException(this.message, {this.cause});

  @override
  String toString() => cause == null ? message : '$message ($cause)';
}
