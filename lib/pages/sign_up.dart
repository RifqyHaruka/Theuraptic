import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haldac/pages/home.dart';
import 'package:haldac/pages/imagePicker.dart';
import 'package:haldac/provider/auth_provider.dart';
import 'package:haldac/theme.dart';
import 'package:haldac/widget/loading.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isLoading = false;
  TextEditingController nameController = TextEditingController(text: '');
  TextEditingController usernameController = TextEditingController(text: '');
  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');
  TextEditingController phoneController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    handleSignUp() async {
      setState(() {
        isLoading = true;
      });

      if (await authProvider.register(
          nameController.text,
          usernameController.text,
          emailController.text,
          passwordController.text,
          phoneController.text)) {
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString('roles', 'USER');
        authProvider.roles = 'USER';
        pref.setString('token', authProvider.user.token as String);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => GetImage()),
            (route) => false);
      } else if (await authProvider.register(
              nameController.text,
              usernameController.text,
              emailController.text,
              passwordController.text,
              phoneController.text) ||
          passwordController.text.length < 8) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: buttonMerah,
            content: Text(
              "Gagal Register, Password Harus Memiliki Minimal 8 Karakter",
              textAlign: TextAlign.center,
            )));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: buttonMerah,
            content: Text(
              "Gagal Register, ada masalah",
              textAlign: TextAlign.center,
            )));
      }

      setState(() {
        isLoading = false;
      });
    }

    Widget header() {
      return Container(
        margin: EdgeInsets.only(top: 86, left: 45),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Daftar',
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
                  borderRadius: BorderRadius.circular(20), color: white),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 14, bottom: 14, left: 10),
                      child: TextFormField(
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
        onTap: handleSignUp,
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
                Navigator.pushNamed(context, '/sign-in');
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
