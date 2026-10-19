# Movies / Anime

Flutter 跨端动漫发现应用：首页轮播、分类检索、详情与本地收藏。数据主源为 **Bangumi**，宽幅横幅 / PV 由 **AniList** 按需补充。

## 参考书目

开发过程中借鉴了：

> **Mastering Flutter: Learn to develop Flutter apps for iOS, Android, desktop and web**  
> — Kevin Moore

书中以 TMDB 电影应用为例的工程实践（数据库分层、自适应布局、桌面窗口限制、Web + Drift 等），在本项目里改编为 Bangumi / AniList 动漫场景。

## 功能概览

- 首页：本季放送轮播、Trending / Popular / Top Rated 网格；悬停（桌面）扩到 2 列横幅
- Genre：标签筛选与排序
- Favorites：本地持久化收藏（Drift / SQLite）
- 详情：海报与信息栏、章节 / 标签、角色与声优、预告缩略图
- 自适应导航：小屏底部栏，中大屏 NavigationRail（`flutter_adaptive_scaffold`）
- 桌面：窗口最小 700×600（`desktop_window`）
- Web：`sqlite3.wasm` + `drift_worker.js`，收藏可跨刷新保留

## 技术栈

- **Flutter**（Dart SDK `^3.13.2`）
- 状态与路由：`flutter_riverpod`、`auto_route`
- 网络：`dio`（Bangumi REST + AniList GraphQL）
- 本地存储：`drift` / `drift_flutter`（收藏、标签）；`shared_preferences`（缓存）
- UI：`cached_network_image`、`google_fonts`、`card_swiper`、`media_kit`
- 自适应：`flutter_adaptive_scaffold`、`desktop_window`

## 项目结构

```text
lib/
├── main.dart                    # 入口（桌面窗口尺寸、日志、代理）
├── providers.dart               # Riverpod：API / DB / ViewModel
├── data/
│   ├── models/                  # Anime、AnimeDetails、Genre…
│   └── database/
│       ├── models/              # DBFavorite、DBAnimeGenre、IDatabase
│       └── drift/               # Drift 表与实现
├── network/                     # BangumiApiService / AniListApiService
├── router/                      # auto_route 路由
└── ui/
    ├── main_screen.dart         # AdaptiveLayout 三槽位导航
    ├── screens/                 # home / genres / favorites / detail / videos
    └── widgets/                 # 卡片、收藏行、演员条…
```

## 跑起来

环境：Flutter SDK（Dart `^3.13.2`），目标平台任选（Windows / macOS / Linux / Android / iOS / Web）。

```bash
flutter pub get

flutter run                 # 默认设备
flutter run -d chrome       # Web
flutter run -d windows      # 桌面
flutter run -d android
```

改 Drift 表结构后如需重新生成代码：

```bash
flutter pub run build_runner build
```

### Web 说明

`web/` 下需包含（已入库）：

- `sqlite3.wasm` — 浏览器里的 SQLite（WASM）
- `drift_worker.js` — Drift 后台 worker

`AnimeDatabase` 通过 `driftDatabase` + `DriftWebOptions` 自动切换原生 / Web。

### Windows 注意 ⚠️

使用插件时需开启「开发人员模式」，否则可能报 symlink 相关错误：

`Win + I` → 搜索「开发者设置」→ 打开「开发人员模式」。

## 已实现 / 待实现

- [x] 主框架（自适应导航：Home / Genre / Favorites）
- [x] 首页轮播 + 多分类网格
- [x] Bangumi 搜索 / 日历 / 详情 / 角色
- [x] AniList 横幅与 PV 补充
- [x] Drift 收藏与标签持久化
- [x] 详情页（信息布局、预告、收藏按钮）
- [x] Web / 桌面基础适配
- [ ] 评论 BBCode 富文本（可参考 Kazumi 的 ANTLR 方案）
- [ ] 图片按分辨率动态取图
- [ ] 搜索页体验完善

## License

MIT
