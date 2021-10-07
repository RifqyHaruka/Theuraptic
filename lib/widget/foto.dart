import 'package:flutter/material.dart';

class FotoWidget extends StatelessWidget {
  const FotoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              image: AssetImage('assets/UserPic.png'), fit: BoxFit.cover)),
    );
  }
}

class FotoKecil extends StatelessWidget {
  const FotoKecil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              image: AssetImage('assets/profilePic.png'), fit: BoxFit.cover)),
    );
  }
}

class FotoAgakBesar extends StatelessWidget {
  const FotoAgakBesar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              image: AssetImage('assets/profilePic.png'), fit: BoxFit.cover)),
    );
  }
}

class FotoBesar extends StatelessWidget {
  const FotoBesar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              image: AssetImage('assets/profilePic.png'), fit: BoxFit.cover)),
    );
  }
}
