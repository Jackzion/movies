import 'package:shared_preferences/shared_preferences.dart';

/// 本地存储工具类
/// 封装 SharedPreferences，提供类型安全的存储方法
class Prefs {
  /// SharedPreferences 实例
  final SharedPreferences preferences;

  const Prefs(this.preferences);

  // String 方法

  /// 存储字符串
  Future<void> setString(String key, String value) async {
    await preferences.setString(key, value);
  }

  /// 获取字符串
  String? getString(String key) {
    return preferences.getString(key);
  }

  // int 方法

  /// 存储整数
  Future<void> setInt(String key, int value) async {
    await preferences.setInt(key, value);
  }

  /// 获取整数
  int? getInt(String key) {
    return preferences.getInt(key);
  }

  // bool 方法

  /// 存储布尔值
  Future<void> setBool(String key, bool value) async {
    await preferences.setBool(key, value);
  }

  /// 获取布尔值
  bool? getBool(String key) {
    return preferences.getBool(key);
  }

  // double 方法

  /// 存储浮点数
  Future<void> setDouble(String key, double value) async {
    await preferences.setDouble(key, value);
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
}
