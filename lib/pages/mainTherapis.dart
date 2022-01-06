import 'package:flutter/material.dart';
import 'package:haldac/pages/homeTherapis.dart';
import 'package:haldac/pages/pilihan_profile.dart';
import 'package:haldac/theme.dart';

class MainTherapis extends StatefulWidget {
  const MainTherapis({Key? key}) : super(key: key);

  @override
  _MainTherapisState createState() => _MainTherapisState();
}

class _MainTherapisState extends State<MainTherapis> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
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
          return HomeTherapis();
          break;

        case 1:
          return PilihanProfile();
          break;
        default:
          return HomeTherapis();
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
