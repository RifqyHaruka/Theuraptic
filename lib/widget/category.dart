import 'package:flutter/material.dart';
import 'package:haldac/theme.dart';

class CategoryCard extends StatelessWidget {
  String? text;
  String? urlGambar;

  CategoryCard({this.text, this.urlGambar});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 16),
      child: Container(
        width: 139,
        height: 164,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.grey,
                  offset: Offset(6.0, -2.0),
                  blurRadius: 4.0)
            ],
            borderRadius: BorderRadius.circular(5),
            color: white,
            border: Border.all(width: 0.5)),
        child: Column(
          children: [
            Container(
              width: 40,
              height: 40,
              margin: EdgeInsets.only(top: 30, right: 30, left: 30),
              child: Image.asset(urlGambar as String),
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              text as String,
              style: primaryText.copyWith(fontSize: 16, fontWeight: regular),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
