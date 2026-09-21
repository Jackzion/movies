import 'package:dio/dio.dart';

/// Jikan API 基础地址
const String jikanApiUrl = 'https://api.jikan.moe/v4/';

/// 动漫 API 端点
const topAnimeUrl = 'top/anime';
const searchAnimeUrl = 'anime';
const animeUrl = 'anime';

/// 分页参数名
const pageParameterName = 'page';
const limitParameterName = 'limit';
const qParameterName = 'q';
const filterParameterName = 'filter';
const orderParameterName = 'order_by';
const sortParameterName = 'sort';

/// Jikan API 服务类
/// 使用 dio 进行网络请求
class AnimeAPIService {
  /// Dio 实例
  late final Dio dio;

  /// 是否显示调试信息
  final showDebugInfo = false;

  /// 构造函数，初始化 Dio
  AnimeAPIService() {
    configureDio();
  }

  /// 配置 Dio 参数
  void configureDio() {
    final options = BaseOptions(
      baseUrl: jikanApiUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    dio = Dio(options);

    // 添加拦截器
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
          // Jikan API 无需 API Key，直接发送请求
          return handler.next(options);
        },
        onResponse: (Response response, ResponseInterceptorHandler handler) {
          // 处理响应数据
          return handler.next(response);
        },
        onError: (DioException error, ErrorInterceptorHandler handler) {
          // 处理错误
          print('API Error: ${error.message}');
          return handler.next(error);
        },
      ),
    );

    // 添加日志拦截器（仅在调试模式下）
    if (showDebugInfo) {
      dio.interceptors.add(LogInterceptor(
        responseBody: true,
        error: true,
        request: true,
        requestHeader: true,
        responseHeader: true,
      ));
    }
  }

  /// 上次请求时间，用于速率限制
  DateTime _lastRequestTime = DateTime.fromMillisecondsSinceEpoch(0);

  /// 确保请求间隔至少 1 秒（Jikan API 限制每秒 3 次）
  Future<void> _rateLimit() async {
    final now = DateTime.now();
    final elapsed = now.difference(_lastRequestTime);
    if (elapsed < Duration(milliseconds: 1000)) {
      await Future.delayed(Duration(milliseconds: 1000 - elapsed.inMilliseconds));
    }
    _lastRequestTime = DateTime.now();
  }

  /// 获取热门动漫列表（返回原始 Response）
  Future<Response> getTopAnime({int page = 1, int limit = 10}) async {
    await _rateLimit();
    return dio.get(
      topAnimeUrl,
      queryParameters: {
        pageParameterName: page,
        limitParameterName: limit,
      },
    );
  }

  /// 搜索动漫（返回原始 Response）
  Future<Response> searchAnime(String query, {int page = 1, int limit = 10}) async {
    await _rateLimit();
    return dio.get(
      searchAnimeUrl,
      queryParameters: {
        qParameterName: query,
        pageParameterName: page,
        limitParameterName: limit,
      },
    );
  }

  /// 获取动漫详情（返回原始 Response）
  Future<Response> getAnimeDetail(int id) async {
    await _rateLimit();
    return dio.get('$animeUrl/$id');
  }

  /// 获取当前正在播出的动漫（返回原始 Response）
  Future<Response> getCurrentlyAiring({int page = 1, int limit = 10}) async {
    await _rateLimit();
    return dio.get(
      topAnimeUrl,
      queryParameters: {
        pageParameterName: page,
        limitParameterName: limit,
        filterParameterName: 'airing',
      },
    );
  }

  /// 获取即将播出的动漫（返回原始 Response）
  Future<Response> getUpcoming({int page = 1, int limit = 10}) async {
    await _rateLimit();
    return dio.get(
      topAnimeUrl,
      queryParameters: {
        pageParameterName: page,
        limitParameterName: limit,
        filterParameterName: 'upcoming',
      },
    );
  }

  /// 获取本季动漫（返回原始 Response）
  Future<Response> getSeasonNow({int page = 1, int limit = 10}) async {
    await _rateLimit();
    return dio.get(
      'seasons/now',
      queryParameters: {
        pageParameterName: page,
        limitParameterName: limit,
      },
    );
  }
}
