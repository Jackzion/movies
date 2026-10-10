import 'package:flutter/material.dart';

/// 应用壳菜单项（搜索 / 页面跳转）
enum AppMenuAction {
  search('Search', Icons.search),
  home('Home', Icons.home_outlined),
  genres('Genres', Icons.theaters_outlined),
  favorites('Favorites', Icons.favorite_outline);

  const AppMenuAction(this.label, this.icon);

  final String label;
  final IconData icon;
}

/// 构造应用菜单条目列表
List<PopupMenuEntry<AppMenuAction>> buildAppMenuItems() {
  return [
    for (final action in AppMenuAction.values)
      PopupMenuItem<AppMenuAction>(
        value: action,
        child: Row(
          children: [
            Icon(action.icon, size: 20),
            const SizedBox(width: 12),
            Text(action.label),
          ],
        ),
      ),
  ];
}
