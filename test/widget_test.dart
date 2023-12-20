// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:smartfit_app_mobile/main.dart';
import 'package:smartfit_app_mobile/modele/activity.dart';
import 'package:smartfit_app_mobile/modele/activity_info/activity_info.dart';
import 'package:smartfit_app_mobile/modele/api/api_wrapper.dart';
import 'package:smartfit_app_mobile/modele/api/request_api.dart';
import 'package:smartfit_app_mobile/modele/user.dart';
import 'package:smartfit_app_mobile/modele/utile/signup_user.dart';
import 'package:tuple/tuple.dart';

void main() {
  testWidgets('Test login', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    //await tester.pumpWidget(const MyApp());

    //expect(find.text('Se connecter'), findsOneWidget);

    /*
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);*/
  });

  // Ce n'est pas possible de faire des test http =>
  //To test code that needs an HttpClient, provide your own HttpClient
  //implementation to the code under test, so that your test can
  //consistently provide a testable response to the code under test.
  /*
  test("Unit Test -- Create and delete User", () async {
    final SignUp utilSignUp = SignUp();
    final RequestApi requestApi = RequestApi();

    Tuple2 result =
        await utilSignUp.createUser("test@gmail.com", "test", "test");

    expect(result.item1, true);

    Tuple2 delete = await requestApi.deleteUser(result.item2);
    expect(delete.item1, true);
  });*/

  test("User", () {
    User user = User();
    ActivityOfUser activityOfUser =
        ActivityOfUser(ActivityInfo(), "CATEGORIE", "0000", "NAMEFILE");

    expect(user.listActivity.length, 0);

    user.addActivity(activityOfUser);

    expect(user.listActivity.length, 1);

    user.removeActivity(activityOfUser);

    expect(user.listActivity.length, 0);
  });
}
