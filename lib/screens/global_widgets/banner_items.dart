import 'package:amiriy/data/models/banner_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:my_utils/my_utils.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class BannerItems extends StatelessWidget {
  const BannerItems({
    super.key,
    required this.banners,
  });

  final List<BannerModel> banners;

  @override
  Widget build(
    BuildContext context,
  ) {
    return CarouselSlider(
      items: List.generate(
        banners.length,
        (
          index,
        ) {
          return GestureDetector(
            onTap: () {
              launchUrl(
                Uri.parse(
                  banners[index].bannerOnTapUrl,
                ),
              );
            },
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(
                    6,
                  ),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: banners[index].bannerImageUrl,
                    placeholder: (
                      context,
                      url,
                    ) =>
                        Shimmer.fromColors(
                      enabled: true,
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.white,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(
                            6,
                          ),
                        ),
                        height: double.infinity,
                        width: double.infinity,
                      ),
                    ),
                    errorWidget: (
                      context,
                      url,
                      error,
                    ) =>
                        const Center(
                      child: Icon(
                        Icons.error,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 30.h,
                  left: 20.w,
                  child: Text(
                    banners[index].bannerTitle,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontSize: 30,
                      shadows: [
                        const Shadow(
                          offset: Offset(
                            -1.5,
                            -1.5,
                          ),
                          color: Colors.white,
                        ),
                        const Shadow(
                          offset: Offset(
                            1.5,
                            -1.5,
                          ),
                          color: Colors.white,
                        ),
                        const Shadow(
                          offset: Offset(
                            1.5,
                            1.5,
                          ),
                          color: Colors.white,
                        ),
                        const Shadow(
                          offset: Offset(
                            -1.5,
                            1.5,
                          ),
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      options: CarouselOptions(
        aspectRatio: 16 / 10,
        viewportFraction: 1,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: true,
        autoPlay: true,
        autoPlayInterval: const Duration(
          seconds: 5,
        ),
        autoPlayAnimationDuration: const Duration(
          seconds: 2,
        ),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        enlargeFactor: 0.3,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
