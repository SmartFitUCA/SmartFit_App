import 'package:flutter/material.dart';
import 'package:smartfit_app_mobile/common/colo_extension.dart';
import 'package:smartfit_app_mobile/common_widget/button/tab_button.dart';
import 'package:smartfit_app_mobile/view/activity/list_activity.dart';
import 'package:smartfit_app_mobile/view/activity/activity.dart';
import 'package:smartfit_app_mobile/view/home/home_view.dart';
import 'package:smartfit_app_mobile/view/home/prediction_view.dart';
import 'package:smartfit_app_mobile/view/map/my_map.dart';
import 'package:smartfit_app_mobile/view/profile/profile_view.dart';
import 'package:smartfit_app_mobile/view/volumes/volumes_view.dart';

class WebMainTabView extends StatefulWidget {
  const WebMainTabView({Key? key}) : super(key: key);

  @override
  State<WebMainTabView> createState() => _WebMainTabViewState();
}

class _WebMainTabViewState extends State<WebMainTabView> {
  int selectTab = 10; // Définissez l'onglet initial ici
  late Widget currentTab;

  @override
  void initState() {
    super.initState();
    currentTab = const HomeView(); // Onglet initial - HomeView
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.white,
      body: Row(
        children: <Widget>[
          // La barre latérale verticale
          Container(
            width: 70, // Largeur de la barre latérale
            color: TColor.white, // Couleur de la barre latérale
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                sideBarButton(
                  icon: "assets/img/Home_tab.svg",
                  selectIcon: "assets/img/Home_tab_select.svg",
                  index: 0,
                  onTap: () => updateTab(0, const HomeView()),
                ),
                sideBarButton(
                  icon: "assets/img/Activity_tab.svg",
                  selectIcon: "assets/img/Activity_tab_select.svg",
                  index: 1,
                  onTap: () => updateTab(1, const Activity()),
                ),
                sideBarButton(
                  icon: "assets/img/volumes.svg",
                  selectIcon: "assets/img/volumes_selected.svg",
                  index: 2,
                  onTap: () => updateTab(2, const VolumesView()),
                ),
                InkWell(
                  onTap: () {
                    updateTab(10, const ListActivity());
                  },
                  child: Container(
                    width: 65,
                    height: 65,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: TColor.primaryG,
                      ),
                      borderRadius: BorderRadius.circular(35),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 2,
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.search,
                      color: TColor.white,
                      size: 35,
                    ),
                  ),
                ),
                sideBarButton(
                  icon: "assets/img/prediction.svg",
                  selectIcon: "assets/img/prediction_selected.svg",
                  index: 3,
                  onTap: () => updateTab(3, const Prediction()),
                ),
                sideBarButton(
                  icon: "assets/img/mapIcon.svg",
                  selectIcon: "assets/img/mapIcon_selected.svg",
                  index: 4,
                  onTap: () => updateTab(4, const MyMap()),
                ),
                sideBarButton(
                  icon: "assets/img/Profile_tab.svg",
                  selectIcon: "assets/img/Profile_tab_select.svg",
                  index: 5,
                  onTap: () => updateTab(5, const ProfileView()),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: TColor.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 2,
                    offset: Offset(-2, 0), // Ajout d'une ombre sur le côté
                  ),
                ],
              ),
              child: Scaffold(
                backgroundColor: TColor.white,
                body: currentTab,
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerDocked,
                floatingActionButton: const SizedBox(
                  width: 70,
                  height: 70,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget sideBarButton({
    required String icon,
    required String selectIcon,
    required int index,
    required VoidCallback onTap,
  }) {
    return TabButton(
      icon: icon,
      selectIcon: selectIcon,
      isActive: selectTab == index,
      onTap: onTap,
    );
  }

  void updateTab(int index, Widget tabWidget) {
    setState(() {
      selectTab = index;
      currentTab = tabWidget;
    });
  }
}
