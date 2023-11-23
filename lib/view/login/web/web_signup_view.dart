import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smartfit_app_mobile/modele/utile/signup_user.dart';
import 'package:smartfit_app_mobile/view/login/login_view.dart';
import 'package:smartfit_app_mobile/common/colo_extension.dart';
import 'package:smartfit_app_mobile/common_widget/button/round_button.dart';
import 'package:smartfit_app_mobile/common_widget/text_field/round_text_field.dart';
import 'package:tuple/tuple.dart';

class WebSignUpView extends StatefulWidget {
  const WebSignUpView({super.key});

  @override
  State<WebSignUpView> createState() => _WebSignUpView();
}

class _WebSignUpView extends State<WebSignUpView> {
  final SignUp util = SignUp();

  bool _obscureText = true;
  bool _errorCreateUser = false;
  bool _isCheck = false;
  String _msgError = "";
  bool emailValidate = false;
  bool passwordValidate = false;
  bool usernameValidate = false;

  final controllerTextEmail = TextEditingController();
  final controllerUsername = TextEditingController();
  final controllerTextPassword = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Start listening to changes.
    controllerTextEmail.addListener(checkEmail);
    controllerTextPassword.addListener(checkPassword);
    controllerUsername.addListener(checkUsername);
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
      _errorCreateUser = true;
    });
  }

  void checkEmail() {
    if (!controllerTextEmail.text.contains("@") &&
        !(controllerTextEmail.text.length > 6)) {
      emailValidate = false;
      // Faire un affichage
      return;
    } // Enlever l'affichage
    emailValidate = true;
  }

  void checkPassword() {
    if (!(controllerTextEmail.text.length >= 4)) {
      passwordValidate = false;
      //Faire un affichage
      return;
    } // Enlever l'affichage
    passwordValidate = true;
  }

  void checkUsername() {
    if (controllerUsername.text.isEmpty) {
      usernameValidate = false;
      return;
    }
    usernameValidate = true;
  }

  void _check() {
    setState(() {
      _isCheck = !_isCheck;
    });
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: TColor.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 300),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: media.width * 0.04,
              ),
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
              RoundTextField(
                hitText: "Prénom",
                icon: "assets/img/user_text.svg",
                controller: controllerUsername,
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
                      _check();
                    },
                    icon: Icon(
                      _isCheck
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
                height: media.width * 0.05,
              ),
              RoundButton(
                  title: "Créer un compte",
                  onPressed: () async {
                    if (!emailValidate ||
                        !passwordValidate ||
                        !usernameValidate) {
                      _printMsgError("Les champs renseigné ne sont pas valide");
                      return;
                    }
                    Tuple2<bool, String> result = await util.createUser(
                        controllerTextEmail.text,
                        controllerUsername.text,
                        controllerTextPassword.text);
                    if (result.item1) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginView()));
                    } else {
                      _printMsgError(result.item2);
                    }
                  }),
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
            ],
          ),
        ),
      ),
    );
  }
}
