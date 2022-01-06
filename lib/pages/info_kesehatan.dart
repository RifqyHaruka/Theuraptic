import 'package:flutter/material.dart';
import 'package:haldac/provider/article_provider.dart';
import 'package:haldac/provider/auth_provider.dart';

import 'package:haldac/theme.dart';
import 'package:provider/provider.dart';

class InfoKesehatan extends StatelessWidget {
  const InfoKesehatan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    ArticleProvider articleProvider = Provider.of<ArticleProvider>(context);

    Widget header() {
      return Container(
        margin: EdgeInsets.only(top: 30, left: 16, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Info Kesehatan',
              style: whiteText.copyWith(fontSize: 18, fontWeight: medium),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              articleProvider.articleId.title.toString(),
              style: whiteText.copyWith(fontSize: 14, fontWeight: medium),
            )
          ],
        ),
      );
    }

    Widget content() {
      return Container(
        margin: EdgeInsets.only(top: 50),
        child: Column(
          children: [
            Center(
              child: Text(
                'Berdasarkan Usia',
                style: primaryText.copyWith(fontSize: 18, fontWeight: semiBold),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/anak');
                  },
                  child: Container(
                    width: 165,
                    height: 375,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 0.25),
                        color: white,
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      children: [
                        Container(
                            margin: EdgeInsets.only(top: 115),
                            child: Image.asset(
                              'assets/TumbuhKembangAnak.png',
                              width: 118,
                              height: 118,
                            )),
                        SizedBox(height: 12),
                        Text(
                          'Tumbuh \nKembang Anak',
                          style: primaryText.copyWith(
                              fontSize: 13, fontWeight: semiBold),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/lansia');
                  },
                  child: Container(
                    width: 165,
                    height: 375,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 0.25),
                        color: white,
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      children: [
                        Container(
                            margin: EdgeInsets.only(top: 115),
                            child: Image.asset(
                              'assets/DewasadanLansia.png',
                              width: 118,
                              height: 118,
                            )),
                        SizedBox(height: 12),
                        Text(
                          'Dewasa \ndan Lansia',
                          style: primaryText.copyWith(
                              fontSize: 13, fontWeight: semiBold),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )
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
            child: header(),
          ),
          content()
        ],
      ),
    ));
  }
}
