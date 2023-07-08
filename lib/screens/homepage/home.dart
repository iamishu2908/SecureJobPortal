import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:secure_job_portal/screens/homepage/chatpage.dart';
import 'package:secure_job_portal/screens/homepage/communitypage.dart';
import 'package:secure_job_portal/screens/homepage/mainpage.dart';
import 'package:secure_job_portal/screens/login%20+%20signup/signin_student.dart';
import 'package:flutter/material.dart';
import 'package:secure_job_portal/utils/color_utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<IconData> iconList = [
    //list of icons that required by animated navigation bar.
    Icons.people_alt_rounded,

    Icons.forum_rounded,
  ];
  int _bottomNavIndex = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Visibility(
        visible: MediaQuery.of(context).viewInsets.bottom == 0,
        child: FloatingActionButton(
            backgroundColor: primarytheme,
            child: Icon(
              Icons.home_rounded,
            ),
            onPressed: () {
              setState(() {
                _bottomNavIndex = 1;
              });
            }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        splashColor: Colors.white,
        //navigation bar
        icons: iconList, //list of icons
        activeIndex: _bottomNavIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.verySmoothEdge,
        onTap: (index) => setState(() => _bottomNavIndex = index),
        backgroundColor: whitetheme,
        inactiveColor: Colors.grey,
        activeColor: primarytheme,
      ),
      body: (_bottomNavIndex == 0)
          ? communitypage()
          : (_bottomNavIndex == 2)
              ? chatpage()
              : mainpage(),
    );
  }
}
