import 'package:flutter/material.dart';
import 'package:haldac/model/category_model.dart';
import 'package:haldac/model/dokter_model.dart';
import 'package:haldac/pages/profile_doctor.dart';
import 'package:haldac/theme.dart';
import 'foto.dart';

class DoctorCategoryCard extends StatelessWidget {
  // final Dokter? dokter;

  final DoctorModel? dokter;

  DoctorCategoryCard(this.dokter);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProfileDoctor(
                      dokter: dokter,
                    )));
      },
      child: Container(
        margin: EdgeInsets.only(top: 30, left: 20),
        child: Row(
          children: [
            FotoWidget(),
            SizedBox(
              width: 18,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${dokter!.name}',
                  style:
                      primaryText.copyWith(fontSize: 16, fontWeight: regular),
                ),
                Text('RP ${dokter!.price}',
                    style:
                        secondaryText.copyWith(fontSize: 12, fontWeight: light))
              ],
            )
          ],
        ),
      ),
    );
  }
}
