import 'package:smartfit_app_mobile/view/activity/list_activity.dart';
import 'package:smartfit_app_mobile/common/colo_extension.dart';
import 'package:smartfit_app_mobile/common_widget/button/tab_button.dart';
import 'package:smartfit_app_mobile/view/activity/activity.dart';
import 'package:smartfit_app_mobile/view/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:smartfit_app_mobile/view/map/my_map.dart';
import 'package:smartfit_app_mobile/view/profile/profile_view.dart';

class MainTabView extends StatefulWidget {
  const MainTabView({super.key});

  @override
  State<MainTabView> createState() => _MainTabViewState();
}

class _MainTabViewState extends State<MainTabView> {
  int selectTab = 0;
  final PageStorageBucket pageBucket = PageStorageBucket();
  Widget currentTab = const HomeView();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.white,
      body: PageStorage(bucket: pageBucket, child: currentTab),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        width: 70,
        height: 70,
        child: InkWell(
          onTap: () {
            selectTab = 4;
            currentTab = const ListActivity();
            if (mounted) {
              setState(() {});
            }
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
                  )
                ]),
            child: Icon(
              Icons.search,
              color: TColor.white,
              size: 35,
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
          child: Container(
        decoration: BoxDecoration(color: TColor.white, boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 2, offset: Offset(0, -2))
        ]),
        height: kToolbarHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TabButton(
                icon: "assets/img/Home_tab.svg",
                selectIcon: "assets/img/Home_tab_select.svg",
                isActive: selectTab == 0,
                onTap: () {
                  selectTab = 0;
                  currentTab = const HomeView();
                  if (mounted) {
                    setState(() {});
                  }
                }),
            TabButton(
                icon: "assets/img/Activity_tab.svg",
                selectIcon: "assets/img/Activity_tab_select.svg",
                isActive: selectTab == 1,
                onTap: () {
                  selectTab = 1;
                  currentTab = const Activity();
                  if (mounted) {
                    setState(() {});
                  }
                }),
            const SizedBox(
              width: 40,
            ),
            TabButton(
                icon: "assets/img/Camera_tab.svg",
                selectIcon: "assets/img/Camera_tab_select.svg",
                isActive: selectTab == 2,
                onTap: () {
                  selectTab = 2;
                  currentTab = const MyMap();
                  if (mounted) {
                    setState(() {});
                  }
                }),
            TabButton(
                icon: "assets/img/Profile_tab.svg",
                selectIcon: "assets/img/Profile_tab_select.svg",
                isActive: selectTab == 3,
                onTap: () {
                  selectTab = 3;
                  currentTab = const ProfileView();
                  if (mounted) {
                    setState(() {});
                  }
                })
          ],
        ),
      )),
    );
  }
}
