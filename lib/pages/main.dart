import 'package:flutter/material.dart';
import 'package:haldac/model/user_model.dart';
import 'package:haldac/pages/doktor_umum.dart';
import 'package:haldac/pages/info_kesehatan.dart';
import 'package:haldac/pages/seminar.dart';
import 'package:haldac/pages/shop_page.dart';
import 'package:haldac/provider/auth_provider.dart';
import 'package:haldac/provider/category_provider.dart';
import 'package:haldac/theme.dart';
import 'package:haldac/widget/artikel_card.dart';
import 'package:haldac/widget/best-doctor.dart';
import 'package:haldac/widget/category.dart';
import 'package:haldac/widget/consultation_category.dart';
import 'package:haldac/widget/foto.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
  UserModel user = UserModel();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    CategoryProvider categoryProvider = Provider.of<CategoryProvider>(context);

    handlerCategory(String? id) async {
      await categoryProvider.getData(id, authProvider.user.token);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => DoktorUmum()));
    }

    // Widget header() {
    //   return Container(
    //       margin: EdgeInsets.only(left: 16, top: 24, bottom: 10),
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Row(
    //             children: [
    //               FotoWidget(),
    //               SizedBox(width: 12),
    //               Expanded(
    //                 child: Text(
    //                   'Halo ' + (authProvider.user.username).toString(),
    //                   style:
    //                       blackText.copyWith(fontSize: 16, fontWeight: regular),
    //                 ),
    //               ),
    //               SizedBox(
    //                 width: 100,
    //               ),
    //               Container(
    //                 margin: EdgeInsets.only(right: 15),
    //                 child: Image.asset(
    //                   'assets/Notification.png',
    //                   width: 30,
    //                   height: 30,
    //                   color: white,
    //                 ),
    //               )
    //             ],
    //           ),
    //           SizedBox(
    //             height: 20,
    //           ),
    //           Text(
    //             'Pilih Layanan yang Anda \ninginkan',
    //             style: whiteText.copyWith(fontSize: 20, fontWeight: medium),
    //             textAlign: TextAlign.start,
    //           )
    //         ],
    //       ));
    // }

    // // Widget searchBox() {
    // //   return Container(
    // //     margin: EdgeInsets.only(top: 20, left: 16, right: 16),
    // //     width: double.infinity,
    // //     height: 40,
    // //     decoration: BoxDecoration(
    // //         borderRadius: BorderRadius.circular(20), color: white),
    // //     child: Row(
    // //       children: [
    // //         Expanded(
    // //             child: Container(
    // //           margin: EdgeInsets.only(left: 10),
    // //           child: TextFormField(
    // //             decoration: InputDecoration.collapsed(
    // //                 hintText: 'Search by Specialist',
    // //                 hintStyle: secondaryText.copyWith(
    // //                     fontSize: 12, fontWeight: regular)),
    // //           ),
    // //         )),
    // //         Container(
    // //           margin: EdgeInsets.only(right: 10),
    // //           child: Image.asset(
    // //             'assets/searchIcon.png',
    // //             width: 18,
    // //             height: 18,
    // //           ),
    // //         )
    // //       ],
    // //     ),
    // //   );
    // // }

    // Widget content() {
    //   return Container(
    //     margin: EdgeInsets.only(top: 25),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         SingleChildScrollView(
    //           scrollDirection: Axis.horizontal,
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceAround,
    //             children: [
    //               SizedBox(
    //                 width: 16,
    //               ),
    //               GestureDetector(
    //                   onTap: () {
    //                     Navigator.push(context,
    //                         MaterialPageRoute(builder: (context) {
    //                       return InfoKesehatan();
    //                     }));
    //                   },
    //                   child: CategoryCard(
    //                     text: 'Info \nKesehatan',
    //                     urlGambar: 'assets/infoKesehatan.png',
    //                   )),
    //               GestureDetector(
    //                   onTap: () {
    //                     Navigator.push(
    //                         context,
    //                         MaterialPageRoute(
    //                             builder: (context) => ShopPage()));
    //                   },
    //                   child: CategoryCard(
    //                     text: 'Alat \nTerapi',
    //                     urlGambar: 'assets/BelanjaMedic.png',
    //                   )),
    //               CategoryCard(
    //                 text: 'Terapis \nTerdekat',
    //                 urlGambar: 'assets/terdekat.png',
    //               ),
    //               GestureDetector(
    //                 onTap: () {
    //                   Navigator.push(
    //                       context,
    //                       MaterialPageRoute(
    //                           builder: (context) => SeminarPage()));
    //                 },
    //                 child: CategoryCard(
    //                   text: 'Seminar dan Pelatihan',
    //                   urlGambar: 'assets/Papan.png',
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //   );
    // }

    // Widget categoryKonsultasi() {
    //   return Container(
    //       margin: EdgeInsets.only(top: 30, left: 16, bottom: 30),
    //       child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             Text(
    //               'Cari Berdasarkan Kategori',
    //               style: primaryText.copyWith(fontWeight: medium, fontSize: 14),
    //             ),
    //             Container(
    //               margin: EdgeInsets.only(top: 10),
    //               child: Column(
    //                 children: [
    //                   Row(
    //                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                     children: [
    //                       GestureDetector(
    //                         onTap: () {
    //                           handlerCategory('1');
    //                         },
    //                         child: ConsultationCategory(
    //                           urlGambar: 'assets/LogoOkupasiTerapis.png',
    //                           textCategory: 'Okupasi \nTerapis',
    //                         ),
    //                       ),
    //                       GestureDetector(
    //                         onTap: () {
    //                           handlerCategory('2');
    //                         },
    //                         child: ConsultationCategory(
    //                           urlGambar: 'assets/TerapiWicaraLogo.png',
    //                           textCategory: 'Terapi \nWicara',
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                   Container(
    //                     margin: EdgeInsets.only(top: 20),
    //                     child: Row(
    //                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                       children: [
    //                         GestureDetector(
    //                           onTap: () {
    //                             handlerCategory('3');
    //                           },
    //                           child: ConsultationCategory(
    //                             urlGambar: 'assets/doctor.png',
    //                             textCategory: 'Psikolog',
    //                           ),
    //                         ),
    //                         GestureDetector(
    //                           onTap: () {
    //                             handlerCategory('4');
    //                           },
    //                           child: ConsultationCategory(
    //                             urlGambar: 'assets/walking kid.png',
    //                             textCategory: 'Fisioterapi',
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   )
    //                 ],
    //               ),
    //             )
    //           ]));
    // }

    // // Widget categoryKonsultasi() {
    // //   return Container(
    // //     margin: EdgeInsets.only(top: 30, left: 16, bottom: 30),
    // //     child: Column(
    // //       crossAxisAlignment: CrossAxisAlignment.start,
    // //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    // //       children: [
    // //         Text(
    // //           'Cari Berdasarkan Kategori',
    // //           style: primaryText.copyWith(fontWeight: medium, fontSize: 14),
    // //         ),
    // //         Container(
    // //           margin: EdgeInsets.only(top: 10, right: 30, left: 30),
    // //           child: Column(
    // //             children: [
    // //               Row(
    // //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    // //                   children: [
    // //                     GestureDetector(
    // //                       onTap: () {
    // //                         handlerCategory('1');
    // //                       },
    // //                       child: ConsultationCategory(
    // //                         urlGambar: 'assets/LogoOkupasiTerapis.png',
    // //                         textCategory: 'Okupasi \nTerapis',
    // //                       ),
    // //                     ),
    // //                     GestureDetector(
    // //                       onTap: () {
    // //                         handlerCategory('2');
    // //                       },
    // //                       child: ConsultationCategory(
    // //                         urlGambar: 'assets/TerapiWicaraLogo.png',
    // //                         textCategory: 'Terapi \nWicara',
    // //                       ),
    // //                     ),
    // //                   ]),
    // //               SizedBox(
    // //                 height: 20,
    // //               ),
    // //               Row(
    // //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    // //                   children: [
    // //                     GestureDetector(
    // //                       onTap: () {
    // //                         handlerCategory('3');
    // //                       },
    // //                       child: ConsultationCategory(
    // //                         urlGambar: 'assets/Psikolog.png',
    // //                         textCategory: 'Psikolog',
    // //                       ),
    // //                     ),
    // //                     GestureDetector(
    // //                       onTap: () {
    // //                         handlerCategory('4');
    // //                       },
    // //                       child: ConsultationCategory(
    // //                         urlGambar: 'assets/FisioterapiLogo.png',
    // //                         textCategory: 'Fisioterapi',
    // //                       ),
    // //                     ),
    // //                   ])
    // //             ],
    // //           ),
    // //         )
    // //       ],
    // //     ),
    // //   );
    // // }
    // // Widget bestDoctor() {
    // //   return Container(
    // //     margin: EdgeInsets.only(top: 30, left: 16, bottom: 20),
    // //     child: Column(
    // //       crossAxisAlignment: CrossAxisAlignment.start,
    // //       children: [
    // //         Text(
    // //           'Dokter Terbaik Kami',
    // //           style: primaryText.copyWith(fontSize: 14, fontWeight: medium),
    // //         ),
    // //         SizedBox(
    // //           height: 20,
    // //         ),
    // //         BestDoctor(),
    // //         SizedBox(
    // //           height: 20,
    // //         ),
    // //         BestDoctor(),
    // //         SizedBox(
    // //           height: 20,
    // //         ),
    // //         BestDoctor(),
    // //       ],
    // //     ),
    // //   );
    // // }

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
              child: FotoKecil(),
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              'Halo ' + (authProvider.user.name).toString(),
              style: whiteText.copyWith(fontWeight: semiBold, fontSize: 18),
            ),
            Spacer(),
            Container(
              margin: EdgeInsets.only(right: 15),
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/Notification.png'),
                      fit: BoxFit.cover)),
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
            Center(
              child: Column(children: [
                ArtikelCard(
                  urlGambar: 'assets/artikel1.png',
                  text:
                      'Jelang PPKM Level 4 Berakhir, Kasus Covid di RI Turun Banyak',
                ),
                ArtikelCard(
                  urlGambar: 'assets/artikel2.png',
                  text:
                      'Vaksin Moderna Vs Pfizer, Ini yang Lebih Kuat Lawan Corona Varian Delta',
                ),
                ArtikelCard(
                  urlGambar: 'assets/artikel1.png',
                  text:
                      'Jelang PPKM Level 4 Berakhir, Kasus Covid di RI Turun Banyak',
                ),
                ArtikelCard(
                  urlGambar: 'assets/artikel2.png',
                  text:
                      'Vaksin Moderna Vs Pfizer, Ini yang Lebih Kuat Lawan Corona Varian Delta',
                ),
              ]),
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
