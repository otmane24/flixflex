import 'package:flutter/material.dart';

import '../../../assistant_methode/size_config.dart';

Widget notFound() {
  return Center(
    child: SizedBox(
      height: 20 * SizeConfig.blockSizeVertical!,
      child: Center(
        child: Text(
          'No films found !',
          style: TextStyle(
              color: Colors.orange,
              fontWeight: FontWeight.w400,
              fontSize: 2.2 * SizeConfig.blockSizeVertical!),
        ),
      ),
    ),
  );
}
