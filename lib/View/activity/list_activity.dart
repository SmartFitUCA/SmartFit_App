import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';
import 'package:smartfit_app_mobile/Modele/Api/i_data_strategy.dart';
import 'package:smartfit_app_mobile/Modele/Api/request_api.dart';
import 'package:smartfit_app_mobile/Modele/activity.dart';
import 'package:smartfit_app_mobile/Modele/manager_file.dart';
import 'package:smartfit_app_mobile/Modele/user.dart';
import 'package:smartfit_app_mobile/View/home/home_view.dart';
import 'package:smartfit_app_mobile/View/main_tab/main_tab_view.dart';
import 'package:smartfit_app_mobile/common_widget/round_button.dart';
import 'package:smartfit_app_mobile/common_widget/workout_row.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:simple_animation_progress_bar/simple_animation_progress_bar.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:tuple/tuple.dart';
import '../../common/colo_extension.dart';

class ListActivity extends StatefulWidget {
  const ListActivity({super.key});

  @override
  State<ListActivity> createState() => _ListActivityState();
}

class _ListActivityState extends State<ListActivity> {
  FilePickerResult? result;
  IDataStrategy strategy = RequestApi();

  //late File x = File(file.path);
  Future<void> readFile(String nom) async {
    ManagerFile x = ManagerFile();
    PlatformFile t = result!.files.single;
    String? y = t.path;
    if (t.path == null) {
      print("t");
    } else {
      List<dynamic> result = await x.readFitFile(y!);
      print("test11");
      print(result);
      print("test22");
      print(ActivityOfUser(nom, result).getHeartRateWithTime());
      print("test33");
      Provider.of<User>(context, listen: false).addActivity(ActivityOfUser(nom, result));
      //print(x.getDistanceWithTime(ActivityOfUser(result)));
      //print(x.getDistance(ActivityOfUser(result)));
      //print(x.getAltitudeWithTime(ActivityOfUser(result)));
      //print(x.getSpeedWithTime(ActivityOfUser(result)));
    }
  }

  Future<void> createUser() async {
    String mds = "1234";
    var byte = utf8.encode(mds);
    var digest = sha256.convert(byte);
    print(digest.toString());
    print("Appel");
    Tuple2<bool, String> res =
        await strategy.postUser("toto@gmail.com", digest.toString(), "toto");
    print(res.item1);
    print(res.item2);
  }

  Future<void> login() async {
    String mds = "1234";
    var byte = utf8.encode(mds);
    var digest = sha256.convert(byte);
    print(digest.toString());
    print("Appel");
    Tuple2<bool, String> res =
        await strategy.connexion("toto@gmail.com", digest.toString());
    print(res.item1);
    print(res.item2);
  }

  Future<void> deleteUser() async {
    String token =
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1dWlkIjoiYjA3OThmMjAtN2ZiMy0xMWVlLWJhZmQtMDI0MjBhNWEwMDFmIiwiZXhwIjoxNzA0ODgyNDI3fQ.2_bnvEC7_pwchielF3Kpu9fFtXDv_KabdOU8T07UnWI";
    print("Appel");
    Tuple2<bool, String> res = await strategy.deleteUser(token);
    print(res.item1);
    print(res.item2);
  }

  Future<void> getFiles() async {
    String token =
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1dWlkIjoiOGUyYWVmMTItN2ZiNC0xMWVlLWJhZmQtMDI0MjBhNWEwMDFmIiwiZXhwIjoxNzA0ODgyNzk3fQ.b_zsOHj2C-Y28CrcozbSjEz8BUWL8kgjjx5CDhES8PI";
    print("Appel");
    Tuple2 res = await strategy.getFiles(token);
    print(res.item1);
    print(res.item2);
  }

  Future<void> modifAttribut() async {
    String nameAtt = "username";
    String newValue = "toto2";
    String token =
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1dWlkIjoiOGUyYWVmMTItN2ZiNC0xMWVlLWJhZmQtMDI0MjBhNWEwMDFmIiwiZXhwIjoxNzA0ODgzMDM4fQ.umN7LmUDbKUOeIToLcsOUIioQ7u4wsReHggRDB68VPQ";
    print("Appel");
    Tuple2 res = await strategy.modifAttribut(token, nameAtt, newValue);
    print(res.item1);
    print(res.item2);
  }

  Future<void> uploadFile() async {
    PlatformFile t = result!.files.single;
    String token =
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1dWlkIjoiOGUyYWVmMTItN2ZiNC0xMWVlLWJhZmQtMDI0MjBhNWEwMDFmIiwiZXhwIjoxNzA0ODgzNjM5fQ.0TmfJ9eYnszw4_RkNwPkMzkJxvsIFs5BI9uhQ7qYb0g";
    String? lol = t.path!;
    print("Appel");
    Tuple2 res = await strategy.uploadFile(token, File(lol));
    print(res.item1);
    print(res.item2);
  }

  Future<void> getOneFile() async {
    String ui = "fc6e234c-7fc6-11ee-bafd-02420a5a001f";
    String token =
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1dWlkIjoiOGUyYWVmMTItN2ZiNC0xMWVlLWJhZmQtMDI0MjBhNWEwMDFmIiwiZXhwIjoxNzA0ODgzOTE3fQ.TUdrGEo7A0auQlUfO5RQm874QWuGXFBSKbJ8qTGPF2M";
    print("Appel");
    Tuple2 res = await strategy.getFile(token, ui);
    print(res.item1);
    print(res.item2);

    ManagerFile x = ManagerFile();
    File file = File("${await x.localPath}/Walking_2023-11-08T10_57_28.fit");
    await file.create();
    await file.writeAsBytes(res.item2);
    print(await x.localPath);
    print("Save");

    print(await x
        .readFitFile("${await x.localPath}/Walking_2023-11-08T10_57_28.fit"));
  }

  Future<void> getInfoUser() async {
    String token =
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1dWlkIjoiOGUyYWVmMTItN2ZiNC0xMWVlLWJhZmQtMDI0MjBhNWEwMDFmIiwiZXhwIjoxNzA0ODgzOTE3fQ.TUdrGEo7A0auQlUfO5RQm874QWuGXFBSKbJ8qTGPF2M";
    Tuple2 res = await strategy.getInfoUser(token);
    print(res.item1);
    print(res.item2);
  }

  List lastWorkoutArr = [];


  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;



    return Scaffold(
      backgroundColor: TColor.white,
      body: SingleChildScrollView(
        child:  SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    
                    Text(
                      "List Activités",
                      style: TextStyle(
                          color: TColor.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                    TextButton(
                      onPressed: () async {
                        result = await FilePicker.platform.pickFiles();
                        if (result == null) {
                          print("No file selected");
                        } else {
                          for (var element in result!.files) {
                            readFile(element.name);
                            print(element.name);

                          }
                        }
                      },
                      child: Text(
                        "Ajouter",
                        style: TextStyle(
                            color: TColor.gray,
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                    )
                  ],
                ),
                Provider.of<User>(context, listen: true).listActivity.isEmpty
                ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text(
                    "Vous n'avez pas d'activités pour le moment, veuillez en ajouter.",
                    style: TextStyle(
                      color: TColor.gray,
                      fontSize: 11,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w400,
                    ),
                  )])
                :
                ListView.builder(
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: Provider.of<User>(context, listen: true).listActivity.length,
                    itemBuilder: (context, index) {
                      var activityObj = Provider.of<User>(context, listen: true).listActivity[index] as ActivityOfUser;
                      var activityMap = activityObj.toMap();
                      return InkWell(
                          onTap: () {
                            Provider.of<User>(context, listen: false).removeActivity(activityObj);
                            Provider.of<User>(context, listen: false).insertActivity(0, activityObj);
                          },
                          child: WorkoutRow(
                            wObj: activityMap,
                            onDelete: () {
                              Provider.of<User>(context, listen: false).removeActivity(activityObj);
                            },
                            onClick: () {
                              Provider.of<User>(context, listen: false).removeActivity(activityObj);
                              Provider.of<User>(context, listen: false).insertActivity(0, activityObj);
                            },
                          ));
                    }),
                SizedBox(
                  height: media.width * 0.1,
             ),
          ],
        ),
      ), 
    ), 
  ), 
); 
  }

 
}