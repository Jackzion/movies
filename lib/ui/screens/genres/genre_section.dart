import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/ui/theme/theme.dart';

class GenreState {
  final String genre;
  final bool isSelected;
  GenreState({required this.genre, required this.isSelected});
}

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
    return Material(
      // 透明背景,避免 MergeableMaterial 的 layout 坑
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // 头部:整行可点,自带水波纹
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
                      color: Colors.red,
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

          // 折叠/展开区:AnimatedSize 自动算高度,无 ListView / MergeableMaterial
          AnimatedSize(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            child: widget.isExpanded
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: getGenreChips(),
                    ),
                  )
                : const SizedBox(width: double.infinity, height: 0),
          ),
        ],
      ),
    );
  }

  List<Widget> getGenreChips() {
    return List<Widget>.generate(widget.genreStates.length, (index) {
      final genreState = widget.genreStates[index];
      return FilterChip(
        // 关键修复:用 #2A2A2A 替代 searchBarBackground(#1E1E1E),
        // 跟 screenBackground(#111111) 有明显边界,chip 才看得见
        backgroundColor: const Color(0xFF2A2A2A),
        selectedColor: buttonGrey,
        label: Text(
          genreState.genre,
          style: Theme.of(context).textTheme.labelSmall,
        ),
        selected: genreState.isSelected,
        onSelected: (selected) {
          setState(() {
            widget.genreStates[index] = GenreState(
              genre: genreState.genre,
              isSelected: !genreState.isSelected,
            );
            widget.onGenresSelected(getSelectedGenres());
          });
        },
      );
    });
  }

  List<GenreState> getSelectedGenres() {
    return widget.genreStates.where((e) => e.isSelected).toList();
  }

  int totalSelected() {
    return getSelectedGenres().length;
  }
}
