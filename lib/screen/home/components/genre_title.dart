import 'package:flixflex/presentation/colors/color_manager.dart';
import 'package:flutter/material.dart';

import '../../../assistant_methode/size_config.dart';

Widget genreTitle({required String name, required bool isGenre}) {
  return Column(
    children: [
      Text(
        name,
        maxLines: 1,
        style: TextStyle(
            color: isGenre ? ColorManager.secondary : Colors.white,
            fontWeight: isGenre ? FontWeight.bold : FontWeight.w400,
            overflow: TextOverflow.fade,
            fontSize: 2.2 * SizeConfig.blockSizeVertical!),
      ),
      if (isGenre)
        SizedBox(
          height: .2 * SizeConfig.blockSizeVertical!,
        ),
      if (isGenre)
        Container(
          height: 2,
          width: 2.4 * SizeConfig.blockSizeVertical!,
          color: ColorManager.secondary,
        )
    ],
  );
}
