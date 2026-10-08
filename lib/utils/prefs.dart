import 'dart:convert';

import 'package:movies/data/models/anime_image_configuration.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 本地存储工具类
/// 封装 SharedPreferences，提供类型安全的存储方法
class Prefs {
  /// SharedPreferences 实例
  final SharedPreferences preferences;

  const Prefs(this.preferences);

  // String 方法

  /// 存储字符串
  void setString(String key, String value) {
    preferences.setString(key, value);
  }

  /// 获取字符串
  String? getString(String key) {
    return preferences.getString(key);
  }

  // int 方法

  /// 存储整数
  void setInt(String key, int value) {
    preferences.setInt(key, value);
  }

  /// 获取整数
  int? getInt(String key) {
    return preferences.getInt(key);
  }

  // bool 方法

  /// 存储布尔值
  void setBool(String key, bool value) {
    preferences.setBool(key, value);
  }

  /// 获取布尔值
  bool? getBool(String key) {
    return preferences.getBool(key);
  }

  // double 方法

  /// 存储浮点数
  void setDouble(String key, double value) {
    preferences.setDouble(key, value);
  }

  /// 获取浮点数
  double? getDouble(String key) {
    return preferences.getDouble(key);
  }

  // 便捷方法

  /// 删除指定键
  Future<bool> remove(String key) async {
    return await preferences.remove(key);
  }

  /// 清空所有数据
  Future<bool> clear() async {
    return await preferences.clear();
  }

  /// 检查是否包含指定键
  bool containsKey(String key) {
    return preferences.containsKey(key);
  }

  // 图片配置（对标 TMDB configuration，本地缓存）

  static const String _imageConfigKey = 'anime_image_configuration';

  /// 保存动漫图片配置
  Future<void> setImageConfiguration(AnimeImageConfiguration config) {
    return preferences.setString(_imageConfigKey, jsonEncode(config.toJson()));
  }

  /// 读取动漫图片配置，未缓存时返回 null
  AnimeImageConfiguration? getImageConfiguration() {
    final raw = preferences.getString(_imageConfigKey);
    if (raw == null || raw.isEmpty) return null;
    try {
      return AnimeImageConfiguration.fromJson(
        jsonDecode(raw) as Map<String, dynamic>,
      );
    } catch (_) {
      return null;
    }
  }
}
