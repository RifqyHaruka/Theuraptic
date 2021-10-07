import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haldac/provider/auth_provider.dart';
import 'package:haldac/theme.dart';
import 'package:haldac/widget/loading.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController username = TextEditingController(text: '');
  TextEditingController password = TextEditingController(text: '');
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    handleSigninButton() async {
      setState(() {
        isLoading = true;
      });

      if (await authProvider.login(username.text, password.text)) {
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString('token', authProvider.user.token as String);
        // pref.setString('username', authProvider.user.username as String);
        // pref.setString('name', authProvider.user.name as String);
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: buttonMerah,
            content: Text(
              "Gagal Login, ada masalah",
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
              'Masuk Akun',
              style: primaryText.copyWith(fontSize: 18, fontWeight: semiBold),
            ),
            SizedBox(
              height: 10,
            ),
            Text('Masuk dan Mulai Konsultasi',
                style: primaryText.copyWith(fontSize: 14, fontWeight: regular))
          ],
        ),
      );
    }

    Widget usernameInput() {
      return Container(
        margin: EdgeInsets.only(top: 45, left: 30),
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
                        controller: username,
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
                        controller: password,
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

    Widget signInButton() {
      return GestureDetector(
        onTap: handleSigninButton,
        child: Container(
          margin: EdgeInsets.only(top: 250, left: 30, right: 30),
          width: MediaQuery.of(context).size.width - 60,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: buttonHijau),
          child: Center(
            child: Text(
              'Masuk',
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
              'Tidak punya akun? ',
              style: primaryText.copyWith(fontSize: 14, fontWeight: regular),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/sign-up');
              },
              child: Text(
                'Daftar ',
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
        resizeToAvoidBottomInset: true,
        backgroundColor: white,
        body: Scaffold(
          body: ListView(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 330,
                  color: hijauBlock,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      header(),
                      usernameInput(),
                      passwordInput(),
                      // signInButton(),
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
                              margin: 250,
                            )
                          : signInButton(),
                      footer()
                    ],
                  ),
                )
                // header(),
                // usernameInput(),
                // passwordInput(),
                // signInButton(),
                // footer()
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
