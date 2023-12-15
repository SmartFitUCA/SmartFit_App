import 'package:flutter/foundation.dart';
import 'package:smartfit_app_mobile/common_widget/container/profile/profile_switch.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartfit_app_mobile/common/colo_extension.dart';
import 'package:smartfit_app_mobile/common_widget/container/profile/profile_compte.dart';
import 'package:smartfit_app_mobile/common_widget/container/profile/profile_entete.dart';
import 'package:smartfit_app_mobile/common_widget/container/profile/profile_info_user.dart';
import 'package:smartfit_app_mobile/common_widget/container/profile/profile_other.dart';
import 'package:smartfit_app_mobile/modele/api/api_wrapper.dart';
import 'package:smartfit_app_mobile/modele/user.dart';
import 'package:smartfit_app_mobile/modele/utile/info_message.dart';
import 'package:smartfit_app_mobile/view/login/signup_view.dart';
import 'package:tuple/tuple.dart';

class ProfileViewAllPlatforme extends StatefulWidget {
  final bool offlineSave;
  final List accountArr;
  final List otherArr;
  const ProfileViewAllPlatforme(
      this.offlineSave, this.accountArr, this.otherArr,
      {super.key});

  @override
  State<ProfileViewAllPlatforme> createState() => _ProfileViewAllPlatforme();
}

class _ProfileViewAllPlatforme extends State<ProfileViewAllPlatforme> {
  bool isNative = !kIsWeb;

  @override
  Widget build(BuildContext context) {
    ApiWrapper wrapper = ApiWrapper();
    String username = context.watch<User>().username;
    InfoMessage infoManager = InfoMessage();

    void logOff() {
      // Appel ici pour logOff
      /*
      if (!result.item1) {
        // Affiché erreur
      } else {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginView()));
      }*/
    }

    void deleteUser() async {
      // Ne marche pas !!
      Tuple2 result = await wrapper.deleteUser(
          Provider.of<User>(context, listen: false).token, infoManager);
      if (!result.item1) {
        // Affiché erreur
      } else {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const SignUpView()));
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColor.white,
        centerTitle: true,
        elevation: 0,
        leadingWidth: 0,
        title: Text(
          "Profile",
          style: TextStyle(
              color: TColor.black, fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
      backgroundColor: TColor.white,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ProfileEntete(username),
              const SizedBox(
                height: 15,
              ),
              const ProfileInfoUser(),
              const SizedBox(
                height: 25,
              ),
              ProfileCompte(widget.accountArr),
              const SizedBox(
                height: 25,
              ),
              Visibility(
                  visible: isNative,
                  child: const Column(
                    children: [
                      ProfileSwitch("Offline mode", "Save your files locally",
                          "local_save.png"),
                      SizedBox(
                        height: 25,
                      )
                    ],
                  )),
              ProfileOther(widget.otherArr),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: TColor.primaryColor1,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                    onPressed: logOff,
                    child: const Text('Déconnexion',
                        style: TextStyle(color: Colors.black)),
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: TColor.primaryColor1,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                    onPressed: deleteUser,
                    child: const Text('Supprimer son compte',
                        style: TextStyle(color: Colors.black)),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              )
            ],
          ),
        ),
      ),
    );
  }
}
