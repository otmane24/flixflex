import 'package:flixflex/screen/home/components/shimmer.dart';
import 'package:flutter/material.dart';

import '../../../assistant_methode/size_config.dart';

Widget titleMovie({required String name, required String vote}) {
  return Column(
    children: [
      name == ''
          ? ShimmerUI().textShimmer(
              width: 16 * SizeConfig.blockSizeVertical!,
            )
          : Text(
              name,
              maxLines: 1,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.fade,
                  fontSize: 2.4 * SizeConfig.blockSizeVertical!),
            ),
      if (vote != '')
        SizedBox(
          height: .6 * SizeConfig.blockSizeVertical!,
        ),
      if (vote != '')
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              vote,
              maxLines: 1,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  overflow: TextOverflow.fade,
                  fontSize: 2.2 * SizeConfig.blockSizeVertical!),
            ),
            SizedBox(
              width: .2 * SizeConfig.blockSizeVertical!,
            ),
            Text(
              '/10',
              maxLines: 1,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  overflow: TextOverflow.fade,
                  fontSize: 1.6 * SizeConfig.blockSizeVertical!),
            ),
          ],
        ),
    ],
  );
}
