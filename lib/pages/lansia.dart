import 'package:flutter/material.dart';
import 'package:haldac/model/category_model.dart';
import 'package:haldac/pages/pilihaLogin.dart';
import 'package:haldac/provider/auth_provider.dart';
import 'package:haldac/theme.dart';
import 'package:provider/provider.dart';

class InfoLansia extends StatelessWidget {
  const InfoLansia({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    Widget header() {
      return Container(
        margin: EdgeInsets.only(top: 30, left: 16, bottom: 10),
        child: Text(
          'Info kesehatan Dewasa dan \nLansia',
          style: primaryText.copyWith(fontSize: 18, fontWeight: medium),
        ),
      );
    }

    Widget button(String? text) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => PilihanLogin()));
        },
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20, top: 15),
          child: Container(
            width: MediaQuery.of(context).size.width - 40,
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: hijauBlock),
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    text as String,
                    style:
                        whiteText.copyWith(fontSize: 14, fontWeight: semiBold),
                  ),
                  Icon(
                    Icons.arrow_right,
                    color: white,
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }

    Widget content() {
      return Container(
        margin: EdgeInsets.only(top: 100),
        child: Column(
          children: [
            GestureDetector(child: button('Gangguan Kesehatan')),
            button('Pola Makan'),
            button('Tips latihan atau terapi'),
          ],
        ),
      );
    }

    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              width: double.infinity,
              decoration: BoxDecoration(color: hijauBlock),
              child: header()),
          content()
        ],
      ),
    ));
  }
}
