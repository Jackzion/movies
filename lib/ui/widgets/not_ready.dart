import 'package:flutter/material.dart';

/// 加载中占位组件
/// 当异步数据尚未加载完成时显示
class NotReady extends StatelessWidget {
  const NotReady({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
