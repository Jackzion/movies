import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/providers.dart';
import 'package:movies/utils/utils.dart';

const delayTime = 1000 * 10;
const animationTime = 1000;

const images = [
'http://image.tmdb.org/t/p/w780/z1p34vh7dEOnLDmyCrlUVLuoDzd.jpg',
'http://image.tmdb.org/t/p/w780/gKkl37BQuKTanygYQG1pyYgLVgf.jpg',
'http://image.tmdb.org/t/p/w780/4xJd3uwtL1vCuZgEfEc8JXI9Uyx.jpg',
'http://image.tmdb.org/t/p/w780/uuA01PTtPombRPvL9dvsBqOBJWm.jpg',
'http://image.tmdb.org/t/p/w780/H6vke7zGiuLsz4v4RPeReb9rsv.jpg',
'http://image.tmdb.org/t/p/w780/e1J2oNzSBdou01sUvriVuoYp0pJ.jpg',
'http://image.tmdb.org/t/p/w780/hu40Uxp9WtpL34jv3zyWLb5zEVY.jpg',
'http://image.tmdb.org/t/p/w780/pKaA8VvfkNfEMUPMiiuL5qSPQYy.jpg',
'http://image.tmdb.org/t/p/w780/zK2sFxZcelHJRPVr242rxy5VK4T.jpg',
'http://image.tmdb.org/t/p/w780/7qxG0zyt29BI0IzFDfsps62kbQi.jpg',
'http://image.tmdb.org/t/p/w780/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg',
'http://image.tmdb.org/t/p/w780/zDi2U7WYkdIoGYHcYbM9X5yReVD.jpg',
'http://image.tmdb.org/t/p/w780/cxevDYdeFkiixRShbObdwAHBZry.jpg',
'http://image.tmdb.org/t/p/w780/uXUs1fwSuE06LgYETw2mi4JxQvc.jpg'
];



class HomeScreenImage extends ConsumerWidget {
  final OnMovieTap onMovieTap;
  const HomeScreenImage({super.key, required this.onMovieTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final images = ref.watch(movieImagesProvider);
    final screenWidth = MediaQuery.of(context).size.width - 32;

    return SizedBox(
      height: 374,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              onMovieTap(index);
            },
            child: CachedNetworkImage(
              imageUrl: images[index],
              fit: BoxFit.fitHeight,
              height: 374,
              width: screenWidth,
            ),
          );
        },
        autoplayDelay: delayTime,
        duration: animationTime,
        itemWidth: screenWidth,
        itemCount: images.length,
        pagination: const SwiperPagination(),
        control: const SwiperControl(),
      ),
    );
  }
}
