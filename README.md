# Movies

一个 Flutter 写的电影发现 Demo,首页展示 NOW PLAYING 的海报轮播(数据用 TMDB 风格的图片地址)。

## 技术栈

- **Flutter** (Dart SDK `^3.13.2`)
- **Material** 默认主题
- 主要依赖:
  - [`card_swiper`](https://pub.dev/packages/card_swiper) — 卡片轮播
  - [`cached_network_image`](https://pub.dev/packages/cached_network_image) — 网络图片缓存
  - [`material_symbols_icons`](https://pub.dev/packages/material_symbols_icons) — Material Symbols 图标

## 项目结构

```
lib/
├── main.dart                          # 入口
└── ui/
    ├── main_screen.dart               # 主框架 + 底部 Tab
    └── screens/
        └── home/
            ├── home_screen.dart        # 首页(NOW PLAYING 标题)
            └── home_screen_image.dart  # 海报轮播组件
```

## 跑起来

环境要求:Flutter SDK(支持 Dart `^3.13.2`),任一目标平台(Windows / macOS / Linux / Android / iOS / Web)。

```bash
# 装依赖
flutter pub get

# 跑起来(默认设备)
flutter run

# 指定设备
flutter run -d chrome
flutter run -d windows
flutter run -d android
```

### Windows 用户注意 ⚠️

项目用了 plugin(`card_swiper` / `cached_network_image` / `material_symbols_icons`),
Windows 上必须开启「**开发者模式**」才能 build,否则会报:

```
Error: Building with plugins requires symlink support.
```

开启方法:`Win + I` → 搜索「开发者设置」→ 打开「开发人员模式」。

## 已实现 / 待实现

- [x] 主框架(底部三 Tab:Home / Genre / Favorites)
- [x] 首页 — NOW PLAYING 海报轮播(自动播放)
- [ ] Genre 分类页
- [ ] Favorites 收藏页
- [ ] 真实 TMDB API 接入(目前海报 URL 是硬编码的)
- [ ] 电影详情页

## License

MIT
