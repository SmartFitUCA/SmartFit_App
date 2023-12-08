import 'package:flutter/material.dart';
import 'package:smartfit_app_mobile/common/colo_extension.dart';
import 'package:smartfit_app_mobile/main.dart';

class ProfileSwitch extends StatefulWidget {
  final String title;
  final String description;
  final String iconFilename;

  const ProfileSwitch(this.title, this.description, this.iconFilename,
      {super.key});

  @override
  State<ProfileSwitch> createState() => _ProfileSwitchState();
}

class _ProfileSwitchState extends State<ProfileSwitch> {
  bool switchValue = localDB.getSaveLocally();

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
            color: TColor.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 2)]),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            widget.title,
            style: TextStyle(
              color: TColor.black,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
              height: 30,
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Image.asset("assets/img/${widget.iconFilename}",
                    height: 28, width: 28, fit: BoxFit.contain),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Text(
                    widget.description,
                    style: TextStyle(
                      color: TColor.black,
                      fontSize: 12,
                    ),
                  ),
                ),
                Switch(
                    value: switchValue,
                    activeColor: Colors.orange,
                    onChanged: (bool value) {
                      setState(() {
                        switchValue = value;
                        localDB.setSaveLocally(switchValue);
                      });
                    }),
              ]))
        ]));
  }
}
