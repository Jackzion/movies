import 'package:flutter/material.dart';
import 'package:movies/data/models/genre.dart';
import 'package:movies/ui/theme/theme.dart';

/// 动漫类型标签行组件
/// 展示动漫的类型标签，支持从右向左滑入动画
class GenreRow extends StatefulWidget {
  /// 类型列表
  final List<Genre> genres;
  const GenreRow({super.key, required this.genres});

  @override
  State<GenreRow> createState() => _GenreRowState();
}

/// GenreRow 的状态类
/// 使用 SingleTickerProviderStateMixin 提供动画所需的 Ticker
class _GenreRowState extends State<GenreRow> with SingleTickerProviderStateMixin {
  /// 动画控制器，控制滑入动画
  late AnimationController _controller;
  /// 偏移动画，从屏幕右侧滑入到正常位置
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    // 创建动画控制器，2秒动画
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward(); // 初始化时立即启动动画

    // 创建偏移动画，从右侧 (1.0, 0.0) 到正常位置 (0.0, 0.0)
    // 使用 elasticOut 曲线实现弹性回弹效果
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0), // 从屏幕右侧开始
      end: Offset.zero, // 结束于正常位置
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut, // 弹性曲线，产生回弹效果
    ));
  }

  @override
  void dispose() {
    // 释放动画控制器资源
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: SizedBox(
        height: 40,
        child: SlideTransition(
          position: _offsetAnimation,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: widget.genres.map((genre) {
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Container(
                  decoration: BoxDecoration(
                    color: searchBarBackground,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: Center(
                    child: Text(
                      genre.name,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
