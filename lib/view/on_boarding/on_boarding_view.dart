import 'package:flutter/material.dart';
import 'package:smartfit_app_mobile/common/colo_extension.dart';
import 'package:smartfit_app_mobile/common_widget/on_boarding/on_boarding_page.dart';
import 'package:smartfit_app_mobile/view/login/signup_view.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  int selectPage = 0;
  PageController controller = PageController();

  @override
  void initState() {
    super.initState();

    controller.addListener(() {
      selectPage = controller.page?.round() ?? 0;

      setState(() {});
    });
  }

  List pageArr = [
    {
      "title": "Atteignez vos objectifs",
      "subtitle":
          "Ne vous inquiétez pas si vous avez du mal à déterminer vos objectifs. Grâce à l'analyse concrète de vos performances, nous vous aiderons à les atteindre.",
      "image": "assets/img/on_1.svg"
    },
    {
      "title": "Persévérez",
      "subtitle":
          "Continuez à persévérer pour atteindre vos objectifs. La douleur n'est que temporaire. Si vous abandonnez maintenant, vous souffrirez éternellement.",
      "image": "assets/img/on_2.svg"
    },
    {
      "title": "Laissez-nous piloter, mettez simplement votre Suunto",
      "subtitle":
          "Détendez-vous, nous prenons les commandes en analysant performances et statistiques pour vous aider à atteindre vos objectifs.",
      "image": "assets/img/on_3.svg"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.white,
      body: Stack(
        alignment: Alignment.bottomRight,
        children: [
          PageView.builder(
              controller: controller,
              itemCount: pageArr.length,
              itemBuilder: (context, index) {
                var pObj = pageArr[index] as Map? ?? {};
                return OnBoardingPage(pObj: pObj);
              }),
          SizedBox(
            width: 120,
            height: 120,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 70,
                  height: 70,
                  child: CircularProgressIndicator(
                    color: TColor.primaryColor1,
                    value: (selectPage + 1) / 3,
                    strokeWidth: 2,
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      color: TColor.primaryColor1,
                      borderRadius: BorderRadius.circular(35)),
                  child: IconButton(
                    icon: Icon(
                      Icons.navigate_next,
                      color: TColor.white,
                    ),
                    onPressed: () {
                      if (selectPage < 2) {
                        selectPage = selectPage + 1;
                        controller.animateToPage(selectPage,
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.bounceInOut);
                        setState(() {});
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpView()));
                      }
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
