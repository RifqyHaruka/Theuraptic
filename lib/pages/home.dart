import 'dart:io';

import 'package:flutter/material.dart';
import 'package:haldac/pages/chat.dart';
import 'package:haldac/pages/history.dart';
import 'package:haldac/pages/main.dart';
import 'package:haldac/pages/notif.dart';
import 'package:haldac/pages/pilihan_profile.dart';
import 'package:haldac/pages/profile.dart';
import 'package:haldac/provider/auth_provider.dart';
import 'package:haldac/theme.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                    'assets/history.png',
                    width: 24,
                    height: 24,
                    color: (currentIndex == 1) ? primary : secondary,
                  ),
                  label: ''),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/Profile.png',
                    width: 24,
                    height: 24,
                    color: (currentIndex == 2) ? primary : secondary,
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
          return HistoryPage();
          break;
        case 2:
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
