import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/data/models/genre.dart';
import 'package:movies/data/models/genre_state.dart';
import 'package:movies/providers.dart';
import 'package:movies/ui/theme/theme.dart';

typedef OnGenresSelected = void Function(List<GenreState>);
typedef OnGenresExpanded = void Function(bool);

class GenreSection extends ConsumerStatefulWidget {
  final bool isExpanded;
  final List<GenreState> genreStates;
  final OnGenresExpanded onGenresExpanded;
  final OnGenresSelected onGenresSelected;
  const GenreSection({
    required this.genreStates,
    required this.isExpanded,
    required this.onGenresExpanded,
    required this.onGenresSelected,
    super.key,
  });
  @override
  ConsumerState<GenreSection> createState() => _GenreSectionState();
}

class _GenreSectionState extends ConsumerState<GenreSection> {
  @override
  Widget build(BuildContext context) {
    var genreChips = getGenreChips();
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Material(
            color: Colors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () => widget.onGenresExpanded(!widget.isExpanded),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: Row(
                      children: [
                        Text(
                          'Genres',
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 16,
                          height: 16,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: dangerRed,
                          ),
                          child: Center(
                            child: Text(
                              totalSelected().toString(),
                              style: verySmallText,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Icon(
                          widget.isExpanded
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
                AnimatedSize(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  child: widget.isExpanded
                      ? Padding(
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                          // 流式排列：只保留间距，不按行列对齐
                          child: Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            alignment: WrapAlignment.start,
                            children: genreChips,
                          ),
                        )
                      : const SizedBox(width: double.infinity, height: 0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 搜索 tag 是否需要作为临时 chip 展示
  /// 与已有同名 chip 去重（search() 里也会对请求 tag 去重）
  bool get showSearchTagChip {
    final searchTag = ref.watch(searchTagProvider).trim();
    return searchTag.isNotEmpty &&
        !widget.genreStates.any((s) => s.genre.name == searchTag);
  }

  // 生成标签 genre chips
  List<Widget> getGenreChips() {
    // watch tag provider - 自动响应变化，触发 rebuild
    // 搜索 tag 仅作为临时选中项展示在最前，不写入 genreStates（build 期间不能有副作用）
    final displayStates = [
      if (showSearchTagChip)
        GenreState(
          genre: Genre(malId: 0, name: ref.watch(searchTagProvider).trim()),
          isSelected: true,
        ),
      ...widget.genreStates,
    ];

    return List<Widget>.generate(displayStates.length, (index) {
      final genreState = displayStates[index];
      return FilterChip(
        backgroundColor: buttonGrey,
        selectedColor: accentAmber,
        labelStyle: TextStyle(
          color: genreState.isSelected ? onAccent : Colors.white,
        ),
        label: Text(
          genreState.genre.name,
          style: Theme.of(context).textTheme.labelSmall,
        ),
        selected: genreState.isSelected,
        onSelected: (selected) {
          // 首个为搜索 tag chip：点击清除 tag，GenreScreen 监听后重新 search
          if (showSearchTagChip && index == 0) {
            ref.read(searchTagProvider.notifier).state = '';
            return;
          }
          // displayStates 前置了 tag chip 时，genreStates 下标需要回退用来获取 genreStates 真实index用来更新 isSelected
          final genreIndex = index - (showSearchTagChip ? 1 : 0);
          setState(() {
            widget.genreStates[genreIndex] = genreState.copyWith(
              isSelected: selected,
            );
            // 回传全量列表，父组件只同步选中态，不覆盖为「仅已选」
            widget.onGenresSelected(List<GenreState>.from(widget.genreStates));
          });
        },
      );
    });
  }

  List<GenreState> getSelectedGenres() {
    return widget.genreStates.where((e) => e.isSelected).toList();
  }

  int totalSelected() {
    // 搜索 tag chip 也计入已选数量
    return getSelectedGenres().length + (showSearchTagChip ? 1 : 0);
  }
}