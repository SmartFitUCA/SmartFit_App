import 'package:smartfit_app_mobile/common/colo_extension.dart';
import 'package:smartfit_app_mobile/view/on_boarding/on_boarding_view.dart';
import 'package:flutter/material.dart';
import '../../common_widget/round_button.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StartedView extends StatefulWidget {
  const StartedView({super.key});

  @override
  State<StartedView> createState() => _StartedViewState();
}

class _StartedViewState extends State<StartedView> {
  bool isChangeColor = true;

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: TColor.white,
      body: Container(
          width: media.width,
          decoration: BoxDecoration(
            gradient: isChangeColor
                ? LinearGradient(
                    colors: TColor.primaryG,
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight)
                : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: media.width * 0.90,
              ),
              SvgPicture.asset("assets/img/logoSM.svg"),
              const Spacer(),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: RoundButton(
                    title: "Commencer",
                    type: isChangeColor
                        ? RoundButtonType.textGradient
                        : RoundButtonType.bgGradient,
                    onPressed: () {
                      if (isChangeColor) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const OnBoardingView()));
                      } else {
                        //Change Color
                        setState(() {
                          isChangeColor = true;
                        });
                      }
                    },
                  ),
                ),
              )
            ],
          )),
    );
  }
}
