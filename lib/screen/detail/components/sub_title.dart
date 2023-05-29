import 'package:flutter/material.dart';

import '../../../assistant_methode/size_config.dart';

Text subTitle(String text) {
  return Text(
    text,
    overflow: TextOverflow.clip,
    style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w400,
        fontSize: 1.6 * SizeConfig.blockSizeVertical!),
  );
}
