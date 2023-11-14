import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smartfit_app_mobile/View/main_tab/main_tab_view.dart';
import 'package:smartfit_app_mobile/common/colo_extension.dart';
import 'package:smartfit_app_mobile/common_widget/round_button.dart';
import 'package:smartfit_app_mobile/common_widget/round_text_field.dart';
import 'package:tuple/tuple.dart';

class AndroidLoginView extends StatelessWidget {
  AndroidLoginView(
      this._obscureText,
      this._errorLogin,
      this._msgError,
      this._toggle,
      this._printMsgError,
      this.getUserInfo,
      this.checkLoginAndPassword,
      this.fillUser,
      {super.key});

  bool _obscureText;
  bool _errorLogin;
  final String _msgError;

  final controllerTextEmail = TextEditingController();
  final controllerTextPassword = TextEditingController();

  // ---- Fonction --- //
  final void Function() _toggle;
  final Future<Tuple2<bool, String>> Function(String email, String password)
      checkLoginAndPassword;
  final Future<Tuple2> Function(String token) getUserInfo;
  final void Function(String msgError) _printMsgError;
  final void Function(
      BuildContext context, Map<String, dynamic> map, String token) fillUser;

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: TColor.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            height: media.height * 0.9,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Bienvenue, Android",
                  style: TextStyle(color: TColor.gray, fontSize: 16),
                ),
                Text(
                  "Se connecter",
                  style: TextStyle(
                      color: TColor.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: media.width * 0.05,
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
                  controller: controllerTextPassword,
                  hitText: "Mot de passe",
                  icon: "assets/img/lock.svg",
                  obscureText: _obscureText,
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Mot de passe oublié ?",
                      style: TextStyle(
                          color: TColor.gray,
                          fontSize: 15,
                          decoration: TextDecoration.underline),
                    ),
                  ],
                ),
                SizedBox(
                  height: media.width * 0.04,
                ),
                Visibility(
                    visible: _errorLogin,
                    child: Text("Error - $_msgError",
                        style: TextStyle(color: TColor.red))),
                const Spacer(),
                RoundButton(
                    title: "Se connecter",
                    onPressed: () async {
                      Tuple2<bool, String> result = await checkLoginAndPassword(
                          controllerTextEmail.text,
                          controllerTextPassword.text);

                      if (result.item1 == true) {
                        Tuple2 infoUser = await getUserInfo(result.item2);

                        if (infoUser.item1 == false) {
                          //print("Erreur - Impossible de récupéré les données de l'utilisateur");
                          _printMsgError(
                              "Impossible de récupéré les données de l'utilisateur - {$infoUser.item2}");
                        } else {
                          fillUser(context, infoUser.item2, result.item2);

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MainTabView()));
                        }
                      } else {
                        _printMsgError("Connexion refuser - ${result.item2}");
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
                      "  Or  ",
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
                    Navigator.pop(context);
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Vous n'avez pas toujours pas de compte ?  ",
                        style: TextStyle(
                          color: TColor.black,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "Créer un compte",
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
