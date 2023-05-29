import 'package:flutter/material.dart';

import '../../../assistant_methode/size_config.dart';

Column itemDetailMovie({required String title, required Widget body}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding:
            EdgeInsets.symmetric(horizontal: 2 * SizeConfig.blockSizeVertical!),
        child: Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.clip,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 2 * SizeConfig.blockSizeVertical!),
        ),
      ),
      SizedBox(
        height: .8 * SizeConfig.blockSizeVertical!,
      ),
      Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 2.2 * SizeConfig.blockSizeVertical!),
        child: body,
      ),
    ],
  );
}
