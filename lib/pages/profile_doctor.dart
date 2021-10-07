import 'package:flutter/material.dart';
import 'package:haldac/model/category_model.dart';
import 'package:haldac/model/dokter_model.dart';
import 'package:haldac/pages/midtrans_pages.dart';
import 'package:haldac/pages/pilihPertemuan.dart';
import 'package:haldac/pages/webView.dart';
import 'package:haldac/provider/appointment_provider.dart';
import 'package:haldac/provider/auth_provider.dart';
import 'package:haldac/theme.dart';
import 'package:haldac/widget/foto.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class ProfileDoctor extends StatefulWidget {
  final DoctorModel? dokter;

  const ProfileDoctor({this.dokter});

  @override
  _ProfileDoctorState createState() => _ProfileDoctorState();
}

class _ProfileDoctorState extends State<ProfileDoctor> {
  TextEditingController text1 = TextEditingController(text: '1');

  @override
  Widget build(BuildContext context) {
    chatWhatsapp() async {
      final link = WhatsAppUnilink(
          phoneNumber: '+62(${widget.dokter!.phone})',
          text: 'Halo ini dikirim dari aplikasi');

      await launch('$link');
    }

    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    AppointmentProvider appointmentProvider =
        Provider.of<AppointmentProvider>(context);

    handleMidtrans() async {
      if (await appointmentProvider.getAppointment(
          authProvider.user.id,
          widget.dokter!.id,
          widget.dokter!.price,
          authProvider.user.name,
          authProvider.user.email,
          authProvider.user.token as String)) {
        print(appointmentProvider.appointment.url);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    WebViewe(appointmentProvider.appointment.url)));
      }
    }

    // Widget photoProfile() {
    //   return Container(
    //     margin: EdgeInsets.only(top: 90, left: 108, right: 107, bottom: 15),
    //     child: Column(
    //       children: [
    //         Container(
    //           width: 160,
    //           height: 160,
    //           decoration: BoxDecoration(
    //               shape: BoxShape.circle,
    //               image: DecorationImage(
    //                   image: AssetImage('assets/UserPic.png'),
    //                   fit: BoxFit.cover)),
    //         ),
    //         SizedBox(
    //           height: 10,
    //         ),
    //         Text(
    //           dokter!.name as String,
    //           style: whiteText.copyWith(fontSize: 16, fontWeight: semiBold),
    //           textAlign: TextAlign.center,
    //         ),
    //         Text(
    //           'Rp' + (dokter!.price).toString(),
    //           style: whiteText.copyWith(fontSize: 16, fontWeight: semiBold),
    //           textAlign: TextAlign.center,
    //         ),
    //       ],
    //     ),
    //   );
    // }

    // Widget doctorProfile() {
    //   return Container(
    //     margin: EdgeInsets.only(top: 30, left: 30, right: 30),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Text(
    //           'Therapist Profile',
    //           style: primaryText.copyWith(fontWeight: semiBold, fontSize: 16),
    //         ),
    //         SizedBox(
    //           height: 20,
    //         ),
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             Text(
    //               'Lulusan  ',
    //               style:
    //                   secondaryText.copyWith(fontSize: 14, fontWeight: regular),
    //             ),
    //             Text(
    //               dokter!.experince as String,
    //               style:
    //                   secondaryText.copyWith(fontSize: 14, fontWeight: regular),
    //             ),
    //           ],
    //         ),
    //         SizedBox(
    //           height: 20,
    //         ),
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             Text(
    //               'Spesialis ',
    //               style:
    //                   secondaryText.copyWith(fontSize: 14, fontWeight: regular),
    //             ),
    //             Text(
    //               dokter!.slug as String,
    //               style:
    //                   secondaryText.copyWith(fontSize: 14, fontWeight: regular),
    //             ),
    //           ],
    //         ),
    //         SizedBox(
    //           height: 20,
    //         ),
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             Text(
    //               'Nomor STR Dokter ',
    //               style:
    //                   secondaryText.copyWith(fontSize: 14, fontWeight: regular),
    //             ),
    //             Text(
    //               '12345678  ',
    //               style:
    //                   secondaryText.copyWith(fontSize: 14, fontWeight: regular),
    //             ),
    //           ],
    //         )
    //       ],
    //     ),
    //   );
    // }

    // Widget consultButton() {
    //   return GestureDetector(
    //     onTap: () {
    //       Navigator.push(
    //           context, MaterialPageRoute(builder: (context) => MidtransPage()));
    //     },
    //     child: Container(
    //       margin: EdgeInsets.only(top: 100, left: 30, right: 30, bottom: 20),
    //       width: MediaQuery.of(context).size.width - 60,
    //       height: 50,
    //       decoration: BoxDecoration(
    //           borderRadius: BorderRadius.circular(5), color: buttonMerah),
    //       child: Center(
    //         child: Text(
    //           'Bayar',
    //           style: whiteText.copyWith(fontSize: 18, fontWeight: semiBold),
    //         ),
    //       ),
    //     ),
    //   );
    // }

    // return Scaffold(
    //   backgroundColor: Colors.white,
    //   body: SingleChildScrollView(
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Container(
    //           width: double.infinity,
    //           decoration: BoxDecoration(color: hijauBlock),
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               photoProfile(),
    //             ],
    //           ),
    //         ),
    //         doctorProfile(),
    //         consultButton(),
    //       ],
    //     ),
    //   ),
    // );

    Widget header() {
      return Expanded(
          // fit: FlexFit.loose,

          child: Container(
              width: double.infinity,
              color: hijauBlock,
              child: Container(
                margin: EdgeInsets.only(top: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FotoBesar(),
                    SizedBox(
                      height: 14,
                    ),
                    Text(
                      '${widget.dokter!.name}',
                      style: whiteText.copyWith(
                          fontSize: 24, fontWeight: semiBold),
                    ),
                    Text(
                      'Rp. ${widget.dokter!.price}/Sesi',
                      style:
                          whiteText.copyWith(fontSize: 18, fontWeight: regular),
                    )
                  ],
                ),
              )));
    }

    Widget inputan(String? urlIcon, String? text) {
      return Container(
        width: MediaQuery.of(context).size.width - 60,
        decoration:
            BoxDecoration(border: Border(bottom: BorderSide(color: border))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text as String,
              style: borderText.copyWith(fontSize: 14, fontWeight: medium),
            ),
            Image.asset(
              urlIcon as String,
              width: 17,
              height: 17,
            )
          ],
        ),
      );
    }

    Widget content() {
      return Expanded(
          child: Container(
        margin: EdgeInsets.only(top: 20),
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            color: putihButek,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Container(
          margin: EdgeInsets.only(top: 30, left: 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/VectorProfile.png',
                      width: 24,
                      height: 24,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      'Profil Terapis',
                      style: blackText.copyWith(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
                SizedBox(
                  height: 18,
                ),
                Text(
                  'Lulusan',
                  style: borderText.copyWith(fontWeight: medium, fontSize: 12),
                ),
                SizedBox(
                  height: 5,
                ),
                inputan('assets/STR.png', '${widget.dokter!.experince}'),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Spesialis',
                  style: borderText.copyWith(fontWeight: medium, fontSize: 12),
                ),
                SizedBox(
                  height: 5,
                ),
                inputan('assets/STR.png', '${widget.dokter!.slug}'),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Nomor STR',
                  style: borderText.copyWith(fontWeight: medium, fontSize: 12),
                ),
                SizedBox(
                  height: 5,
                ),
                inputan('assets/STR.png', '${widget.dokter!.lisenceNumber}'),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 5,
                ),
                // Container(
                //   padding: EdgeInsets.only(left: 10),
                //   height: 50,
                //   width: 500,
                //   decoration: BoxDecoration(border: Border.all(color: primary)),
                //   child: Center(
                //     child: TextFormField(
                //       onChanged: (value) {
                //         value = (5 * num.parse(value)).toString();
                //         print("Ini Value dari parameter : " + value);
                //         appointmentProvider.setNilai = value;
                //       },
                //       keyboardType: TextInputType.number,
                //       controller: text1,
                //       decoration: InputDecoration.collapsed(
                //           hintText: ('Masukan Jumlah Pertemuan').toString()),
                //     ),
                //   ),
                // ),
                // SizedBox(
                //   height: 10,
                // ),
                // Container(
                //   padding: EdgeInsets.only(left: 10),
                //   height: 50,
                //   width: 500,
                //   decoration:
                //       BoxDecoration(border: Border.all(color: hijauBlock)),
                //   child: Center(child: Text(appointmentProvider.getNilai)
                //       // child: TextFormField(
                //       //   keyboardType: TextInputType.number,
                //       //   controller: text,
                //       //   decoration: InputDecoration.collapsed(hintText: ''),
                //       // ),
                //       ),
                // ),
                GestureDetector(
                  onTap: () {
                    chatWhatsapp();
                  },
                  child: Container(
                    height: 55,
                    margin: EdgeInsets.only(bottom: 10),
                    width: MediaQuery.of(context).size.width - 60,
                    decoration: BoxDecoration(
                        color: buttonHijau,
                        borderRadius: BorderRadius.circular(12)),
                    child: Center(
                      child: Text(
                        'Chat Whatsapp',
                        style: whiteText.copyWith(
                            fontSize: 18, fontWeight: semiBold),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // handleMidtrans();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => JumlahPertemuan(
                                widget.dokter!.price as int,
                                widget.dokter!.id as int)));
                  },
                  child: Container(
                    height: 55,
                    margin: EdgeInsets.only(bottom: 30),
                    width: MediaQuery.of(context).size.width - 60,
                    decoration: BoxDecoration(
                        color: buttonHijau,
                        borderRadius: BorderRadius.circular(12)),
                    child: Center(
                      child: Text(
                        'Bayar dan Buat Janji',
                        style: whiteText.copyWith(
                            fontSize: 18, fontWeight: semiBold),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ));
    }

    return SafeArea(
        child: Scaffold(
      backgroundColor: hijauBlock,
      body: ConstrainedBox(
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [header(), content()],
        ),
      ),
    ));
  }
}
