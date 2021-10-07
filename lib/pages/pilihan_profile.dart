import 'package:flutter/material.dart';
import 'package:haldac/provider/auth_provider.dart';
import 'package:haldac/theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PilihanProfile extends StatelessWidget {
  const PilihanProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    logOutHandler() async {
      if (await authProvider.logout(authProvider.user.token as String)) {
        SharedPreferences pref = await SharedPreferences.getInstance();
        await pref.clear();

        Navigator.pushNamedAndRemoveUntil(context, '/daftar', (route) => false);
      }
    }

    Widget header() {
      return Container(
        margin: EdgeInsets.only(top: 30, left: 20, bottom: 24),
        child: Row(
          children: [
            Container(
              width: 75,
              height: 75,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage('assets/UserPic.png'),
                      fit: BoxFit.cover)),
            ),
            SizedBox(
              width: 12,
            ),
            Text(
              'Halo ' + (authProvider.user.name).toString(),
              style: whiteText.copyWith(fontSize: 16, fontWeight: semiBold),
            ),
          ],
        ),
      );
    }

    Widget bantuan() {
      return Container(
        margin: EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Container(
          width: MediaQuery.of(context).size.width - 40,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: buttonHijau),
          child: Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Bantuan',
                  style: whiteText.copyWith(fontSize: 14, fontWeight: semiBold),
                ),
                Icon(
                  Icons.arrow_right,
                  color: white,
                )
              ],
            ),
          ),
        ),
      );
    }

    Widget ubahProfile() {
      return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/profile');
        },
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Container(
            width: MediaQuery.of(context).size.width - 40,
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5), color: buttonHijau),
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Ubah Profile',
                    style:
                        whiteText.copyWith(fontSize: 14, fontWeight: semiBold),
                  ),
                  Icon(
                    Icons.arrow_right,
                    color: white,
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }

    Widget logOut() {
      return GestureDetector(
        onTap: logOutHandler,
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Container(
            width: MediaQuery.of(context).size.width - 40,
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5), color: buttonHijau),
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Log Out',
                    style:
                        whiteText.copyWith(fontSize: 14, fontWeight: semiBold),
                  ),
                  Icon(
                    Icons.arrow_right,
                    color: white,
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            decoration: BoxDecoration(color: hijauBlock), child: header()),
        bantuan(),
        ubahProfile(),
        logOut()
      ],
    );
  }
}
