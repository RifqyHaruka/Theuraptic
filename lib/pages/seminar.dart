import 'package:flutter/material.dart';
import 'package:haldac/theme.dart';

class SeminarPage extends StatelessWidget {
  const SeminarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        margin: EdgeInsets.only(top: 30, left: 16, bottom: 30),
        child: Text(
          'Seminar dan Pelatihan \nkesehatan',
          style: whiteText.copyWith(fontWeight: medium, fontSize: 18),
        ),
      );
    }

    Widget judulButton(String? text) {
      return Container(
        width: MediaQuery.of(context).size.width - 36,
        height: 50,
        decoration: BoxDecoration(
            color: hijauBlock, borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Expanded(
                child: Container(
              margin: EdgeInsets.only(left: 16),
              child: Text(
                text as String,
                style: whiteText.copyWith(fontSize: 12, fontWeight: semiBold),
              ),
            )),
            Container(
              margin: EdgeInsets.only(right: 16),
              width: 19,
              height: 19,
              decoration: BoxDecoration(
                  image:
                      DecorationImage(image: AssetImage('assets/panah.png'))),
            )
          ],
        ),
      );
    }

    Widget content() {
      return Container(
        margin: EdgeInsets.only(top: 26, right: 18, left: 18, bottom: 15),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          judulButton('Tema Seminar Kesehatan A'),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.only(left: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Lokasi',
                        style: blackText.copyWith(
                            fontSize: 12, fontWeight: semiBold),
                      ),
                      Text(
                        'Rumah Sakit A',
                        style: blackText.copyWith(
                            fontSize: 12, fontWeight: semiBold),
                      ),
                    ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tanggal',
                        style: blackText.copyWith(
                            fontSize: 12, fontWeight: semiBold),
                      ),
                      Text(
                        '20 Agustus 2021',
                        style: blackText.copyWith(
                            fontSize: 12, fontWeight: semiBold),
                      ),
                    ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Waktu',
                        style: blackText.copyWith(
                            fontSize: 12, fontWeight: semiBold),
                      ),
                      Text(
                        '09:00 - 11:00',
                        style: blackText.copyWith(
                            fontSize: 12, fontWeight: semiBold),
                      ),
                    ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Biaya',
                        style: blackText.copyWith(
                            fontSize: 12, fontWeight: semiBold),
                      ),
                      Text(
                        'Rp. 100.000',
                        style: blackText.copyWith(
                            fontSize: 12, fontWeight: semiBold),
                      ),
                    ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Status',
                        style: blackText.copyWith(
                            fontSize: 12, fontWeight: semiBold),
                      ),
                      Text(
                        'Offline',
                        style: blackText.copyWith(
                            fontSize: 12, fontWeight: semiBold),
                        textAlign: TextAlign.right,
                      ),
                    ]),
              ],
            ),
          )
        ]),
      );
    }

    return SafeArea(
        child: Scaffold(
      backgroundColor: white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                width: double.infinity,
                decoration: BoxDecoration(color: hijauBlock),
                child: header()),
            content(), content(), content(), content()
            // judulButton()
          ],
        ),
      ),
    ));
  }
}
