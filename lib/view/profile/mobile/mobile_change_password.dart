import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smartfit_app_mobile/common/colo_extension.dart';
import 'package:smartfit_app_mobile/common_widget/button/round_button.dart';
import 'package:smartfit_app_mobile/common_widget/text_field/round_text_field.dart';


class MobileChangePasswordView extends StatefulWidget {
  const MobileChangePasswordView({super.key});

  @override
  State<MobileChangePasswordView> createState() => _MobileChangePasswordViewState();
}

class _MobileChangePasswordViewState extends State<MobileChangePasswordView> {
  final TextEditingController controllerTextEmail = TextEditingController();
  final TextEditingController controllerTextPassword = TextEditingController();


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
          "Changer son Mot de passe",
          style: TextStyle(
              color: TColor.black, fontSize: 16, fontWeight: FontWeight.w700),
        ),
        ),
      backgroundColor: TColor.white,
      body: Column(
        children: [
          SizedBox(
            height: media.width * 0.05,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: media.width * 0.05),
                      RoundTextField(
                        hitText: "Ancien mot de passe",
                        obscureText: true,
                        icon: "assets/img/lock.svg",
                        keyboardType: TextInputType.text,
                        controller: controllerTextEmail,
                      ),
                      SizedBox(height: media.width * 0.07),
                      RoundTextField(
                        controller: controllerTextPassword,
                        hitText: "Nouveau mot de passe",
                        icon: "assets/img/lock.svg",
                        obscureText: true,
                        
                      ),
                      SizedBox(height: media.width * 0.07),
                      RoundTextField(
                        controller: controllerTextPassword,
                        hitText: "Confirmer nouveau mot de passe",
                        icon: "assets/img/lock.svg",
                        obscureText: true,
                        
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