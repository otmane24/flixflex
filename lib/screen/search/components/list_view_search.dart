import 'package:flutter/material.dart';

import '../../../assistant_methode/size_config.dart';
import '../../../routing/app_routing.dart';
import '../../home/components/card_grid.dart';

Widget listViewSearch(
    {required ScrollController controller,
    required List<dynamic> resultSearch,
    required bool isFilm}) {
  return SizedBox(
    height: 35 * SizeConfig.blockSizeVertical!,
    child: ListView.separated(
      controller: controller,
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: resultSearch.length,
      physics: const BouncingScrollPhysics(),
      separatorBuilder: (context, index) {
        return SizedBox(
          width: 2 * SizeConfig.blockSizeVertical!,
        );
      },
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () => Navigator.of(context).pushNamed(
              isFilm
                  ? AppRouter.movieDetailRouter
                  : AppRouter.serieDetailRouter,
              arguments: resultSearch[index].id),
          child: CardGrid(
              title: resultSearch[index].title!,
              logo: resultSearch[index].poster_path!),
        );
      },
    ),
  );
}
