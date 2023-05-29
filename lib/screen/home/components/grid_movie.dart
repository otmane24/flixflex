import 'package:flutter/material.dart';

import '../../../routing/app_routing.dart';
import 'card_grid.dart';

Widget gridMovie({required List<dynamic> movieList}) {
  return Column(
    children: [
      GridView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: .75),
        itemCount: movieList.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () => Navigator.of(context).pushNamed(
                AppRouter.movieDetailRouter,
                arguments: movieList[index].id),
            child: CardGrid(
                title: movieList[index].title!,
                logo: movieList[index].poster_path!),
          );
        },
      ),
      const Center(
        child: RefreshProgressIndicator(
          color: Color.fromARGB(255, 140, 46, 202),
          backgroundColor: Colors.transparent,
        ),
      )
    ],
  );
}
