import 'package:flutter/material.dart';
import 'package:smartfit_app_mobile/common/colo_extension.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({Key? key}) : super(key: key);

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
          "Politique de confidentialité",
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
              const Text(
                "Politique de confidentialité de SmartFit",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: media.width * 0.02),
              const Text(
                "Cette Politique de confidentialité explique comment SmartFit collecte, utilise, protège et partage vos informations lorsque vous utilisez notre application mobile SmartFit.",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: media.width * 0.05),
              const Text(
                "Collecte et Utilisation des Informations",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: media.width * 0.02),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "SmartFit recueille des données uniquement dans le but d'analyser et d'afficher des informations relatives à vos activités physiques à partir des données collectées par votre montre connectée. Ces informations peuvent inclure, sans toutefois s'y limiter :",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "• Données d'activité physique (comme la fréquence cardiaque, le nombre de pas, la distance parcourue, etc.)",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "• Données sur les habitudes de sommeil",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "• Informations de localisation (si l'option est activée par l'utilisateur)",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "• Préférences de l'utilisateur concernant les paramètres de l'application",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "Ces informations sont utilisées pour générer des graphiques, des statistiques et des recommandations personnalisées afin de vous aider dans vos objectifs de remise en forme.",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: media.width * 0.05),
              const Text(
                "Protection des Informations",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "SmartFit attache une grande importance à la sécurité de vos données. Nous mettons en place des mesures techniques et organisationnelles appropriées pour protéger vos informations contre tout accès non autorisé, altération, divulgation ou destruction.",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: media.width * 0.02),
              const Text(
                "Partage des Informations",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "Les données collectées par SmartFit ne seront pas partagées, vendues ou louées à des tiers à des fins de marketing ou de publicité sans votre consentement explicite.",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const Text(
                "Cependant, il est possible que nous partagions des informations avec des prestataires de services tiers qui nous aident à fournir et à améliorer notre application. Ces tiers sont tenus de protéger vos informations conformément à cette Politique de confidentialité.",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: media.width * 0.02),
              const Text(
                "Modifications de la Politique de Confidentialité",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "SmartFit se réserve le droit de mettre à jour cette Politique de confidentialité de temps à autre. Les modifications seront publiées sur cette page et entreront en vigueur dès leur publication.",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: media.width * 0.02),
              const Text(
                "Consentement",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "En utilisant l'application SmartFit, vous consentez à la collecte et à l'utilisation de vos informations telles que décrites dans cette Politique de confidentialité.",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const Text(
                "Pour toute question concernant cette Politique de confidentialité, veuillez nous contacter à l'adresse suivante : smartfit.contact@gmail.com",
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
