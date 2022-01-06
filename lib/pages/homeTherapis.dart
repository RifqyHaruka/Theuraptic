import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:haldac/pages/lansia.dart';
import 'package:haldac/pages/pilihan_profile.dart';
import 'package:haldac/provider/auth_provider.dart';
import 'package:haldac/provider/historyAppointment_provider..dart';
import 'package:haldac/theme.dart';
import 'package:haldac/widget/history_card.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeTherapis extends StatefulWidget {
  const HomeTherapis({Key? key}) : super(key: key);

  @override
  _HomeTherapisState createState() => _HomeTherapisState();
}

class _HomeTherapisState extends State<HomeTherapis> {
  int currentIndex = 0;

  @override
  void initState() {
    getHistorybyDoctorId();

    super.initState();
  }

  getHistorybyDoctorId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.get('token');
    print(pref.get('token'));
    if (await Provider.of<HistoryAppointmentProvider>(context, listen: false)
            .getHistorybyDoctorId(
                token.toString(),
                Provider.of<AuthProvider>(context, listen: false).dokter.id
                    as int) ==
        true) {
      Provider.of<AuthProvider>(context, listen: false).roles = 'TERAPIS';
      print(Provider.of<AuthProvider>(context, listen: false).roles);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    HistoryAppointmentProvider historyAppointmentProvider =
        Provider.of<HistoryAppointmentProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    Widget header() {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: 90,
        decoration: BoxDecoration(color: hijauBlock),
        child: Row(
          children: [
            (authProvider.dokter.photo != null)
                ? CachedNetworkImage(
                    imageBuilder: (context, imageProvider) {
                      return Container(
                          margin: EdgeInsets.only(left: 20),
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover)));
                    },
                    imageUrl: authProvider.dokter.photo as String,
                    // progressIndicatorBuilder:
                    //     (context, url, downloadProgress) =>
                    //         CircularProgressIndicator(
                    //             value: downloadProgress.progress),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    placeholder: (context, url) => CircularProgressIndicator(),
                    fit: BoxFit.contain)
                : Container(
                    margin: EdgeInsets.only(left: 20),
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage('assets/UserPic.png'),
                            fit: BoxFit.cover))),
            SizedBox(width: 25),
            GestureDetector(
              onTap: () {
                print(authProvider.dokter.photo);
              },
              child: Text(
                'Halo ${authProvider.dokter.name}',
                style: whiteText.copyWith(fontSize: 18, fontWeight: medium),
              ),
            )
          ],
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: (authProvider.dokter.isVerified == 'TRUE')
              ? Column(children: [
                  header(),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Appointment List',
                    style:
                        borderText.copyWith(fontSize: 18, fontWeight: semiBold),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Column(
                      children: historyAppointmentProvider.history
                          .map((history) => HistoryCard(history))
                          .toList())
                ])
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    header(),
                    SizedBox(height: 100),
                    Image.asset(
                      'assets/doctor.png',
                      width: 200,
                      height: 200,
                    ),
                    SizedBox(height: 30),
                    Text(
                      'Mohon Tunggu Akun Anda Sedang direview Untuk diverifikasi',
                      style: borderText.copyWith(
                          fontSize: 18, fontWeight: semiBold),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
