import 'package:flutter/material.dart';

import '../../../constants/strings/constants_strings.dart';

Widget imageMovie({required String imageName, double? height, double? width}) {
  return Image.network(
    fit: BoxFit.fill,
    height: height,
    width: width,
    errorBuilder: (context, error, stackTrace) {
      return Image.asset('$pngsPath/notfound.jpg', fit: BoxFit.cover);
    },
    loadingBuilder:
        (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
      if (loadingProgress == null) return child;
      return Center(
        child: CircularProgressIndicator(
          value: loadingProgress.expectedTotalBytes != null
              ? loadingProgress.cumulativeBytesLoaded /
                  loadingProgress.expectedTotalBytes!
              : null,
        ),
      );
    },
    baseUrlPicture + imageName,
  );
}
