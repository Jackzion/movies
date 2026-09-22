import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies/data/models/anime_character.dart';

/// 横向滚动的角色列表组件
/// 使用 SliverGrid 展示角色头像和名字
class HorizontalCast extends StatelessWidget {
  /// 角色信息列表
  final List<AnimeCharacter> characters;

  const HorizontalCast({required this.characters, super.key});

  @override
  Widget build(BuildContext context) {
    if (characters.isEmpty) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }

    return SliverPadding(
      padding: const EdgeInsets.only(left: 16.0, right: 16),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 100.0,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          mainAxisExtent: 120.0,
        ),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            final character = characters[index];
            final characterInfo = character.character;
            final imageUrl = characterInfo?.imageUrl ?? '';
            final name = characterInfo?.name ?? '';

            return Column(
              children: [
                SizedBox(
                  width: 76,
                  height: 76,
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
                  width: 90,
                  child: Text(
                    name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ),
                if (character.role != null)
                  Text(
                    character.role!,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Colors.grey,
                    ),
                  ),
              ],
            );
          },
          childCount: characters.length,
        ),
      ),
    );
  }
}
