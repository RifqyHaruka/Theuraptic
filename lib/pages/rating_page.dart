import 'package:flutter/material.dart';
import 'package:haldac/theme.dart';

class Rating extends StatefulWidget {
  @override
  _RatingState createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  int i = 1;

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
              Text(
                'Terima Kasih telah memilih layanan kami!',
                style: primaryText.copyWith(fontSize: 14, fontWeight: semiBold),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Hope you feeling well soon',
                style: primaryText.copyWith(fontSize: 14, fontWeight: semiBold),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      );
    }

    Widget bintang() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Center(
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/bintang.png',
                  width: 40,
                  height: 40,
                ),
                SizedBox(
                  width: 10,
                ),
                Image.asset(
                  'assets/bintang.png',
                  width: 40,
                  height: 40,
                ),
                SizedBox(
                  width: 10,
                ),
                Image.asset(
                  'assets/bintang.png',
                  width: 40,
                  height: 40,
                ),
                SizedBox(
                  width: 10,
                ),
                Image.asset(
                  'assets/bintang.png',
                  width: 40,
                  height: 40,
                ),
                SizedBox(
                  width: 10,
                ),
                Image.asset(
                  'assets/bintang.png',
                  width: 40,
                  height: 40,
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
        ),
      );
    }

    Widget reviewColumn() {
      return Container(
        margin: EdgeInsets.only(top: 20, left: 16, right: 16),
        child: Container(
          width: 343,
          height: 94,
          decoration: BoxDecoration(
              color: white, borderRadius: BorderRadius.circular(12)),
          child: TextFormField(
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration.collapsed(
                hintText: 'Add your review here',
                hintStyle:
                    secondaryText.copyWith(fontSize: 14, fontWeight: regular)),
          ),
        ),
      );
    }

    Widget ratingButton() {
      return GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Rating()));
        },
        child: Container(
          margin: EdgeInsets.only(top: 70, left: 30, right: 30, bottom: 20),
          width: MediaQuery.of(context).size.width - 60,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: buttonHijau),
          child: Center(
            child: Text(
              'Berikan ulasan',
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
            children: [
              photoProfile(),
              bintang(),
              reviewColumn(),
              ratingButton()
            ],
          ),
        ),
      ),
    );
  }
}
