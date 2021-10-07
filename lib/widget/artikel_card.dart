import 'package:flutter/material.dart';
import 'package:haldac/theme.dart';

class ArtikelCard extends StatelessWidget {
  final String? urlGambar;
  final String? text;
  ArtikelCard({this.urlGambar, this.text});

  @override
  Widget build(BuildContext context) {
    // Widget container() {
    //   return Container(
    //       margin: EdgeInsets.only(top: 10, right: 15),
    //       width: 300,
    //       height: 131,
    //       child: Image.asset(
    //         'assets/artikel.png',
    //         fit: BoxFit.fill,
    //       ));
    // }

    // Widget text() {
    //   return Container(
    //     margin: EdgeInsets.only(left: 8, bottom: 5),
    //     child: (Text(
    //       'Prestasi dan Profil anak \nberkebutuhan khusus',
    //       textAlign: TextAlign.justify,
    //       style: whiteText.copyWith(fontSize: 12, fontWeight: semiBold),
    //     )),
    //   );
    // }
    return Container(
        margin: EdgeInsets.only(top: 8, bottom: 10),
        width: 315,
        height: 82,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: putihButek),
        child: Row(
          children: [
            Container(
                margin: EdgeInsets.only(left: 15),
                height: 65,
                width: 65,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(urlGambar as String),
                        fit: BoxFit.cover))),
            Expanded(
              child: Container(
                margin:
                    EdgeInsets.only(left: 16, top: 10, bottom: 10, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      text as String,
                      style:
                          blackText.copyWith(fontWeight: regular, fontSize: 10),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "22 Agustus 2021",
                      style:
                          blackText.copyWith(fontWeight: regular, fontSize: 8),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
