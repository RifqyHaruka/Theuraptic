import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haldac/pages/homeTherapis.dart';
import 'package:haldac/pages/loginTerapis.dart';
import 'package:haldac/pages/mainTherapis.dart';
import 'package:haldac/pages/uploadFotoTerapis.dart';
import 'package:haldac/provider/auth_provider.dart';
import 'package:haldac/theme.dart';
import 'package:haldac/widget/loading.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterTerapis extends StatefulWidget {
  const RegisterTerapis({Key? key}) : super(key: key);

  @override
  _RegisterTerapisState createState() => _RegisterTerapisState();
}

class _RegisterTerapisState extends State<RegisterTerapis> {
  bool isLoading = false;
  TextEditingController nameController = TextEditingController(text: '');
  TextEditingController usernameController = TextEditingController(text: '');
  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');
  TextEditingController phoneController = TextEditingController(text: '');
  TextEditingController licenseController = TextEditingController(text: '');
  TextEditingController ktaController = TextEditingController(text: '');
  TextEditingController sertifikatController = TextEditingController(text: '');
  TextEditingController exprieceController = TextEditingController(text: '');
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    handleRegisterTerapis() async {
      if (await authProvider.registerDokter(
          nameController.text,
          usernameController.text,
          emailController.text,
          passwordController.text,
          phoneController.text,
          licenseController.text,
          ktaController.text,
          sertifikatController.text,
          exprieceController.text)) {
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString('token', authProvider.dokter.token as String);
        pref.setString('roles', 'TERAPIS');
        pref.remove('veriv');
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => UploadFotoTerapis()));
      } else {
        SharedPreferences pref = await SharedPreferences.getInstance();
        var veriv = pref.getString('veriv');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: buttonMerah,
            content: Text(
              veriv.toString(),
              textAlign: TextAlign.center,
            )));
      }
    }

    Widget header() {
      return Container(
        margin: EdgeInsets.only(top: 50, left: 45),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Daftar Akun Terapis',
              style: primaryText.copyWith(fontSize: 18, fontWeight: semiBold),
            ),
            SizedBox(
              height: 10,
            ),
            Text('Daftar dan nikmati kemudahanya',
                style: primaryText.copyWith(fontSize: 14, fontWeight: regular))
          ],
        ),
      );
    }

    Widget namaInput() {
      return Container(
        margin: EdgeInsets.only(top: 30, left: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width - 60,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: white),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 14, bottom: 14, left: 10),
                      child: TextFormField(
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(RegExp('[0-9]'))
                        ],
                        controller: nameController,
                        decoration: InputDecoration.collapsed(
                            hintText: 'Masukan Nama',
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

    Widget phoneInput() {
      return Container(
        margin: EdgeInsets.only(top: 20, left: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width - 60,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: white),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 14, bottom: 14, left: 10),
                      child: TextFormField(
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                        ],
                        controller: phoneController,
                        decoration: InputDecoration.collapsed(
                            hintText: 'Masukan Nomor Telefon',
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
        margin: EdgeInsets.only(top: 20, left: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width - 60,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: white),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 14, bottom: 14, left: 10),
                      child: TextFormField(
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(RegExp('[0-9]'))
                        ],
                        controller: usernameController,
                        decoration: InputDecoration.collapsed(
                            hintText: 'Masukan Username',
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
        margin: EdgeInsets.only(top: 20, left: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width - 60,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: white,
                  border: Border.all(
                      color: (EmailValidator.validate(emailController.text))
                          ? white
                          : Colors.red)),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 14, bottom: 14, left: 10),
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {});
                        },
                        controller: emailController,
                        decoration: InputDecoration.collapsed(
                            hintText: 'Masukan Email',
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

    Widget exprienceInput() {
      return Container(
        margin: EdgeInsets.only(top: 20, left: 30, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width - 60,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: white),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 14, bottom: 14, left: 10),
                      child: TextFormField(
                        controller: exprieceController,
                        decoration: InputDecoration.collapsed(
                            hintText: 'Masukan Exprience',
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
        margin: EdgeInsets.only(top: 20, left: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width - 60,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: white),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 14, bottom: 14, left: 10),
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration.collapsed(
                            hintText: 'Masukan Password',
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

    Widget signUpButton() {
      return GestureDetector(
        onTap: () {
          handleRegisterTerapis();
        },
        child: Container(
          margin: EdgeInsets.only(top: 80, left: 30, right: 30),
          width: MediaQuery.of(context).size.width - 60,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: buttonHijau),
          child: Center(
            child: Text(
              'Daftar',
              style: whiteText.copyWith(fontSize: 18, fontWeight: semiBold),
            ),
          ),
        ),
      );
    }

    Widget licenseNumber() {
      return Container(
        margin: EdgeInsets.only(top: 20, left: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width - 60,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: white),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 14, bottom: 14, left: 10),
                      child: TextFormField(
                        controller: licenseController,
                        decoration: InputDecoration.collapsed(
                            hintText: 'Masukan Nomor Lisensi',
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

    Widget ktaNumber() {
      return Container(
        margin: EdgeInsets.only(top: 20, left: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width - 60,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: white),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 14, bottom: 14, left: 10),
                      child: TextFormField(
                        controller: ktaController,
                        decoration: InputDecoration.collapsed(
                            hintText: 'Masukan Nomor KTA',
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

    Widget certificatNumber() {
      return Container(
        margin: EdgeInsets.only(
          top: 20,
          left: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width - 60,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: white),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 14, bottom: 14, left: 10),
                      child: TextFormField(
                        controller: sertifikatController,
                        decoration: InputDecoration.collapsed(
                            hintText: 'Masukan Nomor Sertifikat',
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

    Widget footer() {
      return Container(
        margin: EdgeInsets.only(top: 15, left: 30, right: 30, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Sudah Punya Akun? ',
              style: primaryText.copyWith(fontSize: 14, fontWeight: regular),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginTerapis()));
              },
              child: Text(
                'Login ',
                style: GoogleFonts.poppins(
                    color: buttonHijau, fontSize: 14, fontWeight: regular),
              ),
            ),
            Text(
              'disini',
              style: primaryText.copyWith(fontSize: 14, fontWeight: regular),
            ),
          ],
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(color: hijauBlock),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    header(),
                    namaInput(),
                    usernameInput(),
                    emailInput(),
                    passwordInput(),
                    phoneInput(),
                    licenseNumber(),
                    ktaNumber(),
                    certificatNumber(),
                    exprienceInput()
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                color: white,
                child: Column(
                  children: [
                    (isLoading == true)
                        ? Loading(
                            margin: 80,
                          )
                        : signUpButton(),
                    footer()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
