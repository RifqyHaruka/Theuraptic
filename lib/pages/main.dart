import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:haldac/model/user_model.dart';
import 'package:haldac/pages/doktor_umum.dart';
import 'package:haldac/pages/history.dart';
import 'package:haldac/pages/webView.dart';
import 'package:haldac/provider/article_provider.dart';

import 'package:haldac/provider/auth_provider.dart';
import 'package:haldac/provider/category_provider.dart';
import 'package:haldac/services/article_services.dart';
import 'package:haldac/theme.dart';
import 'package:haldac/widget/artikel_card.dart';

import 'package:haldac/widget/consultation_category.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();

  UserModel user = UserModel();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    getArticle();

    super.initState();
  }

  bool? isLoading;

  getArticle() async {
    setState(() {
      isLoading = true;
    });

    SharedPreferences pref = await SharedPreferences.getInstance();
    await Provider.of<ArticleProvider>(context, listen: false)
        .getAllArticle(pref.getString('token').toString());

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    CategoryProvider categoryProvider = Provider.of<CategoryProvider>(context);
    ArticleProvider articleProvider = Provider.of<ArticleProvider>(context);

    handlerCategory(String? id) async {
      await categoryProvider.getData(id, authProvider.user.token);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => DoktorUmum()));
    }

    Widget header() {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: 115,
        decoration: BoxDecoration(
            color: hijauBlock,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(left: 10),
              child: CachedNetworkImage(
                  imageBuilder: (context, imageProvider) {
                    return Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover)));
                  },
                  imageUrl: (authProvider.user.photoUrl != null)
                      ? authProvider.user.photoUrl as String
                      : authProvider.user.profilePhotoUrl as String,
                  // progressIndicatorBuilder:
                  //     (context, url, downloadProgress) =>
                  //         CircularProgressIndicator(
                  //             value: downloadProgress.progress),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  placeholder: (context, url) => CircularProgressIndicator(),
                  fit: BoxFit.contain),
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              'Halo ' + (authProvider.user.name).toString(),
              style: whiteText.copyWith(fontWeight: semiBold, fontSize: 18),
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => WebViewe()));
              },
              child: Container(
                margin: EdgeInsets.only(right: 15),
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/Notification.png'),
                        fit: BoxFit.cover)),
              ),
            )
          ],
        ),
      );
    }

    Widget header2() {
      return Container(
        margin: EdgeInsets.only(top: 16, left: 16),
        child: Text(
          'Pilih Layanan yang Anda \ninginkan',
          style: primaryText.copyWith(fontSize: 18, fontWeight: medium),
        ),
      );
    }

    Widget kategoriTerapi() {
      return Container(
        margin: EdgeInsets.only(top: 16, left: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kategori Terapi',
              style: primaryText.copyWith(fontWeight: semiBold, fontSize: 18),
            ),
            Container(
              margin: EdgeInsets.only(top: 12),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        handlerCategory('1');
                      },
                      child: ConsultationCategory(
                        textCategory: 'Okupasi \nTerapis',
                        urlGambar: 'assets/LogoOkupasiTerapis.png',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        handlerCategory('2');
                      },
                      child: ConsultationCategory(
                        textCategory: 'Terapis \nWicara',
                        urlGambar: 'assets/TerapiWicaraLogo.png',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        handlerCategory('3');
                      },
                      child: ConsultationCategory(
                        textCategory: 'Psikolog',
                        urlGambar: 'assets/doctorHijau.png',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        handlerCategory('4');
                      },
                      child: ConsultationCategory(
                        textCategory: 'Fisioterapi',
                        urlGambar: 'assets/walking kid.png',
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget artikel() {
      return Container(
        margin: EdgeInsets.only(top: 24, left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Artikel Info Kesehatan',
              style: primaryText.copyWith(fontSize: 18, fontWeight: semiBold),
            ),
            SizedBox(
              height: 12,
            ),
            (isLoading == true)
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Center(
                    child: Column(
                        children: articleProvider.article
                            .map((article) => ArtikelCard(article))
                            .toList()
                        // ArtikelCard(
                        //   urlGambar: 'assets/artikel1.png',
                        //   text:
                        //       'Jelang PPKM Level 4 Berakhir, Kasus Covid di RI Turun Banyak',
                        // ),
                        // ArtikelCard(
                        //   urlGambar: 'assets/artikel2.png',
                        //   text:
                        //       'Vaksin Moderna Vs Pfizer, Ini yang Lebih Kuat Lawan Corona Varian Delta',
                        // ),
                        // ArtikelCard(
                        //   urlGambar: 'assets/artikel1.png',
                        //   text:
                        //       'Jelang PPKM Level 4 Berakhir, Kasus Covid di RI Turun Banyak',
                        // ),
                        // ArtikelCard(
                        //   urlGambar: 'assets/artikel2.png',
                        //   text:
                        //       'Vaksin Moderna Vs Pfizer, Ini yang Lebih Kuat Lawan Corona Varian Delta',
                        // ),
                        ),
                  ),
          ],
        ),
      );
    }

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // header(), header2(), kategoriTerapi(), artikel(),
            header(), header2(), kategoriTerapi(),
            artikel() // categoryKonsultasi()
          ],
        ),
      ),
    );
  }
}
