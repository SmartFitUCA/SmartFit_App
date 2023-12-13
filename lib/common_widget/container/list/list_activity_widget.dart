import 'package:smartfit_app_mobile/main.dart';
import 'package:smartfit_app_mobile/modele/activity_saver.dart';
import 'package:smartfit_app_mobile/modele/helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartfit_app_mobile/modele/api/api_wrapper.dart';
import 'package:smartfit_app_mobile/common_widget/container/workout_row/workout_row_generic.dart';
import 'package:smartfit_app_mobile/common_widget/container/workout_row/workout_row_walking.dart';
import 'package:smartfit_app_mobile/modele/activity.dart';
import 'package:smartfit_app_mobile/modele/manager_file.dart';
import 'package:smartfit_app_mobile/modele/user.dart';
import 'package:smartfit_app_mobile/modele/utile/info_message.dart';
import 'package:smartfit_app_mobile/modele/utile/list_activity/list_activity_utile.dart';
import 'package:tuple/tuple.dart';

class ListActivityWidget extends StatefulWidget {
  const ListActivityWidget({Key? key}) : super(key: key);

  @override
  State<ListActivityWidget> createState() => _ListActivityWidget();
}

class _ListActivityWidget extends State<ListActivityWidget> {
  final ApiWrapper api = ApiWrapper();
  final InfoMessage infoManager = InfoMessage();
  final ListActivityUtile _utile = ListActivityUtile();
  final ManagerFile managerFile = ManagerFile();

  @override
  Widget build(BuildContext context) {
    Future<void> onClick(ActivityOfUser activityObj) async {
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
          await _utile.getContentActivity(context, activityObj, infoManager);
      if (!result.item1) {
        return;
      }

      // TODO: Hein?
      Provider.of<User>(context, listen: false).removeActivity(activityObj);
      Provider.of<User>(context, listen: false).insertActivity(0, activityObj);
    }

    // TODO: Understand :(
    Future<void> onDelete(ActivityOfUser activityObj) async {
      if (await api.deleteFile(Provider.of<User>(context, listen: false).token,
          activityObj.fileUuid, infoManager)) {
        if (!Provider.of<User>(context, listen: false)
            .managerSelectedActivity
            .fileNotSelected(activityObj.fileUuid)) {
          Provider.of<User>(context, listen: false)
              .managerSelectedActivity
              .removeSelectedActivity(activityObj.fileUuid);
        }
        if (!Helper.isPlatformWeb() && localDB.getSaveLocally()) {
          ActivitySaver actSaver = await ActivitySaver.create();
          actSaver.deleteActivity(activityObj.fileUuid);
          localDB.removeActivity(activityObj.fileUuid);
        }
        Provider.of<User>(context, listen: false).removeActivity(activityObj);
      }
    }

    bool isSelected(ActivityOfUser activityObj) {
      return !Provider.of<User>(context)
          .managerSelectedActivity
          .fileNotSelected(activityObj.fileUuid);
    }

    return Material(
      color: Colors.transparent,
      child: Column(
        children: [
          Visibility(
              visible: infoManager.isVisible,
              child: Text(infoManager.message,
                  style: TextStyle(color: infoManager.messageColor))),
          ListView.builder(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount:
                Provider.of<User>(context, listen: true).listActivity.length,
            itemBuilder: (context, index) {
              ActivityOfUser activityObj =
                  Provider.of<User>(context, listen: true).listActivity[index];
              Map<String, dynamic> activityMap;
              // -- Si categorie == marche
              if (activityObj.category == managerFile.marche) {
                activityMap = activityObj.toMapWalking();
                return InkWell(
                  onTap: () {},
                  child: WorkoutRowWalking(
                    wObj: activityMap,
                    onDelete: () async {
                      await onDelete(activityObj);
                      setState(() {});
                    },
                    onClick: () async {
                      await onClick(activityObj);
                      setState(() {});
                    },
                    isSelected: isSelected(activityObj),
                  ),
                );
              } else {
                // -- Default -- //
                activityMap = activityObj.toMapGeneric();
                return InkWell(
                  onTap: () {},
                  child: WorkoutRowGeneric(
                    wObj: activityMap,
                    onDelete: () async {
                      await onDelete(activityObj);
                      setState(() {});
                    },
                    onClick: () async {
                      await onClick(activityObj);
                      setState(() {});
                    },
                    isSelected: isSelected(activityObj),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
