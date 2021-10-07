import 'package:flutter/material.dart';

import 'package:haldac/pages/main.dart';
import 'package:haldac/pages/sign_in.dart';
import 'package:haldac/provider/auth_provider.dart';
import 'package:haldac/theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DaftarPage extends StatefulWidget {
  const DaftarPage({Key? key}) : super(key: key);

  @override
  _DaftarPageState createState() => _DaftarPageState();
}

class _DaftarPageState extends State<DaftarPage> {
  bool isAuth = false;

  @override
  void initState() {
    _isLogin();
    super.initState();
  }

  void _isLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    var token = pref.get('token');

    // pref.get('user');

    if (token != null) {
      setState(() {
        isAuth = true;
      });
      print(token);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget container1() {
      return Container(
        height: MediaQuery.of(context).size.height * 50 / 100,
        width: double.infinity,
        decoration: BoxDecoration(
          color: hijauBlock,
        ),
        child: Container(
          margin: EdgeInsets.only(top: 80),
          child: Image.asset(
            'assets/DoktorSplash.png',
          ),
        ),
      );
    }

    Widget button() {
      return Container(
        margin: EdgeInsets.only(top: 50),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/sign-up');
              },
              child: Container(
                width: 150,
                height: 55,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5), color: buttonMerah),
                child: Center(
                  child: Text(
                    'Daftar',
                    style:
                        whiteText.copyWith(fontSize: 18, fontWeight: semiBold),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 100,
            ),
            SizedBox(
              width: 5,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/sign-in');
              },
              child: Container(
                width: 150,
                height: 55,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5), color: buttonHijau),
                child: Center(
                  child: Text(
                    'Masuk',
                    style:
                        whiteText.copyWith(fontSize: 18, fontWeight: semiBold),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget container2() {
      return Container(
        height: MediaQuery.of(context).size.height * 50 / 100,
        color: white,
        child: Container(
            color: white,
            width: double.infinity,
            margin: EdgeInsets.only(top: 50),
            child: Column(children: [
              Text('Terapi kapanpun \ndan dimanapun',
                  style: primaryText.copyWith(fontSize: 18, fontWeight: bold),
                  textAlign: TextAlign.center),
              SizedBox(
                height: 12,
              ),
              Text(
                  "Konsultasi dan hubungi dokter yang tepat \nsecara langsung melalui ponsel anda",
                  style:
                      primaryText.copyWith(fontSize: 14, fontWeight: regular),
                  textAlign: TextAlign.center),
              button()
            ])),
      );
    }

    // Widget button() {
    //   return Container(
    //     margin: EdgeInsets.only(top: 100),
    //     child: Row(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         GestureDetector(
    //           child: Container(
    //             width: 110,
    //             height: 55,
    //             decoration: BoxDecoration(
    //                 borderRadius: BorderRadius.circular(12),
    //                 color: buttonMerah),
    //             child: Center(
    //               child: Text(
    //                 'Daftar',
    //                 style:
    //                     whiteText.copyWith(fontSize: 18, fontWeight: semiBold),
    //               ),
    //             ),
    //           ),
    //         ),
    //         SizedBox(
    //           height: 100,
    //         ),
    //         SizedBox(
    //           width: 5,
    //         ),
    //         GestureDetector(
    //           onTap: () {
    //             Navigator.pushNamed(context, '/sign-in');
    //           },
    //           child: Container(
    //             width: 110,
    //             height: 55,
    //             decoration: BoxDecoration(
    //                 borderRadius: BorderRadius.circular(12),
    //                 color: buttonHijau),
    //             child: Center(
    //               child: Text(
    //                 'Masuk',
    //                 style:
    //                     whiteText.copyWith(fontSize: 18, fontWeight: semiBold),
    //               ),
    //             ),
    //           ),
    //         )
    //       ],
    //     ),
    //   );
    // }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        // body: child
        body: Column(
          children: [
            Flexible(flex: 1, child: container1()),
            Flexible(flex: 1, child: container2())
          ],
        ),
      ),
    );
  }
}
