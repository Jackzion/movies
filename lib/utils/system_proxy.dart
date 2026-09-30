import 'dart:io';

/// 系统代理配置工具
/// Dart 的 HttpClient 不会自动使用系统代理，需手动读取并配置
/// 优先级：环境变量（HTTPS_PROXY 等）> Windows 注册表系统代理 > 直连
/// 通过 [HttpOverrides.global] 全局生效，覆盖 API 请求与图片加载

/// 读取系统代理，返回 HttpClient.findProxy 格式字符串
/// 如 'PROXY 127.0.0.1:7890'，未配置时返回 'DIRECT'
String detectSystemProxy() {
  final fromEnv = _fromEnv(Platform.environment);
  if (fromEnv != null) {
    return fromEnv;
  }
  if (Platform.isWindows) {
    final fromRegistry = _fromWindowsRegistry();
    if (fromRegistry != null) {
      return fromRegistry;
    }
  }
  return 'DIRECT';
}

/// 全局应用系统代理（需在 runApp 之前调用）
/// 之后创建的所有 HttpClient（dio、cached_network_image 等）均走代理
void applySystemProxy() {
  final proxy = detectSystemProxy();
  if (proxy == 'DIRECT') {
    return;
  }
  HttpOverrides.global = _ProxiedHttpOverrides(proxy);
}

/// 为 HttpClient 注入代理的 HttpOverrides
class _ProxiedHttpOverrides extends HttpOverrides {
  final String proxy;

  _ProxiedHttpOverrides(this.proxy);

  @override
  HttpClient createHttpClient(SecurityContext? context) {
    final client = super.createHttpClient(context);
    client.findProxy = (uri) {
      final host = uri.host;
      if (host == 'localhost' || host == '127.0.0.1' || host == '::1') {
        return 'DIRECT';
      }
      return proxy;
    };
    return client;
  }
}

/// 从环境变量读取代理地址
String? _fromEnv(Map<String, String> env) {
  final raw = env['HTTPS_PROXY'] ??
      env['https_proxy'] ??
      env['HTTP_PROXY'] ??
      env['http_proxy'];
  return _toFindProxy(raw);
}

/// 从 Windows 注册表读取系统代理（IE/WinINET 设置）
String? _fromWindowsRegistry() {
  try {
    final result = Process.runSync('reg', [
      'query',
      r'HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings',
    ]);
    if (result.exitCode != 0) {
      return null;
    }
    String? server;
    var enabled = false;
    for (final line in (result.stdout as String).split('\n')) {
      final lower = line.toLowerCase();
      if (lower.contains('proxyenable')) {
        enabled = line.trimRight().endsWith('0x1');
      } else if (lower.contains('proxyserver')) {
        server = line.trim().split(RegExp(r'\s+')).last;
      }
    }
    if (!enabled) {
      return null;
    }
    return _toFindProxy(server);
  } catch (_) {
    return null;
  }
}

/// 将代理地址转为 findProxy 格式
/// 支持 '127.0.0.1:7890' 与 'http=...;https=...;socks=...' 两种形式
String? _toFindProxy(String? raw) {
  if (raw == null) {
    return null;
  }
  var value = raw.trim();
  if (value.isEmpty) {
    return null;
  }
  if (value.contains('=')) {
    final map = <String, String>{};
    for (final part in value.split(';')) {
      final kv = part.split('=');
      if (kv.length == 2) {
        map[kv[0].trim().toLowerCase()] = kv[1].trim();
      }
    }
    value = map['https'] ?? map['http'] ?? '';
    if (value.isEmpty) {
      return null;
    }
  }
  value = value.replaceFirst(RegExp(r'^\w+://'), '');
  if (value.isEmpty) {
    return null;
  }
  return 'PROXY $value';
}
