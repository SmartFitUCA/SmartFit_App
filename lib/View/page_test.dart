import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

import 'package:provider/provider.dart';
import 'package:smartfit_app_mobile/Modele/Api/i_data_strategy.dart';
import 'package:smartfit_app_mobile/Modele/Api/request_api.dart';
import 'package:smartfit_app_mobile/Modele/activity.dart';
import 'package:smartfit_app_mobile/Modele/manager_file.dart';
import 'package:smartfit_app_mobile/Modele/user.dart';
import 'package:tuple/tuple.dart';

// ----------- File --------------- //

// Dossier de l'application
Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

// Uri du fichier
Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/counter.txt');
}

Future<File> writeCounter(int counter) async {
  final file = await _localFile;
  // Write the file
  return file.writeAsString('$counter');
}

Future<int> readCounter() async {
  try {
    final file = await _localFile;

    // Read the file
    final contents = await file.readAsString();

    return int.parse(contents);
  } catch (e) {
    // If encountering an error, return 0
    return 0;
  }
}

// File picker

// ------------------------------------------------- //

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPage();
}

class _TestPage extends State<TestPage> {
  // Lire un fichier avec picker
  FilePickerResult? result;
  IDataStrategy strategy = RequestApi();

  //late File x = File(file.path);
  Future<void> readFile() async {
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
      print(x.getHeartRateWithTime(ActivityOfUser(result)));
      print("test33");
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text('A random AWESOME idea:'),
          const Text("User"),

          // ↓ Add this.
          ElevatedButton(
            onPressed: () {
              print('button pressed!');
            },
            child: Text('Next'),
          ),
          ElevatedButton(
              onPressed: () async {
                result = await FilePicker.platform.pickFiles();
                if (result == null) {
                  print("No file selected");
                } else {
                  for (var element in result!.files) {
                    print(element.name);
                  }
                }
              },
              child: const Text("File - ")),
          ElevatedButton(onPressed: login, child: const Text("Connexion")),
          ElevatedButton(
              onPressed: createUser, child: const Text("Create User")),
          ElevatedButton(
              onPressed: deleteUser, child: const Text("Delete User")),
          ElevatedButton(onPressed: getFiles, child: const Text("getFiles")),
          ElevatedButton(
              onPressed: modifAttribut, child: const Text("modif attribut")),
          ElevatedButton(
              onPressed: uploadFile, child: const Text("Upload File")),
          ElevatedButton(
              onPressed: getOneFile, child: const Text("Get One File")),
          ElevatedButton(
              onPressed: getInfoUser, child: const Text("Get info User"))
        ],
      ),
    );
  }
}


/*
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  void _updateText(String text) {
    setState(() {
      test = text;
    });
  }

  IDataStrategy tmp = RequestApi();
  //late Future<String> val = tmp.GetFile("x", "x");
  late Future<String> val = tmp.test();
  final TextEditingController _controller = TextEditingController();
  String test = "Null";

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),

      /*
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.

          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('TEST'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            FutureBuilder<String>(
              future: val,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[Text(snapshot.data!)],
                    );
                  }
                } else {
                  return const Text("FAIL");
                }
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
      */
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8),
        child: FutureBuilder<String>(
          future: val,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(snapshot.data!),
                    Text(test),
                    TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: 'Enter Title',
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _updateText(_controller.text);
                      },
                      child: const Text('Update Data'),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const TestPage()));
                        },
                        child: const Text("Changer de page"))
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
            }

            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
*/