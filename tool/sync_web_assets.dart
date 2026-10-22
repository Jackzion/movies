// 从 pub 缓存同步 Web 端 Drift 资源到 web/，避免把二进制提交进 git。
//
// 用法：
//   flutter pub get
//   dart run tool/sync_web_assets.dart
//
// 同步产物（已 gitignore，勿提交）：
//   web/drift_worker.js
//   web/sqlite3.wasm
import 'dart:convert';
import 'dart:io';

Future<void> main(List<String> args) async {
  final root = Directory.current;
  final packageConfigFile = File.fromUri(
    root.uri.resolve('.dart_tool/package_config.json'),
  );
  if (!packageConfigFile.existsSync()) {
    stderr.writeln('未找到 .dart_tool/package_config.json，请先执行 flutter pub get');
    exit(1);
  }

  final packageConfig =
      jsonDecode(packageConfigFile.readAsStringSync()) as Map<String, dynamic>;
  final packages = (packageConfig['packages'] as List).cast<Map<String, dynamic>>();

  Uri? packageRoot(String name) {
    for (final pkg in packages) {
      if (pkg['name'] == name) {
        return Uri.parse(pkg['rootUri'] as String);
      }
    }
    return null;
  }

  final driftRoot = packageRoot('drift');
  if (driftRoot == null) {
    stderr.writeln('package_config 中未找到 drift，请检查 pubspec 依赖');
    exit(1);
  }

  final driftDir = Directory.fromUri(driftRoot);
  final webDir = Directory.fromUri(root.uri.resolve('web/'));
  if (!webDir.existsSync()) {
    webDir.createSync(recursive: true);
  }

  final copies = <String, String>{
    // drift 包根目录自带编译好的 worker
    'drift_worker.js': pJoin(driftDir, 'drift_worker.js'),
    // drift 附带的 sqlite3 WASM（与 worker 同版本配套）
    'sqlite3.wasm': pJoin(
      driftDir,
      'extension',
      'devtools',
      'build',
      'sqlite3.wasm',
    ),
  };

  for (final entry in copies.entries) {
    final name = entry.key;
    final srcPath = entry.value;
    final src = File(srcPath);
    final dest = File.fromUri(webDir.uri.resolve(name));

    if (!src.existsSync()) {
      stderr.writeln('源文件不存在: $srcPath');
      stderr.writeln('请确认 drift 包版本是否包含该资源，或改从 GitHub Releases 下载。');
      exit(1);
    }

    dest.parent.createSync(recursive: true);
    src.copySync(dest.path);
    final kb = (dest.lengthSync() / 1024).toStringAsFixed(1);
    stdout.writeln('已同步 $name ($kb KB) -> ${dest.path}');
  }

  stdout.writeln('完成。这些文件已由 .gitignore 忽略，不需要提交进仓库。');
}

String pJoin(Directory dir, String a, [String? b, String? c, String? d, String? e]) {
  final parts = <String>[dir.path, a];
  if (b != null) parts.add(b);
  if (c != null) parts.add(c);
  if (d != null) parts.add(d);
  if (e != null) parts.add(e);
  return parts.join(Platform.pathSeparator);
}
