import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/data/database/models/rules_model.dart';
import 'package:movies/data/models/source_rule.dart';
import 'package:movies/network/rule_engine.dart';
import 'package:movies/providers.dart';
import 'package:movies/services/video_source/video_source.dart';
import 'package:movies/ui/screens/source_sheet/source_import_dialog.dart';
import 'package:movies/ui/theme/theme.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

/// 视频播放页面
/// 使用 media_kit 播放预告片视频，支持播放控制
@RoutePage(name: 'VideoPageRoute')
class VideoPage extends ConsumerStatefulWidget {
  /// 视频 ID 或播放地址
  final String animeVideo;
  const VideoPage(this.animeVideo, {super.key});
  @override
  ConsumerState<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends ConsumerState<VideoPage> {
  late final Player player;
  late final VideoController controller;

  /// 浏览器打开番剧站某一集的播放页，复制地址栏整段 URL 粘到这里。
  /// 注意：必须是「分集播放页」，不是首页/详情页。
  static const String _testPageUrl =
      'https://www.agedm.io/play/20260322/2/1';

  /// 解析中标志：避免连点，也方便看按钮状态
  bool _parsing = false;

  /// Phase 3 调试：规则引擎测试中
  bool _ruleTesting = false;

  @override
  void initState() {
    super.initState();
    // 直接用 media_kit,Windows desktop 上最稳的视频方案
    // (pod_player 就是包了一层 media_kit,直接用更可控)
    player = Player();
    controller = VideoController(player);

    // 接住播放错误,避免卡死 UI
    player.stream.error.listen((String error) {
      debugPrint('Player error: $error');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('视频错误: $error')),
        );
      }
    });

    // 临时用 .mp4 直链测,先验证 media_kit 在 Windows desktop 上能跑
    // (bee.mp4 是 Flutter 官方测试视频)
    player.open(
      Media(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
      ),
    );
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  /// ===== Phase 1 临时调试：无头 WebView 取流 =====
  /// 点击后：分集页 URL → HeadlessWebview 钓 m3u8/mp4 → 控制台打印直链
  Future<void> _debugParseVideoSource() async {
    if (_parsing) return;
    setState(() => _parsing = true);

    // SnackBar 的 context 在 await 之后可能失效，先把 messenger 拿在手里
    final messenger = ScaffoldMessenger.of(context);
    messenger.showSnackBar(
      const SnackBar(content: Text('开始解析（最多等 10 秒）…')),
    );

    try {
      final service = ref.read(webviewVideoSourceServiceProvider);
      final source = await service.parseVideoSource(_testPageUrl);

      // 成功：直链打到 Debug Console / 终端
      debugPrint('[Phase1] resolved => ${source.url} (${source.format})');
      messenger.showSnackBar(
        const SnackBar(content: Text('拿到直链！详见 Run/Debug Console')),
      );

      // 可选：解析成功后直接丢给 media_kit 试播
      // （确认直链能播的话，把下面注释去掉）
      player.open(Media(source.url));
    } on VideoSourceTimeoutException catch (e) {
      // 超时：用户可感知的失败
      debugPrint('[Phase1] timeout: $e');
      messenger.showSnackBar(SnackBar(content: Text('解析超时：$e')));
    } on VideoSourceCanceledException {
      // 被取消（连点/换任务）：静默，不打扰用户
      debugPrint('[Phase1] cancelled (正常)');
    } catch (e) {
      // 其它错误：站点改版、网络失败、WebView 未就绪等
      debugPrint('[Phase1] error: $e');
      messenger.showSnackBar(SnackBar(content: Text('解析失败：$e')));
    } finally {
      if (mounted) {
        setState(() => _parsing = false);
      }
    }
  }

  /// ===== Phase 3 临时调试：RuleEngine 搜索 + 分集 =====
  /// Phase 2 已能导入规则：优先从仓库读；空则引导导入。
  Future<void> _debugRuleEngine() async {
    if (_ruleTesting || _parsing) return;
    setState(() => _ruleTesting = true);

    final messenger = ScaffoldMessenger.of(context);
    messenger.showSnackBar(
      const SnackBar(content: Text('Phase3：从仓库读规则并搜索…')),
    );

    try {
      final repo = await ref.read(rulesRepositoryProvider.future);
      final rules = repo.getAll();
      debugPrint('[Phase3] 已导入规则 ${rules.length} 条');

      if (rules.isEmpty) {
        messenger.showSnackBar(
          const SnackBar(
            content: Text('还没有规则：先 ⋮ → Sources → Import'),
          ),
        );
        // 空库时直接弹导入框，方便验收
        if (mounted) {
          await showSourceImportDialog(context);
        }
        return;
      }

      // 默认用第一条；也可改成 repo.getByName('7sefun')
      final SourceRule rule = rules.first;
      const keyword = '葬送的芙莉莲';
      debugPrint('[Phase3] 使用规则 ${rule.name}  搜索「$keyword」');

      final engine = RuleEngine();

      // ① 搜索
      final items = await engine.search(rule, keyword);
      debugPrint('[Phase3] 搜索命中 ${items.length} 条');
      for (final item in items.take(5)) {
        debugPrint('[Phase3]   - ${item.name} => ${item.src}');
      }

      // ② 对第一条拉线路/分集
      final roads = await engine.queryChapters(rule, items.first.src);
      debugPrint('[Phase3] 线路 ${roads.length} 条');
      for (final road in roads) {
        debugPrint('[Phase3]   ${road.name}: ${road.episodeCount} 集');
        if (road.data.isNotEmpty) {
          debugPrint(
            '[Phase3]     首集 ${road.identifier.first} ${road.data.first}',
          );
        }
      }

      // ③ 可选联调：把首集分集页丢给 Phase 1 无头取流
      String? probePage;
      if (roads.isNotEmpty && roads.first.data.isNotEmpty) {
        probePage = roads.first.data.first;
        debugPrint('[Phase3→1] 试解析分集页 $probePage');
        try {
          final source = await ref
              .read(webviewVideoSourceServiceProvider)
              .parseVideoSource(probePage);
          debugPrint('[Phase3→1] resolved => ${source.url} (${source.format})');
          // 拿到直链就试播（验证整条链路）
          await player.open(Media(source.url));
        } on VideoSourceTimeoutException {
          debugPrint('[Phase3→1] 取流超时（分集页可能改版/需登录）');
        } on VideoSourceCanceledException {
          debugPrint('[Phase3→1] 取流取消');
        } catch (e) {
          debugPrint('[Phase3→1] 取流失败: $e');
        }
      }

      if (!mounted) return;
      final buf = StringBuffer('规则 ${rule.name}：搜索 ${items.length} 条');
      if (roads.isNotEmpty) {
        buf.write('，线路 ${roads.length} / 首线路 ${roads.first.episodeCount} 集');
      }
      if (probePage != null) {
        buf.write('；已尝试取流');
      }
      messenger.showSnackBar(SnackBar(content: Text(buf.toString())));
    } on NoResultException catch (e) {
      debugPrint('[Phase3] NoResult: $e');
      if (mounted) {
        messenger.showSnackBar(SnackBar(content: Text('无结果：$e')));
      }
    } on ChapterEmptyException catch (e) {
      debugPrint('[Phase3] ChapterEmpty: $e');
      if (mounted) {
        messenger.showSnackBar(SnackBar(content: Text('无分集：$e')));
      }
    } on RuleEngineException catch (e) {
      debugPrint('[Phase3] EngineError: $e');
      if (mounted) {
        messenger.showSnackBar(SnackBar(content: Text('引擎错误：$e')));
      }
    } catch (e) {
      debugPrint('[Phase3] error: $e');
      if (mounted) {
        messenger.showSnackBar(SnackBar(content: Text('失败：$e')));
      }
    } finally {
      if (mounted) {
        setState(() => _ruleTesting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: screenBackground,
        // 教程这里写的是空函数 () {},按下没反应。改成 maybePop 真正返回上一页
          leading: BackButton(
            color: Colors.white,
            onPressed: () => context.router.maybePop(),
          ),
        centerTitle: false,
        title: Text('Back', style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: screenBackground,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ===== Phase 1 临时调试按钮（验收完可整段删除）=====
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _parsing ? null : _debugParseVideoSource,
                  icon: _parsing
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.travel_explore),
                  label: Text(_parsing ? '解析中…' : 'Phase1 测试取流'),
                ),
              ),
            ),
            // ===== Phase 3 临时调试按钮 =====
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _ruleTesting ? null : _debugRuleEngine,
                  icon: _ruleTesting
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.rule),
                  label: Text(_ruleTesting ? '引擎测试中…' : 'Phase3 测试搜索'),
                ),
              ),
            ),
            // ===== 临时调试结束 =====

            // 视频渲染区:Video widget + VideoController
            Expanded(
              child: Video(
                controller: controller,
                fit: BoxFit.contain,
                // 自带 Material 风格控件(播放/暂停/进度条)
                controls: (VideoState state) {
                  return MaterialVideoControls(state);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
