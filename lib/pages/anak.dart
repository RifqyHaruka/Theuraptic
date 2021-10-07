import 'package:flutter/material.dart';
import 'package:haldac/theme.dart';

class TumbuhKembangAnak extends StatelessWidget {
  const TumbuhKembangAnak({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        margin: EdgeInsets.only(top: 30, left: 16, bottom: 10),
        child: Text(
          'Info kesehatan tumbuh \nkembang anak',
          style: whiteText.copyWith(fontSize: 18, fontWeight: medium),
        ),
      );
    }

    Widget button(String? text) {
      return GestureDetector(
        onTap: () {},
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
            button('Gangguan tumbuh kembang anak '),
            button('Profil anak berkebutuhan khusus'),
            button('Nutrisi anak'),
            button('Pola Asuh')
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
              decoration: BoxDecoration(color: hijauBlock),
              width: double.infinity,
              child: header()),
          content()
        ],
      ),
    ));
  }
}
