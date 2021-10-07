import 'package:flutter/material.dart';
import 'package:haldac/pages/profile_doctor.dart';
import 'package:haldac/provider/category_provider.dart';
import 'package:haldac/provider/dokter_provider.dart';
import 'package:haldac/theme.dart';
import 'package:haldac/widget/doctor_category.dart';
import 'package:provider/provider.dart';

class DoktorUmum extends StatelessWidget {
  const DoktorUmum({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DokterProvider dokterProvider = Provider.of<DokterProvider>(context);
    CategoryProvider categoryProvider = Provider.of<CategoryProvider>(context);
    Widget header() {
      return Container(
        margin: EdgeInsets.only(top: 100, left: 20, bottom: 10),
        child: Text(
          'Kunjungi Profil dan Pilih \nTenaga Profesional',
          style: whiteText.copyWith(fontSize: 18, fontWeight: medium),
        ),
      );
    }

    Widget content() {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: categoryProvider.dokter
              .map((dokter) => DoctorCategoryCard(dokter))
              .toList()

          // dokterProvider.dokter
          //     .map((dokter) => DoctorCategoryCard(dokter))
          //     .toList()

          // GestureDetector(
          //     onTap: () {
          //       Navigator.push(context, MaterialPageRoute(builder: (context) {
          //         return ProfileDoctor();
          //       }));
          //     },
          //     child: DoctorCategoryCard()),
          // DoctorCategoryCard(),
          // DoctorCategoryCard()

          );
    }

    return Scaffold(
      backgroundColor: white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                width: double.infinity,
                decoration: BoxDecoration(color: hijauBlock),
                child: header()),
            content()
          ],
        ),
      ),
    );
  }
}
