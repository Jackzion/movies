
import 'dart:convert';

import 'package:movies/data/models/source_rule.dart';

/// 导入结果
class RuleImportResult {
  /// 导入后解析成功的规则
  final List<SourceRule> rules;

  /// 每条失败的原因，例如「第 2 条：searchURL 必须包含 @keyword」
  final List<String> failures;

  /// 同名被覆盖的次数（仅提示用）
  final int duplicateCount;

  const RuleImportResult({  
    required this.rules,
    required this.failures,
    required this.duplicateCount,
  });

  int get failureCount => failures.length;
  int get successCount => rules.length;
}

/// 规则导入解析器
class RuleImportParser {
  // 私有构造函数，外部不能实例化
  const RuleImportParser._();

  // 解析规则 JSON 字符串 -> 导入结果 RuleImportResult
  static RuleImportResult parse(String sourceJson) {
    final value = sourceJson.trim();

    if (value.isEmpty) {
      return RuleImportResult(
        rules: const [],
        failures: const ['输入为空'],
        duplicateCount: 0,
      );
    }

    final parsed = <SourceRule>[];
    final failures = <String>[];

     // —— 形态 1&2：整体是 JSON（对象或数组）——
    Object? jsonValue;
    var decodedAsJson = false;
    try {
      jsonValue = json.decode(value);
      decodedAsJson = true;
    } on FormatException {
      // 不是整体 json ， 走形态3
    }
    if(decodedAsJson){
      // 整体是 JSON，解析为规则列表
      if(jsonValue is List){
        for(var i = 0; i < jsonValue.length; i++){
          _parseEntity(jsonValue[i],i+1,parsed,failures);
        }
      }
      else{
        _parseEntity(jsonValue, 1, parsed, failures);
      }
    }else{
      // —— 形态 3：多行文本 / kazumi:// 链接 ——
      final entries = _splitPlainEntries(value).toList();
      if (entries.isEmpty) {
        failures.add('未找到有效的 JSON 或 kazumi:// 规则链接');
      }
      else{
        for(var i = 0; i < entries.length; i++){
          _parseEntity(entries[i],i+1,parsed,failures);
        }
      }
    }

    // 同名覆盖: nameKey 小写
    final unique = <String, SourceRule>{};
    var duplicateCount = 0;
    for (final rule in parsed) {
      final nameKey = rule.name.toLowerCase();
      // 发现同名， duplicateCount 加 1 , 并覆盖旧规则
      if (unique.containsKey(nameKey)) {
        duplicateCount++;
      }
      unique[nameKey] = rule;
    }
    // 重置 parsed 列表，只保留唯一规则
    parsed.clear();
    parsed.addAll(unique.values);
    // 返回导入结果
    return RuleImportResult(
      rules: parsed,
      failures: failures,
      duplicateCount: duplicateCount,
    );
  }
  
  static void _parseEntity(Object? entry, int i, List<SourceRule> parsed, List<String> failures) {
    try{
      if(entry is FormatException){
        failures.add('第 $i 条：${entry.message}');
        return;
      }
      if(entry is! Map){
        failures.add('第 $i 条：不是 JSON 对象');
        return;
      }
      final rule = SourceRule.fromJson(Map<String, dynamic>.from(entry));
      final error = rule.validate();
      if(error != null){
        failures.add('第 $i 条：$error');
        return;
      }
      parsed.add(rule);
    }catch (e) {
      failures.add('第 $i 条：$e');
    }
  }
}

/// —— kazumi:// base64 工具（精简自 Kazumi utils/encoding.dart）——
/// `kazumi://BASE64` → 原始 JSON 字符串
/// 支持标准 Base64 与 URL-safe Base64
final _schemePattern = RegExp(r'kazumi:(?://)?', caseSensitive: false);

String kazumiBase64ToJson(String kazumiBase64Str) {
  final input = kazumiBase64Str.trim();
  final match = _schemePattern.matchAsPrefix(input);
  if (match == null) {
    throw const FormatException('Invalid Kazumi rule link');
  }
  var payload = input.substring(match.end);
  try {
    payload = Uri.decodeComponent(payload);
  } catch (_) {
    throw const FormatException('Invalid encoding in Kazumi rule link');
  }
  payload = payload.replaceAll(RegExp(r'\s'), '');
  if (payload.isEmpty) {
    throw const FormatException('Kazumi rule link is empty');
  }
  // 同时接受标准 Base64 与 URL-safe Base64
  final normalized = base64.normalize(
    payload.replaceAll('-', '+').replaceAll('_', '/'),
  );
  try {
    return utf8.decode(base64.decode(normalized));
  } catch (_) {
    throw const FormatException('Invalid Kazumi rule link payload');
  }
}

/// 原始 JSON 字符串 → `kazumi://BASE64`（导出/调试用）
String jsonToKazumiBase64(String jsonStr) {
  return 'kazumi://${base64Encode(utf8.encode(jsonStr))}';
}

/// 多行文本：每行可能是完整 JSON 对象，也可能是 kazumi:// 链接
Iterable<Object?> _splitPlainEntries(String input) sync* {
    for (final line in input.split(RegExp(r'\r?\n'))) {
      final t = line.trim();
      if (t.isEmpty) continue;
      // json 对象 yield 直接返回作为 iterable 的 item
      if (t.startsWith('{') || t.startsWith('[')) {
        try {
          yield json.decode(t);
          continue;
        } catch (_) {
          // 落到下面按链接处理
        }
      }
      if (t.toLowerCase().startsWith('kazumi:')) {
        try {
          final raw = kazumiBase64ToJson(t);
          yield json.decode(raw);
        } catch (e) {
          yield FormatException('kazumi:// 解码失败: $e');
        }
        continue;
      }
      // 既不是 JSON 也不是链接：当作错误条目
      yield FormatException('无法识别的行（需要 JSON 或 kazumi://）');
    }
}