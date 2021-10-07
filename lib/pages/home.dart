import 'package:flutter/material.dart';
import 'package:haldac/pages/chat.dart';
import 'package:haldac/pages/main.dart';
import 'package:haldac/pages/notif.dart';
import 'package:haldac/pages/pilihan_profile.dart';
import 'package:haldac/pages/profile.dart';
import 'package:haldac/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    // Widget customButtonNav() {
    //   return ClipRRect(
    //     borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
    //     child: BottomAppBar(
    //       shape: CircularNotchedRectangle(),
    //       notchMargin: 5,
    //       clipBehavior: Clip.antiAliasWithSaveLayer,
    //       child: BottomNavigationBar(
    //           currentIndex: currentIndex,
    //           onTap: (value) {
    //             setState(() {
    //               currentIndex = value;
    //               print(currentIndex);
    //             });
    //           },
    //           backgroundColor: primary,
    //           type: BottomNavigationBarType.fixed,
    //           items: [
    //             BottomNavigationBarItem(
    //                 icon: Image.asset(
    //                   'assets/homeIcon.png',
    //                   width: 21,
    //                   height: 20,
    //                   color: (currentIndex == 0) ? primary : secondary,
    //                 ),
    //                 label: ''),
    //             BottomNavigationBarItem(
    //                 icon: Image.asset('assets/homeIcon.png',
    //                     width: 20,
    //                     height: 18,
    //                     color: (currentIndex == 1) ? primary : secondary),
    //                 label: ''),
    //             BottomNavigationBarItem(
    //                 icon: Image.asset('assets/homeIcon.png',
    //                     width: 20,
    //                     height: 18,
    //                     color: (currentIndex == 2) ? primary : secondary),
    //                 label: ''),
    //             BottomNavigationBarItem(
    //                 icon: Image.asset('assets/homeIcon.png',
    //                     width: 18,
    //                     height: 20,
    //                     color: (currentIndex == 3) ? primary : secondary),
    //                 label: '')
    //           ]),
    //     ),
    //   );
    // }

    Widget costumBottomNavBar() {
      return ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18), topRight: Radius.circular(18)),
        child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: white,
            onTap: (value) {
              setState(() {
                currentIndex = value;
                print(currentIndex);
              });
            },
            items: [
              BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/homeIcon.png',
                    width: 24,
                    height: 24,
                    color: (currentIndex == 0) ? primary : secondary,
                  ),
                  label: ''),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/notificationIcon.png',
                    width: 24,
                    height: 24,
                    color: (currentIndex == 1) ? primary : secondary,
                  ),
                  label: ''),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/FavIcon.png',
                    width: 24,
                    height: 24,
                    color: (currentIndex == 2) ? primary : secondary,
                  ),
                  label: ''),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/Profile.png',
                    width: 24,
                    height: 24,
                    color: (currentIndex == 3) ? primary : secondary,
                  ),
                  label: '')
            ]),
      );
    }

    Widget body() {
      switch (currentIndex) {
        case 0:
          return MainPage();
          break;
        case 1:
          return ChatPage();
          break;
        case 3:
          return PilihanProfile();
          break;
        default:
          return MainPage();
      }
    }

    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: costumBottomNavBar(),
        backgroundColor: white,
        body: body(),
      ),
    );
  }
}
