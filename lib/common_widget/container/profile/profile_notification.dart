import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:smartfit_app_mobile/common/colo_extension.dart';

class ProfileNotification extends StatefulWidget {
  const ProfileNotification(this.positive, {Key? key}) : super(key: key);

  final bool positive;

  @override
  State<ProfileNotification> createState() => _ProfileNotification();
}

class _ProfileNotification extends State<ProfileNotification> {
  @override
  Widget build(BuildContext context) {
    bool check = widget.positive;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
          color: TColor.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 2)]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Notification",
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
              Image.asset("assets/img/p_notification.png",
                  height: 15, width: 15, fit: BoxFit.contain),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Text(
                  "Push Notifications",
                  style: TextStyle(
                    color: TColor.black,
                    fontSize: 12,
                  ),
                ),
              ),
              CustomAnimatedToggleSwitch<bool>(
                current: check,
                values: const [false, true],
                spacing: 0.0,
                indicatorSize: const Size.square(25.0),
                animationDuration: const Duration(milliseconds: 200),
                animationCurve: Curves.linear,
                onChanged: (b) => setState(() => check = b),
                iconBuilder: (context, local, global) {
                  return const SizedBox();
                },
                cursors: const ToggleCursors(
                    defaultCursor: SystemMouseCursors.click),
                onTap: (_) => setState(() => check = !check),
                iconsTappable: false,
                wrapperBuilder: (context, global, child) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                          left: 10.0,
                          right: 10.0,
                          height: 20.0,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              gradient:
                                  LinearGradient(colors: TColor.secondaryG),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(50.0)),
                            ),
                          )),
                      child,
                    ],
                  );
                },
                foregroundIndicatorBuilder: (context, global) {
                  return SizedBox.fromSize(
                    size: const Size(5, 5),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: TColor.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50.0)),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black38,
                              spreadRadius: 0.05,
                              blurRadius: 1.1,
                              offset: Offset(0.0, 0.8))
                        ],
                      ),
                    ),
                  );
                },
              ),
            ]),
          )
        ],
      ),
    );
  }
}
