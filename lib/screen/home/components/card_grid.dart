import 'package:flixflex/screen/home/components/image_network.dart';
import 'package:flutter/material.dart';

import '../../../assistant_methode/size_config.dart';

class CardGrid extends StatelessWidget {
  final String title;

  final String logo;
  final Function()? onPress;

  const CardGrid(
      {super.key, required this.title, required this.logo, this.onPress});
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onPress,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 24 * SizeConfig.blockSizeVertical!,
              width: 40 * SizeConfig.blockSizeHorizontal!,
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: imageMovie(imageName: logo),
              ),
            ),
            SizedBox(
              height: 1.4 * SizeConfig.blockSizeVertical!,
            ),
            SizedBox(
              width: 40 * SizeConfig.blockSizeHorizontal!,
              child: Text(
                title,
                textAlign: TextAlign.center,
                maxLines: 2,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    overflow: TextOverflow.fade,
                    fontSize: 2 * SizeConfig.blockSizeVertical!),
              ),
            ),
          ],
        ));
  }
}
