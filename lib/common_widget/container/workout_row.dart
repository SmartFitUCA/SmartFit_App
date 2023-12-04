import 'package:flutter_svg/svg.dart';
import 'package:smartfit_app_mobile/common/colo_extension.dart';
import 'package:flutter/material.dart';

class WorkoutRow extends StatelessWidget {
  final Map wObj;
  final bool isSelected;
  final VoidCallback onDelete;
  final VoidCallback onClick;

  const WorkoutRow({
    Key? key,
    required this.wObj,
    required this.onDelete,
    required this.onClick,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected
                ? const Color.fromARGB(255, 144, 252, 148)
                : Colors.transparent,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Material(
          color: isSelected
              ? const Color.fromARGB(255, 240, 255, 240)
              : Colors.transparent,
          child: InkWell(
            borderRadius:
                BorderRadius.circular(10), // Utiliser le même borderRadius
            splashColor: const Color.fromARGB(255, 42, 94, 44)
                .withOpacity(0.3), // Couleur du fond au survol
            onTap: onClick,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SvgPicture.asset(
                      wObj["image"].toString(),
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Type : ${wObj["categorie"].toString()}",
                          style: TextStyle(
                            color: TColor.black,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          "Date : ${wObj["date"].toString()}",
                          style: TextStyle(
                            color: TColor.black,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          "Temps : ${wObj["time"].toString()}",
                          style: TextStyle(
                            color: TColor.black,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          "Dénivelé positif : ${wObj["denivelePositif"].toString()}",
                          style: TextStyle(
                            color: TColor.black,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: onClick,
                        icon: Image.asset(
                          "assets/img/next_icon.png",
                          width: 30,
                          height: 30,
                          fit: BoxFit.contain,
                        ),
                      ),
                      IconButton(
                        onPressed: onDelete,
                        icon: Image.asset(
                          "assets/img/corbeille.png",
                          width: 30,
                          height: 30,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
