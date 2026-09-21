import 'package:flutter/material.dart';
import 'package:movies/data/models/anime_details.dart';

/// 动漫简介组件
/// 展示动漫的详细描述信息
class AnimeOverview extends StatelessWidget {
  /// 动漫详情数据
  final AnimeDetails details;
  const AnimeOverview({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      child: Text(
        details.synopsis ?? '',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
