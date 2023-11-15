import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smartfit_app_mobile/modele/api/i_data_strategy.dart';
import 'package:smartfit_app_mobile/modele/api/request_api.dart';
import 'package:smartfit_app_mobile/view/login/login_view.dart';
import 'package:smartfit_app_mobile/common/colo_extension.dart';
import 'package:smartfit_app_mobile/common_widget/round_button.dart';
import 'package:smartfit_app_mobile/common_widget/round_text_field.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  bool _obscureText = true;
  bool _errorCreateUser = false;
  bool isCheck = false;
  String _msgError = "";
  IDataStrategy api = RequestApi();

  final controllerTextEmail = TextEditingController();
  final controllerTextUsername = TextEditingController();
  final controllerTextPassword = TextEditingController();

  Future<Tuple2<bool, String>> createUser() async {
    return await api.postUser(
        controllerTextEmail.text,
        sha256.convert(utf8.encode(controllerTextPassword.text)).toString(),
        controllerTextUsername.text);
  }

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: TColor.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Bienvenue,",
                  style: TextStyle(color: TColor.gray, fontSize: 16),
                ),
                Text(
                  "Créer un compte",
                  style: TextStyle(
                      color: TColor.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: media.width * 0.05,
                ),
                const RoundTextField(
                  hitText: "Prénom",
                  icon: "assets/img/user_text.svg",
                ),
                SizedBox(
                  height: media.width * 0.04,
                ),
                RoundTextField(
                  hitText: "Email",
                  icon: "assets/img/email.svg",
                  keyboardType: TextInputType.emailAddress,
                  controller: controllerTextEmail,
                ),
                SizedBox(
                  height: media.width * 0.04,
                ),
                RoundTextField(
                  hitText: "Mot de passe",
                  icon: "assets/img/lock.svg",
                  obscureText: _obscureText,
                  controller: controllerTextPassword,
                  rigtIcon: TextButton(
                      onPressed: _toggle,
                      child: Container(
                          alignment: Alignment.center,
                          width: 20,
                          height: 20,
                          child: SvgPicture.asset(
                            "assets/img/show_password.svg",
                            width: 20,
                            height: 20,
                            fit: BoxFit.contain,
                          ))),
                ),
                Row(
                  // crossAxisAlignment: CrossAxisAlignment.,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          isCheck = !isCheck;
                        });
                      },
                      icon: Icon(
                        isCheck
                            ? Icons.check_box_outlined
                            : Icons.check_box_outline_blank_outlined,
                        color: TColor.gray,
                        size: 20,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        "En continuant, vous acceptez notre Politique de\nconfidentialité et nos Conditions d'utilisation.",
                        style: TextStyle(color: TColor.gray, fontSize: 10),
                      ),
                    )
                  ],
                ),
                Visibility(
                    visible: _errorCreateUser,
                    child: Text("Error - $_msgError",
                        style: TextStyle(color: TColor.red))),
                SizedBox(
                  height: media.width * 0.4,
                ),
                RoundButton(
                    title: "Créer un compte",
                    onPressed: () async {
                      Tuple2<bool, String> result = await createUser();
                      if (result.item1) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginView()));
                      } else {
                        setState(() {
                          _errorCreateUser = true;
                          _msgError = result.item2;
                        });
                      }
                    }),
                SizedBox(
                  height: media.width * 0.04,
                ),
                Row(
                  // crossAxisAlignment: CrossAxisAlignment.,
                  children: [
                    Expanded(
                        child: Container(
                      height: 1,
                      color: TColor.gray.withOpacity(0.5),
                    )),
                    Text(
                      "  Ou  ",
                      style: TextStyle(color: TColor.black, fontSize: 12),
                    ),
                    Expanded(
                        child: Container(
                      height: 1,
                      color: TColor.gray.withOpacity(0.5),
                    )),
                  ],
                ),
                SizedBox(
                  height: media.width * 0.04,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 50,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: TColor.white,
                          border: Border.all(
                            width: 1,
                            color: TColor.gray.withOpacity(0.4),
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Image.asset(
                          "assets/img/google.png",
                          width: 20,
                          height: 20,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: media.width * 0.04,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 50,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: TColor.white,
                          border: Border.all(
                            width: 1,
                            color: TColor.gray.withOpacity(0.4),
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Image.asset(
                          "assets/img/suunto.png",
                          width: 35,
                          height: 35,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: media.width * 0.04,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginView()));
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Vous avez déjà un compte ? ",
                        style: TextStyle(
                          color: TColor.black,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "Se connecter",
                        style: TextStyle(
                            color: TColor.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: media.width * 0.04,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
