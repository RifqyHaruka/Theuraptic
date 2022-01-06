import 'package:flutter/material.dart';
import 'package:haldac/pages/daftarTherapis.dart';
import 'package:haldac/pages/loginTerapis.dart';

import 'package:haldac/theme.dart';

class PilihanLogin extends StatelessWidget {
  const PilihanLogin({Key? key}) : super(key: key);

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

    Widget button(String text, bool theu) {
      return GestureDetector(
        onTap: () {
          if (theu == false) {
            Navigator.pushNamed(context, '/daftar');
          } else {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => DaftarTerapis()));
          }
        },
        child: Container(
          margin: EdgeInsets.only(top: 8, right: 30),
          width: MediaQuery.of(context).size.width - 60,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: (theu == false) ? buttonHijau : buttonMerah),
          child: Center(
            child: Text(
              text,
              style: whiteText.copyWith(fontSize: 18, fontWeight: semiBold),
            ),
          ),
        ),
      );
    }

    Widget user(String text1, String text2, bool theu, {int? index}) {
      return Container(
        margin: EdgeInsets.only(top: (index == 1) ? 20 : 20, left: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text1,
              style: primaryText.copyWith(fontSize: 14, fontWeight: regular),
            ),
            button(text2, theu)
          ],
        ),
      );
    }

    Widget container2() {
      return Container(
        height: MediaQuery.of(context).size.height * 50 / 100,
        color: white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                color: white,
                width: double.infinity,
                margin: EdgeInsets.only(top: 30),
                child: Column(children: [
                  Text('Terapi kapanpun \ndan dimanapun',
                      style:
                          primaryText.copyWith(fontSize: 18, fontWeight: bold),
                      textAlign: TextAlign.center),
                  SizedBox(
                    height: 12,
                  ),
                ])),
            user(
              'Anda User ?',
              'Iya saya User',
              false,
              index: 1,
            ),
            user('Anda Terapis ?', 'Iya saya Terapis', true)
          ],
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        // body: child
        body: Column(
          children: [
            Flexible(flex: 1, child: container1()),
            Flexible(flex: 1, child: container2()),
          ],
        ),
      ),
    );
  }
}
