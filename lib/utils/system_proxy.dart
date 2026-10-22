import 'dart:io';

/// Windows 系统代理（WinINET / IE 设置）读取。
///
/// WebView2 走系统代理；youtube_explode 与 mpv 默认不走。
/// 取流签名绑定出口 IP，解析和播必须用同一条出口。
class SystemProxy {
  /// findProxy 字符串，例如 `PROXY 127.0.0.1:7890; DIRECT` 或 `DIRECT`
  static String findProxyRule() {
    final hostPort = resolveHostPort();
    if (hostPort == null) {
      return 'DIRECT';
    }
    return 'PROXY $hostPort; DIRECT';
  }

  /// 代理 `host:port`；无代理返回 null。
  static String? resolveHostPort() {
    if (!Platform.isWindows) {
      return _fromEnv();
    }
    final fromReg = _fromWindowsRegistry();
    return fromReg ?? _fromEnv();
  }

  /// mpv / media_kit 的 `http-proxy` 值（带 scheme）。
  static String? resolveMpvHttpProxy() {
    final hp = resolveHostPort();
    return hp == null ? null : 'http://$hp';
  }

  static String? _fromWindowsRegistry() {
    try {
      final r = Process.runSync('reg', [
        'query',
        r'HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings',
        '/v',
        'ProxyServer',
      ]);
      final out = r.stdout.toString();
      final m = RegExp(r'ProxyServer\s+REG_SZ\s+(\S+)').firstMatch(out);
      final raw = m?.group(1);
      if (raw == null || raw.isEmpty) {
        return null;
      }
      return _hostPort(raw);
    } catch (_) {
      return null;
    }
  }

  static String? _fromEnv() {
    final env = Platform.environment;
    final raw = env['HTTPS_PROXY'] ??
        env['https_proxy'] ??
        env['HTTP_PROXY'] ??
        env['http_proxy'];
    if (raw == null || raw.isEmpty) {
      return null;
    }
    return _hostPort(raw);
  }

  /// Dart findProxy 只认 `host:port`，去掉 scheme / path。
  static String _hostPort(String raw) {
    var s = raw.trim();
    s = s.replaceFirst(RegExp(r'^https?://'), '');
    final slash = s.indexOf('/');
    if (slash > 0) {
      s = s.substring(0, slash);
    }
    return s;
  }
}

/// 启动时调用：让进程内 `HttpClient`（Dio/AniList/图片等）统一走系统代理。
void applySystemProxy() {
  final rule = SystemProxy.findProxyRule();
  if (rule == 'DIRECT') {
    return;
  }
  HttpOverrides.global = _SystemProxyHttpOverrides(rule);
}

class _SystemProxyHttpOverrides extends HttpOverrides {
  _SystemProxyHttpOverrides(this._rule);
  final String _rule;

  @override
  HttpClient createHttpClient(SecurityContext? context) {
    final client = super.createHttpClient(context);
    client.findProxy = (_) => _rule;
    return client;
  }
}

