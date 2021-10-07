import 'package:flutter/material.dart';
import 'package:haldac/pages/rating_page.dart';
import 'package:haldac/theme.dart';

class PaymentSuccess extends StatelessWidget {
  const PaymentSuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget photoProfile() {
      return Container(
        margin: EdgeInsets.only(top: 90),
        child: Center(
          child: Column(
            children: [
              Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage('assets/UserPic.png'),
                        fit: BoxFit.cover)),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Harold',
                style: primaryText.copyWith(fontSize: 16, fontWeight: semiBold),
              ),
              SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Consultation',
                    style: primaryText.copyWith(
                        fontSize: 14, fontWeight: semiBold),
                  ),
                  Text(
                    'RP. 250.000',
                    style: primaryText.copyWith(
                        fontSize: 14, fontWeight: semiBold),
                  ),
                ],
              ),
              SizedBox(
                height: 70,
              ),
              Text(
                'Pembayaran Anda telah berhasil! \nSilahkan mulai konsultasi anda',
                style: primaryText.copyWith(fontSize: 16, fontWeight: semiBold),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      );
    }

    Widget consultationButton() {
      return GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Rating()));
        },
        child: Container(
          margin: EdgeInsets.only(top: 180, left: 30, right: 30, bottom: 20),
          width: MediaQuery.of(context).size.width - 60,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: buttonHijau),
          child: Center(
            child: Text(
              'Mulai Konsultasi',
              style: whiteText.copyWith(fontSize: 18, fontWeight: semiBold),
            ),
          ),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [linear1, white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [photoProfile(), consultationButton()],
          ),
        ),
      ),
    );
  }
}
