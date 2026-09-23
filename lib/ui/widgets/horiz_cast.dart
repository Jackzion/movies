import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies/data/models/anime_character.dart';

/// 横向滚动的角色列表组件
/// 使用 GridView 展示角色头像和名字
class HorizontalCast extends StatelessWidget {
  /// 角色信息列表
  final List<AnimeCharacter> characters;

  const HorizontalCast({required this.characters, super.key});

  @override
  Widget build(BuildContext context) {
    if (characters.isEmpty) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      height: 140,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: characters.length,
        itemBuilder: (context, index) {
          final character = characters[index];
          final characterInfo = character.character;
          final imageUrl = characterInfo?.imageUrl ?? '';
          final name = characterInfo?.name ?? '';

          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: SizedBox(
              width: 80,
              child: Column(
                children: [
                  SizedBox(
                    width: 70,
                    height: 70,
                    child: imageUrl.isNotEmpty
                        ? CircleAvatar(
                            backgroundImage: CachedNetworkImageProvider(imageUrl),
                          )
                        : const CircleAvatar(
                            child: Icon(Icons.person),
                          ),
                  ),
                  const SizedBox(height: 4),
                  SizedBox(
                    width: 80,
                    child: Text(
                      name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
