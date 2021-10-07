import 'package:flutter/material.dart';
import 'package:haldac/theme.dart';
import 'foto.dart';

class BestDoctor extends StatelessWidget {
  const BestDoctor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FotoWidget(),
        SizedBox(
          width: 14,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Alice Semesta',
              style: primaryText.copyWith(fontSize: 15, fontWeight: regular),
            ),
            Text(
              'Dokter Umum',
              style: secondaryText.copyWith(fontSize: 12, fontWeight: light),
            )
          ],
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }
}
