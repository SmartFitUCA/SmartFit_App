import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartfit_app_mobile/common_widget/container/workout_row.dart';
import 'package:smartfit_app_mobile/modele/activity.dart';
import 'package:smartfit_app_mobile/modele/manager_file.dart';
import 'package:smartfit_app_mobile/modele/user.dart';
import 'package:smartfit_app_mobile/modele/utile/list_activity/list_activity_utile.dart';
import 'package:tuple/tuple.dart';

class ListActivityWidget extends StatefulWidget {
  const ListActivityWidget({Key? key}) : super(key: key);

  @override
  State<ListActivityWidget> createState() => _ListActivityWidget();
}

class _ListActivityWidget extends State<ListActivityWidget> {
  final ListActivityUtile _utile = ListActivityUtile();
  final ManagerFile managerFile = ManagerFile();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: Provider.of<User>(context, listen: true).listActivity.length,
        itemBuilder: (context, index) {
          ActivityOfUser activityObj =
              Provider.of<User>(context, listen: true).listActivity[index];
          Map<String, dynamic> activityMap;
          // -- Si categorie == marche
          if (activityObj.category == managerFile.marche) {
            activityMap = activityObj.toMapWalking();
          } else {
            // -- Default -- //
            activityMap = activityObj.toMapGeneric();
          }

          return InkWell(
            onTap: () {},
            child: WorkoutRow(
              wObj: activityMap,
              onDelete: () async {
                if (await _utile.deleteFileOnBDD(
                    Provider.of<User>(context, listen: false).token,
                    activityObj.fileUuid)) {
                  if (!Provider.of<User>(context, listen: false)
                      .managerSelectedActivity
                      .fileNotSelected(activityObj.fileUuid)) {
                    Provider.of<User>(context, listen: false)
                        .managerSelectedActivity
                        .removeSelectedActivity(activityObj.fileUuid);
                  }
                  Provider.of<User>(context, listen: false)
                      .removeActivity(activityObj);
                }
              },
              onClick: () async {
                if (!Provider.of<User>(context, listen: false)
                    .managerSelectedActivity
                    .fileNotSelected(activityObj.fileUuid)) {
                  Provider.of<User>(context, listen: false)
                      .managerSelectedActivity
                      .removeSelectedActivity(activityObj.fileUuid);
                  setState(() {});
                  return;
                }

                Tuple2<bool, String> result =
                    await _utile.getContentActivity(context, activityObj);
                if (!result.item1) {
                  return;
                }

                Provider.of<User>(context, listen: false)
                    .removeActivity(activityObj);
                Provider.of<User>(context, listen: false)
                    .insertActivity(0, activityObj);
              },
              isSelected: !Provider.of<User>(context)
                  .managerSelectedActivity
                  .fileNotSelected(activityObj.fileUuid),
            ),
          );
        },
      ),
    );
  }
}
