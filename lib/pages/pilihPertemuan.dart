import 'package:flutter/material.dart';
import 'package:haldac/model/category_model.dart';
import 'package:haldac/model/dokter_model.dart';
import 'package:haldac/pages/pilihTanggal.dart';
import 'package:haldac/pages/webView.dart';
import 'package:haldac/provider/appointment_provider.dart';
import 'package:haldac/provider/auth_provider.dart';
import 'package:haldac/provider/category_provider.dart';
import 'package:haldac/provider/dokter_provider.dart';
import 'package:haldac/theme.dart';
import 'package:haldac/widget/datePicker.dart';
import 'package:haldac/widget/foto.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class JumlahPertemuan extends StatefulWidget {
  final DoctorModel dokter;
  JumlahPertemuan(this.dokter);
  TextEditingController text1 = TextEditingController(text: '');

  @override
  State<JumlahPertemuan> createState() => _JumlahPertemuanState();
}

class _JumlahPertemuanState extends State<JumlahPertemuan> {
  int isZero = 0;
  @override
  Widget build(BuildContext context) {
    AppointmentProvider appointmentProvider =
        Provider.of<AppointmentProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    chatWhatsapp() async {
      final link = WhatsAppUnilink(
          phoneNumber: '+62(${widget.dokter.phone})',
          text: 'Halo ini dikirim dari aplikasi');

      await launch('$link');
    }

    handleMidtrans() async {
      if (await appointmentProvider.getAppointment(
          authProvider.user.id,
          widget.dokter.id,
          appointmentProvider.getNilai,
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

    Widget tombolBack() {
      return Container(
        margin: EdgeInsets.only(top: 20, left: 10),
        child: Icon(
          Icons.arrow_back_rounded,
          size: 40,
          color: white,
        ),
      );
    }

    Widget header() {
      return Container(
          height: 387,
          width: double.infinity,
          color: hijauBlock,
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                          margin: EdgeInsets.only(top: 40, left: 10),
                          child: Icon(
                            Icons.arrow_back_rounded,
                            color: white,
                            size: 40,
                          )),
                    ),
                  ],
                ),
                Container(
                  child: FotoBesar(),
                ),
                SizedBox(
                  height: 14,
                ),
                Text(
                  '${widget.dokter.name}',
                  style: whiteText.copyWith(fontSize: 24, fontWeight: semiBold),
                ),
                Text(
                  '${NumberFormat.currency(locale: 'id').format(widget.dokter.price)}/Sesi',
                  style: whiteText.copyWith(fontSize: 18, fontWeight: regular),
                )
              ],
            ),
          ));
    }

    Widget content() {
      return Container(
        margin: EdgeInsets.only(),
        width: double.infinity,
        height: MediaQuery.of(context).size.height - 387,
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
                      'Detail Appointment Terapi',
                      style: blackText.copyWith(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Text(
                        'Chat Dokter untuk \nmenentukan jumlah sesi',
                        style: borderText.copyWith(
                            fontSize: 14, fontWeight: medium),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      width: 120,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12), color: wa),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: chatWhatsapp,
                            child: Container(
                              margin: EdgeInsets.only(left: 9),
                              child: Text(
                                'Chat Disini',
                                style: whiteText.copyWith(fontSize: 14),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 9,
                          ),
                          Image.asset(
                            'assets/WA.png',
                            width: 20,
                            height: 20,
                          )
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 18,
                ),
                Text(
                  'Jumlah Sesi Terapi',
                  style: borderText.copyWith(fontWeight: medium, fontSize: 12),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 30, right: 30),
                        height: 50,
                        width: MediaQuery.of(context).size.width - 60,
                        decoration: BoxDecoration(
                            border: Border.all(color: primary),
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                          child: TextFormField(
                            onChanged: (value) {
                              if (value == '') {
                                value = (widget.dokter.price).toString();
                                isZero = 0;
                              } else {
                                value =
                                    (widget.dokter.price! * num.parse(value))
                                        .toString();
                                isZero = 1;
                              }

                              print("Ini Value dari parameter : " + value);
                              appointmentProvider.setNilai = int.parse(value);
                              print(appointmentProvider.getNilai);
                              print(isZero);
                            },
                            keyboardType: TextInputType.number,
                            controller: widget.text1,
                            decoration: InputDecoration.collapsed(
                                hintText:
                                    ('Masukan Jumlah Pertemuan (Min 1 Pertemuan)')
                                        .toString()),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Container(
                          margin: EdgeInsets.only(right: 30),
                          child: Image.asset('assets/Line.png')),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Biaya',
                            style: borderText.copyWith(
                                fontWeight: medium, fontSize: 14),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 30),
                            child: Text(
                              (appointmentProvider.getNilai == 1)
                                  ? NumberFormat.currency(locale: 'id')
                                      .format(widget.dokter.price)
                                      .toString()
                                  : NumberFormat.currency(locale: 'id')
                                      .format(appointmentProvider.getNilai)
                                      .toString(),
                              style: borderText.copyWith(
                                  fontSize: 14, fontWeight: medium),
                            ),
                          )
                        ],
                      ),

                      // child: Text((appointmentProvider.getNilai == '')
                      //     ? widget.dokter.price.toString()
                      //     : appointmentProvider.getNilai.toString())
                      // (num.parse(appointmentProvider.getNilai) * widget.price)
                      //     .toString()
                      // child: TextFormField(
                      //   keyboardType: TextInputType.number,
                      //   controller: text,
                      //   decoration: InputDecoration.collapsed(hintText: ''),
                      // ),

                      (isZero == 0)
                          ? Container()
                          : GestureDetector(
                              onTap: () {
                                // handleMidtrans();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PilihTanggal(
                                            widget.dokter,
                                            int.parse(widget.text1.text))));
                              },
                              child: Container(
                                height: 55,
                                margin: EdgeInsets.only(bottom: 10, top: 30),
                                width: MediaQuery.of(context).size.width - 60,
                                decoration: BoxDecoration(
                                    color: buttonHijau,
                                    borderRadius: BorderRadius.circular(12)),
                                child: Center(
                                  child: Text(
                                    'Atur Tanggal',
                                    style: whiteText.copyWith(
                                        fontSize: 18, fontWeight: semiBold),
                                  ),
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Container(
      child: Scaffold(
        backgroundColor: hijauBlock,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [header(), content()],
          ),
        )),
      ),
    );
  }
}
