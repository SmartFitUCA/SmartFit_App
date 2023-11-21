import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smartfit_app_mobile/common/colo_extension.dart';
import 'package:smartfit_app_mobile/common_widget/button/round_button.dart';
import 'package:smartfit_app_mobile/common_widget/text_field/round_text_field.dart';


class MobileChangeEmailView extends StatefulWidget {
  const MobileChangeEmailView({super.key});

  @override
  State<MobileChangeEmailView> createState() => _MobileChangeEmailViewState();
}

class _MobileChangeEmailViewState extends State<MobileChangeEmailView> {
  final TextEditingController controllerTextEmail = TextEditingController();
  final TextEditingController controllerTextPassword = TextEditingController();
  String oldUsername = "Ancien e-mail";

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColor.white,
        centerTitle: true,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: const EdgeInsets.all(8),
            height: 40,
            width: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: TColor.lightGray,
                borderRadius: BorderRadius.circular(10)),
            child: Image.asset(
              "assets/img/black_btn.png",
              width: 15,
              height: 15,
              fit: BoxFit.contain,
            ),
            
          ),
          
        ),
         title: Text(
          "Changer son e-mail",
          style: TextStyle(
              color: TColor.black, fontSize: 16, fontWeight: FontWeight.w700),
        ),
        ),
      backgroundColor: TColor.white,
      body: Column(
        children: [
          SizedBox(
            height: media.width * 0.07,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Ancien e-mail :  ",
                      style: TextStyle(
                        color: TColor.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      oldUsername, // Utilisez votre ancien pseudo ici
                      style: TextStyle(
                        color: TColor.black,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: media.width * 0.07),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      
                      RoundTextField(
                        hitText: "Nouveau e-mail",
                        icon: "assets/img/user_text.svg",
                        keyboardType: TextInputType.text,
                        controller: controllerTextEmail,
                      ),
                      SizedBox(height: media.width * 0.07),
                      RoundButton(
                    title: "Confirmer",
                    onPressed: ()  {}),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}