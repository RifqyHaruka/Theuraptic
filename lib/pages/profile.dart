import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:haldac/pages/imagePicker.dart';
import 'package:haldac/provider/auth_provider.dart';
import 'package:haldac/theme.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

TextEditingController nameInput = TextEditingController(text: '');
TextEditingController usernamaInput = TextEditingController(text: '');
TextEditingController email = TextEditingController(text: '');
TextEditingController phone = TextEditingController(text: '');
bool isLoading = false;

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    editHandlerButton() async {
      setState(() {
        isLoading = true;
      });

      if (await authProvider.edit(
          name:
              (nameInput.text == '') ? authProvider.user.name : nameInput.text,
          username: (usernamaInput.text == '')
              ? authProvider.user.username
              : usernamaInput.text,
          email: (email.text == '') ? authProvider.user.email : email.text,
          phoneNumber:
              (phone.text == '') ? authProvider.user.phoneNumber : phone.text,
          token: authProvider.user.token)) {
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          'Gagal Edit Data',
          textAlign: TextAlign.center,
        )));
      }

      setState(() {
        isLoading = false;
      });
    }

    Widget photoProfile() {
      return Container(
        margin: EdgeInsets.only(top: 90, left: 108, right: 107, bottom: 15),
        child: Column(
          children: [
            CachedNetworkImage(
                imageBuilder: (context, imageProvider) {
                  return Stack(alignment: Alignment.bottomRight, children: [
                    Container(
                        height: 160,
                        width: 160,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover))),
                    Positioned(
                      bottom: 15,
                      right: 5,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              (MaterialPageRoute(
                                  builder: (context) => GetImage())));
                        },
                        child: Image.asset(
                          'assets/change.png',
                          width: 30,
                          height: 30,
                          color: primary,
                        ),
                      ),
                    )
                  ]);
                },
                imageUrl: (authProvider.user.photoUrl != null)
                    ? authProvider.user.photoUrl as String
                    : authProvider.user.profilePhotoUrl as String,
                // progressIndicatorBuilder:
                //     (context, url, downloadProgress) =>
                //         CircularProgressIndicator(
                //             value: downloadProgress.progress),
                errorWidget: (context, url, error) => Icon(Icons.error),
                placeholder: (context, url) => CircularProgressIndicator(),
                fit: BoxFit.contain),
            SizedBox(
              height: 24,
            ),
            Text(
              authProvider.user.name as String,
              style: whiteText.copyWith(fontSize: 16, fontWeight: semiBold),
            ),
          ],
        ),
      );
    }

    Widget namaInput() {
      return Container(
        margin: EdgeInsets.only(top: 45, left: 30, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width - 60,
              height: 50,
              decoration: BoxDecoration(
                  border: Border.all(width: 1),
                  borderRadius: BorderRadius.circular(20),
                  color: white),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 14, bottom: 14, left: 10),
                      child: TextFormField(
                        controller: nameInput,
                        decoration: InputDecoration.collapsed(
                            hintText: authProvider.user.name,
                            hintStyle: secondaryText.copyWith(
                                fontSize: 14, fontWeight: regular)),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }

    Widget usernameInput() {
      return Container(
        margin: EdgeInsets.only(top: 20, left: 30, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width - 60,
              height: 50,
              decoration: BoxDecoration(
                  border: Border.all(width: 1),
                  borderRadius: BorderRadius.circular(20),
                  color: white),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 14, bottom: 14, left: 10),
                      child: TextFormField(
                        controller: usernamaInput,
                        decoration: InputDecoration.collapsed(
                            hintText: authProvider.user.username,
                            hintStyle: secondaryText.copyWith(
                                fontSize: 14, fontWeight: regular)),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }

    Widget emailInput() {
      return Container(
        margin: EdgeInsets.only(top: 20, left: 30, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width - 60,
              height: 50,
              decoration: BoxDecoration(
                  border: Border.all(width: 1),
                  borderRadius: BorderRadius.circular(20),
                  color: white),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 14, bottom: 14, left: 10),
                      child: TextFormField(
                        controller: email,
                        decoration: InputDecoration.collapsed(
                            hintText: authProvider.user.email,
                            hintStyle: blackText.copyWith(
                                fontSize: 14, fontWeight: regular)),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }

    Widget phoneInput() {
      return Container(
        margin: EdgeInsets.only(top: 20, left: 30, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width - 60,
              height: 50,
              decoration: BoxDecoration(
                  border: Border.all(width: 1),
                  borderRadius: BorderRadius.circular(20),
                  color: white),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 14, bottom: 14, left: 10),
                      child: TextFormField(
                        controller: phone,
                        decoration: InputDecoration.collapsed(
                            hintText: authProvider.user.phoneNumber,
                            hintStyle: blackText.copyWith(
                                fontSize: 14, fontWeight: regular)),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }

    Widget ubahButton() {
      return GestureDetector(
        onTap: editHandlerButton,
        child: Container(
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.width - 300,
            left: 30,
            right: 30,
          ),
          width: MediaQuery.of(context).size.width - 60,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12), color: buttonMerah),
          child: Center(
            child: Text(
              'Ubah Profile',
              style: whiteText.copyWith(fontSize: 18, fontWeight: semiBold),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                width: double.infinity,
                color: hijauBlock,
                child: photoProfile()),
            namaInput(),
            usernameInput(),
            emailInput(),
            phoneInput(),
            ubahButton()
          ],
        ),
      ),
    );
  }
}
