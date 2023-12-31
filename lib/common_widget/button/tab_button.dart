import 'package:flutter_svg/svg.dart';
import 'package:smartfit_app_mobile/common/colo_extension.dart';
import 'package:flutter/material.dart';

class TabButton extends StatelessWidget {
  final String icon;
  final String selectIcon;
  final VoidCallback onTap;
  final bool isActive;
  const TabButton(
      {super.key,
      required this.icon,
      required this.selectIcon,
      required this.isActive,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        SvgPicture.asset(isActive ? selectIcon : icon,
            width: 15, height: 25, fit: BoxFit.fitWidth),
         SizedBox(
          height: isActive ?  10: 6,
        ),
        if(isActive)
        Container(
          width: 3,
          height: 3,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: TColor.secondaryG,
              ),
              borderRadius: BorderRadius.circular(1.5)),
        )
      ]),
    );
  }
}