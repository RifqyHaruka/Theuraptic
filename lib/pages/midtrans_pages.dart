import 'package:flutter/material.dart';
import 'package:haldac/pages/payment_success.dart';
import 'package:haldac/theme.dart';

class MidtransPage extends StatelessWidget {
  const MidtransPage({Key? key}) : super(key: key);

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
                height: 50,
              ),
              Text(
                'Bayar transaksi anda melalui Midtrans',
                style: primaryText.copyWith(fontSize: 16, fontWeight: semiBold),
              ),
              SizedBox(
                height: 100,
              ),
              Image.asset(
                'assets/midtrans.png',
                width: 242,
                height: 101,
              )
            ],
          ),
        ),
      );
    }

    Widget midtransButton() {
      return GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => PaymentSuccess()));
        },
        child: Container(
          margin: EdgeInsets.only(top: 20, left: 30, right: 30, bottom: 20),
          width: MediaQuery.of(context).size.width - 60,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: buttonHijau),
          child: Center(
            child: Text(
              'Bayar',
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
            children: [photoProfile(), midtransButton()],
          ),
        ),
      ),
    );
  }
}
