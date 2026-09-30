import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies/data/models/anime_details.dart';
import 'package:movies/data/models/genre.dart';
import 'package:movies/utils/utils.dart';

/// 动漫简介组件
/// 参考 Bangumi 详情页：元信息 + 章节按钮 + 简介 + 标签胶囊
class AnimeOverview extends StatefulWidget {
  /// 动漫详情数据
  final AnimeDetails details;

  /// 上移量（兼容旧参数；新布局作为独立面板使用，不再压在封面渐变上）
  final double overlapHeight;

  const AnimeOverview({
    super.key,
    required this.details,
    this.overlapHeight = 0,
  });

  @override
  State<AnimeOverview> createState() => _AnimeOverviewState();
}

class _AnimeOverviewState extends State<AnimeOverview>
    with SingleTickerProviderStateMixin {
  /// 动画控制器，控制类型标签滑入动画
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..forward();

  /// 偏移动画，从屏幕右侧滑入到正常位置
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: const Offset(1.0, 0.0),
    end: Offset.zero,
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.elasticOut,
  ));

  /// 是否展开全部章节
  bool _expandedChapters = false;

  /// 标签区是否展开全部
  bool _expandedTags = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// 章节序号补零，如 1 → 01
  String _pad(int n) => n.toString().padLeft(2, '0');

  @override
  Widget build(BuildContext context) {
    final details = widget.details;
    final genres = details.genres ?? <Genre>[];
    final synopsis = details.synopsis ?? '';
    final synopsisLines = _splitSynopsis(synopsis);
    final episodes = details.episodes;

    return Container(
      color: const Color(0xFF2B2B2B),
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // ===== 元信息：中文名 / 话数 =====
          _MetaLine(
            label: '中文名',
            value: details.displayTitle,
          ),
          if (episodes != null) ...[
            addVerticalSpace(8),
            _MetaLine(label: '话数', value: '$episodes'),
          ],

          if (episodes != null && episodes > 0) ...[
            addVerticalSpace(16),
            _buildChapterHeader(context),
            addVerticalSpace(12),
            _buildChapterButtons(context, episodes),
          ],

          const Divider(
            height: 1,
            thickness: 1,
            color: Color(0xFF3D3D3D),
          ),
          addVerticalSpace(20),

          // ===== 简介 =====
          if (synopsisLines.isNotEmpty)
            for (final line in synopsisLines) ...[
              _DescText(line),
              addVerticalSpace(4),
            ],

          // ===== 标签区 =====
          if (genres.isNotEmpty) ...[
            addVerticalSpace(12),
            _buildTagBox(context, genres),
          ],
        ],
      ),
    );
  }

  /// 章节列表标题行：「章节列表 [全部]」
  Widget _buildChapterHeader(BuildContext context) {
    final episodes = widget.details.episodes ?? 0;
    final showToggle = episodes > 12;

    return Row(
      children: [
        Text(
          '章节列表',
          style: GoogleFonts.notoSansSc(
            fontSize: 15,
            color: const Color(0xFFC9C9C9),
          ),
        ),
        if (showToggle) ...[
          const SizedBox(width: 6),
          GestureDetector(
            onTap: () => setState(() => _expandedChapters = !_expandedChapters),
            child: Text(
              _expandedChapters ? '[收起]' : '[全部]',
              style: GoogleFonts.notoSansSc(
                fontSize: 15,
                color: const Color(0xFF6FB0E8),
              ),
            ),
          ),
        ],
      ],
    );
  }

  /// 章节按钮网格（蓝色渐变胶囊）
  Widget _buildChapterButtons(BuildContext context, int episodes) {
    final limit = _expandedChapters || episodes <= 12 ? episodes : 12;
    final shown = episodes.clamp(1, limit);

    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: [
        for (var n = 1; n <= shown; n++)
          _ChapterButton(label: _pad(n), onTap: () {}),
      ],
    );
  }

  /// 标签信息盒：引导文案 + 胶囊标签
  Widget _buildTagBox(BuildContext context, List<Genre> genres) {
    const maxVisible = 12;
    final visible =
        _expandedTags || genres.length <= maxVisible ? genres : genres.sublist(0, maxVisible);
    final hasMore = genres.length > maxVisible;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 13, 14, 14),
      decoration: BoxDecoration(
        color: const Color(0xFF343434),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '大家将 ${widget.details.displayTitle} 标注为',
            style: GoogleFonts.notoSansSc(
              fontSize: 14,
              height: 1.95,
              color: const Color(0xFF9C9C9C),
            ),
          ),
          addVerticalSpace(13),
          SlideTransition(
            position: _offsetAnimation,
            child: Wrap(
              spacing: 7,
              runSpacing: 7,
              children: [
                for (final genre in visible)
                  _TagPill(name: genre.name, count: genre.count),
                if (hasMore)
                  GestureDetector(
                    onTap: () => setState(() => _expandedTags = !_expandedTags),
                    child: _TagPill(name: _expandedTags ? '收起' : '更多+', count: null),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 按空行/换行拆分简介为多行展示
  List<String> _splitSynopsis(String synopsis) {
    final normalized = synopsis.replaceAll('\r\n', '\n').trim();
    if (normalized.isEmpty) return const [];
    return normalized
        .split(RegExp(r'\n+'))
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();
  }
}

/// 元信息行：标签 + 内容
class _MetaLine extends StatelessWidget {
  final String label;
  final String value;

  const _MetaLine({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.notoSansSc(
            fontSize: 14,
            height: 1.9,
            color: const Color(0xFFB9B9B9),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: GoogleFonts.notoSansSc(
              fontSize: 14,
              height: 1.9,
              color: const Color(0xFFB9B9B9),
            ),
          ),
        ),
      ],
    );
  }
}

/// 章节按钮
class _ChapterButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _ChapterButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(6),
        child: Ink(
          width: 36,
          height: 28,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF58A3E4),
                Color(0xFF3B7FC0),
                Color(0xFF2F6DAD),
              ],
              stops: [0.0, 0.52, 1.0],
            ),
            borderRadius: BorderRadius.circular(6),
            boxShadow: const [
              BoxShadow(
                color: Color(0x59000000),
                offset: Offset(0, 1),
                blurRadius: 1,
              ),
            ],
          ),
          child: Center(
            child: Text(
              label,
              style: GoogleFonts.notoSansSc(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.5,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// 标签胶囊
class _TagPill extends StatelessWidget {
  final String name;
  final int? count;

  const _TagPill({required this.name, this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
      decoration: BoxDecoration(
        color: const Color(0xFF4B4B4B),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            name,
            style: GoogleFonts.notoSansSc(
              fontSize: 13,
              height: 1,
              color: const Color(0xFFE4E4E4),
            ),
          ),
          if (count != null) ...[
            const SizedBox(width: 5),
            Text(
              '$count',
              style: GoogleFonts.notoSansSc(
                fontSize: 11,
                height: 1,
                color: const Color(0xFFA5A5A5),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// 简介正文
class _DescText extends StatelessWidget {
  final String text;

  const _DescText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.notoSansSc(
        fontSize: 15,
        height: 2,
        letterSpacing: 0.3,
        color: const Color(0xFF8F8F8F),
      ),
    );
  }
}
