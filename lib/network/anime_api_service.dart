import 'package:dio/dio.dart';
import 'package:movies/data/models/anime.dart';
import 'package:movies/data/models/anime_response.dart';

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

  /// 获取热门动漫列表
  Future<List<Anime>> getTopAnime({int page = 1, int limit = 10}) async {
    try {
      final response = await dio.get(
        topAnimeUrl,
        queryParameters: {
          pageParameterName: page,
          limitParameterName: limit,
        },
      );

      if (response.statusCode == 200) {
        final animeResponse = AnimeResponse.fromJson(response.data);
        return animeResponse.data;
      } else {
        throw Exception('Failed to load top anime');
      }
    } catch (e) {
      throw Exception('Failed to load top anime: $e');
    }
  }

  /// 搜索动漫
  Future<List<Anime>> searchAnime(String query, {int page = 1, int limit = 10}) async {
    try {
      final response = await dio.get(
        searchAnimeUrl,
        queryParameters: {
          qParameterName: query,
          pageParameterName: page,
          limitParameterName: limit,
        },
      );

      if (response.statusCode == 200) {
        final animeResponse = AnimeResponse.fromJson(response.data);
        return animeResponse.data;
      } else {
        throw Exception('Failed to search anime');
      }
    } catch (e) {
      throw Exception('Failed to search anime: $e');
    }
  }

  /// 获取动漫详情
  Future<Anime> getAnimeDetail(int id) async {
    try {
      final response = await dio.get('$animeUrl/$id');

      if (response.statusCode == 200) {
        return Anime.fromJson(response.data['data']);
      } else {
        throw Exception('Failed to load anime detail');
      }
    } catch (e) {
      throw Exception('Failed to load anime detail: $e');
    }
  }

  /// 获取当前正在播出的动漫
  Future<List<Anime>> getCurrentlyAiring({int page = 1, int limit = 10}) async {
    try {
      final response = await dio.get(
        topAnimeUrl,
        queryParameters: {
          pageParameterName: page,
          limitParameterName: limit,
          filterParameterName: 'airing',
        },
      );

      if (response.statusCode == 200) {
        final animeResponse = AnimeResponse.fromJson(response.data);
        return animeResponse.data;
      } else {
        throw Exception('Failed to load currently airing anime');
      }
    } catch (e) {
      throw Exception('Failed to load currently airing anime: $e');
    }
  }

  /// 获取即将播出的动漫
  Future<List<Anime>> getUpcoming({int page = 1, int limit = 10}) async {
    try {
      final response = await dio.get(
        topAnimeUrl,
        queryParameters: {
          pageParameterName: page,
          limitParameterName: limit,
          filterParameterName: 'upcoming',
        },
      );

      if (response.statusCode == 200) {
        final animeResponse = AnimeResponse.fromJson(response.data);
        return animeResponse.data;
      } else {
        throw Exception('Failed to load upcoming anime');
      }
    } catch (e) {
      throw Exception('Failed to load upcoming anime: $e');
    }
  }
}
