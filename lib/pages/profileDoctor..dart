import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:haldac/pages/mainTherapis.dart';
import 'package:haldac/pages/uploadFotoTerapis.dart';
import 'package:haldac/provider/auth_provider.dart';
import 'package:haldac/theme.dart';
import 'package:haldac/widget/loading.dart';
import 'package:provider/provider.dart';

class UbahProfileDoctor extends StatefulWidget {
  const UbahProfileDoctor({Key? key}) : super(key: key);

  @override
  _UbahProfileDoctorState createState() => _UbahProfileDoctorState();
}

bool isLoading = false;

class _UbahProfileDoctorState extends State<UbahProfileDoctor> {
  @override
  TextEditingController usernameInput = TextEditingController(text: '');

  TextEditingController email = TextEditingController(text: '');
  TextEditingController phone = TextEditingController(text: '');
  TextEditingController password = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    editHandlerButton() async {
      setState(() {
        isLoading = true;
      });

      if (await authProvider.editDokter(usernameInput.text, phone.text,
          email.text, password.text, authProvider.dokter.token)) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MainTherapis()));
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            (authProvider.dokter.photo != null)
                ? CachedNetworkImage(
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
                                      builder: (context) =>
                                          UploadFotoTerapis())));
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
                    imageUrl: authProvider.dokter.photo as String,

                    // progressIndicatorBuilder:
                    //     (context, url, downloadProgress) =>
                    //         CircularProgressIndicator(
                    //             value: downloadProgress.progress),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    placeholder: (context, url) => CircularProgressIndicator(),
                    fit: BoxFit.contain)
                : Stack(alignment: Alignment.bottomRight, children: [
                    Container(
                        height: 160,
                        width: 160,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage('assets/VectorProfile.png'),
                                fit: BoxFit.cover))),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            (MaterialPageRoute(
                                builder: (context) => UploadFotoTerapis())));
                      },
                      child: Positioned(
                        bottom: 15,
                        right: 5,
                        child: Image.asset(
                          'assets/change.png',
                          width: 30,
                          height: 30,
                          color: primary,
                        ),
                      ),
                    )
                  ]),
            SizedBox(
              height: 10,
            ),
            Text(
              authProvider.dokter.name as String,
              style: whiteText.copyWith(fontSize: 16, fontWeight: semiBold),
            ),
          ],
        ),
      );
    }

    Widget userNameInput() {
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
                        controller: usernameInput,
                        decoration: InputDecoration.collapsed(
                            hintText: 'Masukan Username Baru',
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

    // Widget usernameInput() {
    //   return Container(
    //     margin: EdgeInsets.only(top: 20, left: 30, right: 30),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Container(
    //           width: MediaQuery.of(context).size.width - 60,
    //           height: 50,
    //           decoration: BoxDecoration(
    //               border: Border.all(width: 1),
    //               borderRadius: BorderRadius.circular(20),
    //               color: white),
    //           child: Column(
    //             children: [
    //               Expanded(
    //                 child: Container(
    //                   margin: EdgeInsets.only(top: 14, bottom: 14, left: 10),
    //                   child: TextFormField(
    //                     controller: usernamaInput,
    //                     decoration: InputDecoration.collapsed(
    //                         hintText: authProvider.dokter.username,
    //                         hintStyle: secondaryText.copyWith(
    //                             fontSize: 14, fontWeight: regular)),
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         )
    //       ],
    //     ),
    //   );
    // }

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
                            hintText: 'Masukan Nomor Telfon Baru',
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
                            hintText: 'Masukan Email Baru',
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

    Widget passwordInput() {
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
                        controller: password,
                        decoration: InputDecoration.collapsed(
                            hintText: 'Masukan Password Baru',
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

    Widget ubahButton() {
      return GestureDetector(
        onTap: editHandlerButton,
        child: Container(
          margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.width - 300,
              left: 30,
              right: 30,
              bottom: 20),
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
            userNameInput(),
            phoneInput(),
            emailInput(),
            passwordInput(),
            (isLoading == true)
                ? Loading(
                    margin: MediaQuery.of(context).size.width - 300,
                  )
                : ubahButton(),
          ],
        ),
      ),
    );
  }
}
