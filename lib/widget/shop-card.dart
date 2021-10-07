import 'package:flutter/material.dart';
import 'package:haldac/theme.dart';

class ShopCard extends StatelessWidget {
  const ShopCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 60),
          width: 163,
          height: 255,
          decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Colors.black, width: 0.5)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: 14,
                  left: 12,
                  right: 12,
                ),
                width: 139,
                height: 169,
                decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: AssetImage(
                          'assets/product1.png',
                        ),
                        fit: BoxFit.contain)),
              ),
              Text('Rp. 500.000',
                  style:
                      primaryText.copyWith(fontSize: 12, fontWeight: medium)),
              SizedBox(height: 4),
              Text(
                'Cerebral palsy \nwalker for kids',
                style: primaryText.copyWith(fontSize: 12, fontWeight: medium),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 60),
          width: 160,
          height: 255,
          decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Colors.black, width: 0.5)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: 14,
                  left: 12,
                  right: 12,
                ),
                width: 139,
                height: 169,
                decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: AssetImage(
                          'assets/product2.png',
                        ),
                        fit: BoxFit.contain)),
              ),
              Text('Rp. 100.000',
                  style:
                      primaryText.copyWith(fontSize: 12, fontWeight: medium)),
              SizedBox(height: 4),
              Text(
                'Sorting Box',
                style: primaryText.copyWith(fontSize: 12, fontWeight: medium),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        )
      ],
    );
  }
}
