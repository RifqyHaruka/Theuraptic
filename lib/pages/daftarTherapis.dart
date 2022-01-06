import 'package:flutter/material.dart';
import 'package:haldac/pages/loginTerapis.dart';
import 'package:haldac/pages/registerTerapis.dart';
import 'package:haldac/theme.dart';

class DaftarTerapis extends StatefulWidget {
  const DaftarTerapis({Key? key}) : super(key: key);

  @override
  _DaftarTerapisState createState() => _DaftarTerapisState();
}

class _DaftarTerapisState extends State<DaftarTerapis> {
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RegisterTerapis()));
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginTerapis()));
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
