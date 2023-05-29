import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../assistant_methode/size_config.dart';

class ShimmerUI {
  Widget movieShimmer() {
    return Shimmer.fromColors(
      baseColor: const Color.fromARGB(150, 227, 227, 227),
      highlightColor: const Color.fromARGB(250, 200, 200, 200),
      direction: ShimmerDirection.ltr,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          color: Colors.red,
        ),
        padding: EdgeInsets.only(
            bottom: 40 * SizeConfig.blockSizeVertical!,
            left: 40 * SizeConfig.blockSizeVertical!,
            right: 40 * SizeConfig.blockSizeVertical!),
        margin:
            EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal!),
        width: 199,
        height: 24 * SizeConfig.blockSizeVertical!,
      ),
    );
  }

  Widget textShimmer({double? width}) {
    return Shimmer.fromColors(
      baseColor: const Color.fromARGB(150, 227, 227, 227),
      highlightColor: const Color.fromARGB(250, 200, 200, 200),
      direction: ShimmerDirection.ltr,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        margin:
            EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal!),
        width: width ?? 8 * SizeConfig.blockSizeVertical!,
        height: 2.4 * SizeConfig.blockSizeVertical!,
      ),
    );
  }

  Widget gridMovieShimmer() {
    return GridView(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: .9,
        crossAxisSpacing: 24,
        mainAxisSpacing: 24,
      ),
      children: [
        movieShimmer(),
        movieShimmer(),
        movieShimmer(),
        movieShimmer(),
        movieShimmer(),
        movieShimmer(),
      ],
    );
  }

  Widget listGenreShimmer() {
    return SizedBox(
      height: 2.4 * SizeConfig.blockSizeVertical!,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 42),
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          textShimmer(),
          textShimmer(),
          textShimmer(),
          textShimmer(),
          textShimmer(),
          textShimmer(),
        ],
      ),
    );
  }

  Widget pageViewShimmer(PageController controller) {
    return SizedBox(
      height: 30 * SizeConfig.blockSizeVertical!,
      child: PageView(
        physics: const BouncingScrollPhysics(),
        controller: controller,
        pageSnapping: true,
        allowImplicitScrolling: true,
        scrollDirection: Axis.horizontal,
        children: [
          movieShimmer(),
          movieShimmer(),
        ],
      ),
    );
  }

  Widget listViewShimmer() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Films',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 2.6 * SizeConfig.blockSizeVertical!),
          ),
        ),
        SizedBox(
          height: 2 * SizeConfig.blockSizeVertical!,
        ),
        SizedBox(
          height: 25 * SizeConfig.blockSizeVertical!,
          child: ListView(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            physics: const BouncingScrollPhysics(),
            children: [
              movieShimmer(),
              movieShimmer(),
              movieShimmer(),
              movieShimmer(),
              movieShimmer(),
              movieShimmer(),
            ],
          ),
        ),
        SizedBox(
          height: 2 * SizeConfig.blockSizeVertical!,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Series',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 2.6 * SizeConfig.blockSizeVertical!),
          ),
        ),
        SizedBox(
          height: 2 * SizeConfig.blockSizeVertical!,
        ),
        SizedBox(
          height: 25 * SizeConfig.blockSizeVertical!,
          child: ListView(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            physics: const BouncingScrollPhysics(),
            children: [
              movieShimmer(),
              movieShimmer(),
              movieShimmer(),
              movieShimmer(),
              movieShimmer(),
              movieShimmer(),
            ],
          ),
        ),
      ],
    );
  }
}
