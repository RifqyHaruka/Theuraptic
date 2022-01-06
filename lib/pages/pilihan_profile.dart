import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:haldac/pages/imagePicker.dart';
import 'package:haldac/pages/profileDoctor..dart';
import 'package:haldac/pages/profile_doctor.dart';
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
      SharedPreferences pref = await SharedPreferences.getInstance();

      if (await authProvider.logout(pref.getString('token') as String)) {
        SharedPreferences pref = await SharedPreferences.getInstance();

        await pref.clear();

        Navigator.pushNamedAndRemoveUntil(
            context, '/pilihanLogin', (route) => false);
      }
    }

    Widget header() {
      return Container(
        margin: EdgeInsets.only(top: 30, left: 20, bottom: 24),
        child: Row(
          children: [
            (authProvider.roles == 'USER')
                ? CachedNetworkImage(
                    imageBuilder: (context, imageProvider) {
                      return Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover)));
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
                    fit: BoxFit.contain)
                : Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage('assets/UserPic.png'),
                            fit: BoxFit.cover))),
            SizedBox(
              width: 12,
            ),
            Text(
              (authProvider.roles == 'USER')
                  ? 'Halo ${authProvider.user.name}'
                  : 'Halo ${authProvider.dokter.name}',
              style: whiteText.copyWith(fontSize: 16, fontWeight: semiBold),
            ),
          ],
        ),
      );
    }

    Widget bantuan() {
      return GestureDetector(
        onTap: () {
          print(authProvider.roles);
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
                    'Bantuan',
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

    Widget ubahProfile() {
      return GestureDetector(
        onTap: () async {
          (authProvider.roles == 'USER')
              ? Navigator.pushNamed(context, '/profile')
              : Navigator.push(context,
                  MaterialPageRoute(builder: (context) => UbahProfileDoctor()));
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
