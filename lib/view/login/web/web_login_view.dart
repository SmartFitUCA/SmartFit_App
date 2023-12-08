import 'package:smartfit_app_mobile/modele/local_db/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smartfit_app_mobile/main.dart';
import 'package:smartfit_app_mobile/modele/utile/login_user.dart';
import 'package:smartfit_app_mobile/view/main_tab/main_tab_view.dart';
import 'package:smartfit_app_mobile/common/colo_extension.dart';
import 'package:smartfit_app_mobile/common_widget/button/round_button.dart';
import 'package:smartfit_app_mobile/common_widget/text_field/round_text_field.dart';
import 'package:tuple/tuple.dart';

class WebLoginView extends StatefulWidget {
  const WebLoginView({super.key});

  @override
  State<WebLoginView> createState() => _WebLoginView();
}

class _WebLoginView extends State<WebLoginView> {
  final Login util = Login();
  bool _obscureText = true;
  bool _errorLogin = false;
  String _msgError = "";
  bool emailValidate = false;
  bool passwordValidate = false;

  final controllerTextEmail = TextEditingController();
  final controllerTextPassword = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Start listening to changes.
    controllerTextEmail.addListener(checkEmail);
    controllerTextPassword.addListener(checkPassword);
  }

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _printMsgError(String msgError) {
    setState(() {
      _msgError = msgError;
      _errorLogin = true;
    });
  }

  void checkEmail() {
    /*
    if (!controllerTextEmail.text.contains("@") &&
        !(controllerTextEmail.text.length > 6)) {
      emailValidate = false;
      // Faire un affichage
      return;
    } // Enlever l'affichage*/
    emailValidate = true;
  }

  void checkPassword() {
    /*
    if (!(controllerTextEmail.text.length >= 4)) {
      passwordValidate = false;
      //Faire un affichage
      return;
    } // Enlever l'affichage*/
    passwordValidate = true;
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: TColor.white,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 300),
          height: media.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: media.width * 0.03,
              ),
              Text(
                "Bienvenue sur SmartFit",
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
              SizedBox(
                height: media.width * 0.01,
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
                    if (!emailValidate || !passwordValidate) {
                      _printMsgError("Les champs renseigné ne sont pas valide");
                      return;
                    }
                    Tuple2<bool, String> result =
                        await util.checkLoginAndPassword(
                            controllerTextEmail.text,
                            controllerTextPassword.text);

                    if (result.item1 == true) {
                      Tuple2 infoUser = await util.getUserInfo(result.item2);

                      if (infoUser.item1 == false) {
                        //print("Erreur - Impossible de récupéré les données de l'utilisateur");
                        _printMsgError(
                            "Impossible de récupéré les données de l'utilisateur - {$infoUser.item2}");
                      } else {
                        util.fillUser(context, infoUser.item2, result.item2);
                        localDB.userBox.put(User(0, infoUser.item2["username"],
                            infoUser.item2["email"], result.item2));
                        localDB.configBox.put(Config(0, false));
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
    );
  }
}
