import 'package:flutter/material.dart';
import 'package:haldac/theme.dart';

class ConsultationCategory extends StatelessWidget {
  String? urlGambar;
  String? textCategory;

  ConsultationCategory({this.textCategory, this.urlGambar});

  // Widget coba() {
  //   return Padding(
  //     padding: EdgeInsets.only(right: 16),
  //     child: Container(
  //       width: 90,
  //       height: 105,
  //       decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(30), color: white),
  //       child: Column(
  //         children: [
  //           Container(
  //             width: 38,
  //             height: 38,
  //             margin: EdgeInsets.only(top: 10, right: 30, left: 30),
  //             child: Image.asset(urlGambar as String),
  //           ),
  //           SizedBox(
  //             height: 18,
  //           ),
  //           Container(
  //             margin: EdgeInsets.only(right: 20, left: 30),
  //             child: Text(
  //               textCategory as String,
  //               style: primaryText.copyWith(fontSize: 11, fontWeight: regular),
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      width: 115,
      height: 130,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          // boxShadow: [
          //   BoxShadow(
          //       color: Colors.grey, offset: Offset(5.0, -4.0), blurRadius: 9.0)
          // ],
          color: white,
          border: Border.all(width: 0.1)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 50,
            height: 50,
            margin: EdgeInsets.only(top: 20, right: 30, left: 30),
            child: Image.asset(
              urlGambar as String,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Expanded(
            child: Text(
              textCategory as String,
              style: primaryText.copyWith(fontSize: 12, fontWeight: regular),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
