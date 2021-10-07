import 'package:flutter/material.dart';
import 'package:haldac/theme.dart';

class Loading extends StatelessWidget {
  double? margin;
  Loading({this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: margin as double, left: 30, right: 30),
      width: MediaQuery.of(context).size.width - 60,
      height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: buttonHijau),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Loading',
              style: whiteText.copyWith(fontSize: 18, fontWeight: semiBold),
            ),
            SizedBox(
              width: 8,
            ),
            SizedBox(
              child: CircularProgressIndicator(
                backgroundColor: white,
              ),
              width: 16,
              height: 16,
            )
          ],
        ),
      ),
    );
  }
}
