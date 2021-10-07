import 'package:flutter/material.dart';
import 'package:haldac/theme.dart';
import 'package:haldac/widget/shop-card.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        margin: EdgeInsets.only(top: 30, left: 16),
        child: Text('Alat-alat Terapi',
            style: whiteText.copyWith(fontSize: 18, fontWeight: medium)),
      );
    }

    Widget searchBox() {
      return Container(
        margin: EdgeInsets.only(top: 40, left: 30, right: 30, bottom: 10),
        width: MediaQuery.of(context).size.width - 60,
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18), color: white),
        child: Container(
          margin: EdgeInsets.only(left: 10),
          child: Center(
            child: Row(
              children: [
                Image.asset(
                  'assets/searchIcon.png',
                  width: 18,
                  height: 18,
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration.collapsed(
                        hintText: 'Search Here',
                        hintStyle: secondaryText.copyWith(
                            fontSize: 12, fontWeight: medium)),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }

    Widget content() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          children: [
            ShopCard(),
            ShopCard(),
            ShopCard(),
            ShopCard(),
            ShopCard(),
            ShopCard()
          ],
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(color: hijauBlock),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    header(),
                    searchBox(),
                  ],
                ),
              ),
              content()
            ],
          ),
        ),
      ),
    );
  }
}
