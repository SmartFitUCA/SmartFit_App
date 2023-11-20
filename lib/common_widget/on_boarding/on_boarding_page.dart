import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../common/colo_extension.dart';

class OnBoardingPage extends StatelessWidget {
  final Map pObj;
  const OnBoardingPage({super.key, required this.pObj});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return SizedBox(
      width: media.width,
      height: media.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            pObj["image"].toString(),
            width: media.width,
          ),
          SizedBox(
            height: media.width * 0.15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              pObj["title"].toString(),
              style: TextStyle(
                  color: TColor.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(
            height: media.width * 0.03,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              pObj["subtitle"].toString(),
              style: TextStyle(color: TColor.gray, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
