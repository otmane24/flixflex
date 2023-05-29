import 'package:flutter/material.dart';

import '../../../assistant_methode/size_config.dart';
import 'image_network.dart';

Widget cardPageView({required String image, required bool currentIndex}) {
  return Container(
    padding: currentIndex
        ? EdgeInsets.zero
        : EdgeInsets.only(
            bottom: 4 * SizeConfig.blockSizeVertical!,
            left: 4 * SizeConfig.blockSizeVertical!,
            right: 4 * SizeConfig.blockSizeVertical!),
    margin: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal!),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
    ),
    height: 35 * SizeConfig.blockSizeVertical!,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: imageMovie(imageName: image),
    ),
  );
}
