import 'package:flutter/material.dart';
import 'package:smartfit_app_mobile/common/colo_extension.dart';

class ContactUsView extends StatelessWidget {
  const ContactUsView({Key? key}) : super(key: key);

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
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset(
              "assets/img/black_btn.png",
              width: 15,
              height: 15,
              fit: BoxFit.contain,
            ),
          ),
        ),
        title: Text(
          "Nous Contacter",
          style: TextStyle(
            color: TColor.black,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      backgroundColor: TColor.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              
              SizedBox(height: media.width * 0.02),
              const Text(
                "Vous pouvez nous contacter pour toute question, suggestion ou problème concernant notre application SmartFit.",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: media.width * 0.05),
              const Text(
                "Adresse e-mail",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "contact@smartfitapp.com",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: media.width * 0.02),
              const Text(
                "Téléphone",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "+1234567890",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: media.width * 0.02),
              const Text(
                "Adresse",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "123 Rue SmartFit, Ville, Pays",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: media.width * 0.02),
              const Text(
                "Heures de bureau",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "Lundi - Vendredi : 9h00 - 18h00",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
