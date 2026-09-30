import 'package:flutter_test/flutter_test.dart';
import 'package:movies/data/models/anime.dart';
import 'package:movies/data/models/anime_character.dart';
import 'package:movies/data/models/anime_details.dart';
import 'package:movies/data/models/anime_extras.dart';

void main() {
  group('Anime.fromBangumi', () {
    test('解析搜索结果条目', () {
      final anime = Anime.fromBangumi({
        'id': 400602,
        'name': '葬送のフリーレン',
        'name_cn': '葬送的芙莉莲',
        'summary': '勇者一行的故事……',
        'date': '2023-09-29',
        'platform': 'TV',
        'images': {'large': 'https://lain.bgm.tv/pic/cover/l/x.jpg'},
        'rating': {'rank': 42, 'score': 8.5},
        'eps': 28,
      });

      expect(anime.animeId, 400602);
      expect(anime.bangumiId, 400602);
      expect(anime.title, '葬送的芙莉莲');
      expect(anime.titleJapanese, '葬送のフリーレン');
      expect(anime.imageUrl, 'https://lain.bgm.tv/pic/cover/l/x.jpg');
      expect(anime.image, anime.imageUrl);
      expect(anime.score, 8.5);
      expect(anime.rank, 42);
      expect(anime.episodes, 28);
      expect(anime.aired, DateTime(2023, 9, 29));
    });

    test('解析日历条目（air_date 与顶层 rank）', () {
      final anime = Anime.fromBangumi({
        'id': 456080,
        'name': 'テスト',
        'name_cn': '测试动画',
        'air_date': '2026-07-06',
        'rank': 9953,
        'rating': {'score': 4.9},
        'collection': {'doing': 1405},
        'images': {'large': 'https://lain.bgm.tv/pic/cover/l/y.jpg'},
      });

      expect(anime.title, '测试动画');
      expect(anime.aired, DateTime(2026, 7, 6));
      expect(anime.rank, 9953);
      expect(anime.score, 4.9);
    });

    test('name_cn 为空时回退日文名', () {
      final anime = Anime.fromBangumi({
        'id': 1,
        'name': 'Cowboy Bebop',
        'name_cn': '',
      });
      expect(anime.title, 'Cowboy Bebop');
    });
  });

  group('AnimeDetails.fromBangumi', () {
    test('解析详情并提取标签（跳过年份/放送形式）', () {
      final details = AnimeDetails.fromBangumi({
        'id': 400602,
        'name': '葬送のフリーレン',
        'name_cn': '葬送的芙莉莲',
        'summary': '简介……',
        'date': '2023-09-29',
        'platform': 'TV',
        'eps': 28,
        'total_episodes': 28,
        'images': {'large': 'https://lain.bgm.tv/pic/cover/l/x.jpg'},
        'rating': {'rank': 42, 'score': 8.5},
        'collection': {'wish': 10, 'collect': 20, 'doing': 5},
        'tags': [
          {'name': '奇幻', 'count': 338},
          {'name': '2023', 'count': 318},
          {'name': 'TV', 'count': 238},
          {'name': 'MADHouse', 'count': 232},
          {'name': '旅行', 'count': 219},
        ],
      });

      expect(details.bangumiId, 400602);
      expect(details.displayTitle, '葬送的芙莉莲');
      expect(details.imageUrl, 'https://lain.bgm.tv/pic/cover/l/x.jpg');
      expect(details.synopsis, '简介……');
      expect(details.year, 2023);
      expect(details.episodes, 28);
      expect(details.members, 35);
      expect(details.genres?.map((g) => g.name).toList(),
          ['奇幻', 'MADHouse', '旅行']);
    });
  });

  group('AnimeCharacter.fromBangumi', () {
    test('解析角色与声优', () {
      final entry = AnimeCharacter.fromBangumi({
        'id': 161303,
        'name': 'フリーレン',
        'relation': '主角',
        'images': {'large': 'https://lain.bgm.tv/pic/crt/l/a.jpg'},
        'actors': [
          {
            'id': 21526,
            'name': '種﨑敦美',
            'images': {'large': 'https://lain.bgm.tv/pic/crt/l/b.jpg'},
            'career': ['seiyu'],
          },
        ],
      });

      expect(entry.character?.name, 'フリーレン');
      expect(entry.character?.imageUrl, 'https://lain.bgm.tv/pic/crt/l/a.jpg');
      expect(entry.role, '主角');
      expect(entry.voiceActors?.single.name, '種﨑敦美');
      expect(entry.voiceActors?.single.language, '日语');
    });
  });

  group('AnimeExtras', () {
    test('缓存 JSON 往返', () {
      const extras = AnimeExtras(
        bannerImage: 'https://s4.anilist.co/banner.jpg',
        youtubeId: 'tR8YH0G67Rk',
      );
      final restored = AnimeExtras.fromJson(extras.toJson());
      expect(restored.bannerImage, 'https://s4.anilist.co/banner.jpg');
      expect(restored.youtubeId, 'tR8YH0G67Rk');
    });
  });
}
