import 'package:movies/data/models/genre.dart';

/// 类型选择状态
class GenreState {
  /// 类型数据
  final Genre genre;
  /// 是否已选中
  final bool isSelected;

  const GenreState({required this.genre, required this.isSelected});

  /// 复制并修改选中状态
  GenreState copyWith({bool? isSelected}) {
    return GenreState(
      genre: genre,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
