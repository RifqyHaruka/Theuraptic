import 'package:flutter/material.dart';
import 'package:haldac/model/category_model.dart';
import 'package:haldac/model/dokter_model.dart';
import 'package:haldac/pages/webView.dart';
import 'package:haldac/provider/appointment_provider.dart';
import 'package:haldac/provider/auth_provider.dart';
import 'package:haldac/provider/category_provider.dart';
import 'package:haldac/provider/dokter_provider.dart';
import 'package:haldac/theme.dart';
import 'package:haldac/widget/foto.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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

    Widget header() {
      return Container(
          height: 387,
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
                  '${widget.dokter.name}',
                  style: whiteText.copyWith(fontSize: 24, fontWeight: semiBold),
                ),
                Text(
                  'Rp. ${widget.dokter.price}/Sesi',
                  style: whiteText.copyWith(fontSize: 18, fontWeight: regular),
                )
              ],
            ),
          ));
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
      return Container(
        margin: EdgeInsets.only(),
        width: double.infinity,
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
                  height: 18,
                ),
                Text(
                  'Jumlah Sesi Terapi',
                  style: borderText.copyWith(fontWeight: medium, fontSize: 12),
                ),
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
                          value = (widget.dokter.price! * num.parse(value))
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
                  height: 20,
                ),
                Text(
                  'Total Biaya',
                  style: borderText.copyWith(fontWeight: medium, fontSize: 12),
                ),
                Container(
                  padding: EdgeInsets.only(left: 30, right: 30),
                  height: 50,
                  width: MediaQuery.of(context).size.width - 60,
                  decoration: BoxDecoration(
                      border: Border.all(color: hijauBlock),
                      borderRadius: BorderRadius.circular(8)),
                  child: Center(
                    child: Text((appointmentProvider.getNilai == 1)
                        ? NumberFormat.currency(locale: 'id')
                            .format(widget.dokter.price)
                            .toString()
                        : NumberFormat.currency(locale: 'id')
                            .format(appointmentProvider.getNilai)
                            .toString()),
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
                  ),
                ),
                (isZero == 0)
                    ? Container()
                    : GestureDetector(
                        onTap: () {
                          handleMidtrans();
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
                              'Bayar',
                              style: whiteText.copyWith(
                                  fontSize: 18, fontWeight: semiBold),
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: putihButek,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [header(), content()],
        ),
      )
          // child: Center(
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Container(
          //         padding: EdgeInsets.only(left: 10),
          //         height: 50,
          //         width: 500,
          //         decoration: BoxDecoration(border: Border.all(color: primary)),
          //         child: Center(
          //           child: TextFormField(
          //             onChanged: (value) {
          //               if (value == '') {
          //                 value = '0';
          //               } else {
          //                 value = (widget.price * num.parse(value)).toString();
          //               }

          //               print("Ini Value dari parameter : " + value);
          //               appointmentProvider.setNilai = value;
          //               print(value);
          //             },
          //             keyboardType: TextInputType.number,
          //             controller: widget.text1,
          //             decoration: InputDecoration.collapsed(
          //                 hintText: ('Masukan Jumlah Pertemuan (Min 1 Pertemuan)')
          //                     .toString()),
          //           ),
          //         ),
          //       ),
          //       SizedBox(
          //         height: 10,
          //       ),
          //       Container(
          //         padding: EdgeInsets.only(left: 10),
          //         height: 50,
          //         width: 500,
          //         decoration:
          //             BoxDecoration(border: Border.all(color: hijauBlock)),
          //         child: Center(
          //             child: Text((appointmentProvider.getNilai == '1')
          //                 ? widget.price.toString()
          //                 : appointmentProvider.getNilai)
          //             // (num.parse(appointmentProvider.getNilai) * widget.price)
          //             //     .toString()
          //             // child: TextFormField(
          //             //   keyboardType: TextInputType.number,
          //             //   controller: text,
          //             //   decoration: InputDecoration.collapsed(hintText: ''),
          //             // ),
          //             ),
          //       ),
          //       SizedBox(
          //         height: 10,
          //       ),
          //       (appointmentProvider.getNilai == '0')
          //           ? Container()
          //           : GestureDetector(
          //               onTap: () {
          //                 handleMidtrans();
          //               },
          //               child: Container(
          //                 height: 55,
          //                 margin: EdgeInsets.only(bottom: 30),
          //                 width: MediaQuery.of(context).size.width - 60,
          //                 decoration: BoxDecoration(
          //                     color: buttonHijau,
          //                     borderRadius: BorderRadius.circular(12)),
          //                 child: Center(
          //                   child: Text(
          //                     'Bayar dan Buat Janji',
          //                     style: whiteText.copyWith(
          //                         fontSize: 18, fontWeight: semiBold),
          //                   ),
          //                 ),
          //               ),
          //             )
          //     ],
          //   ),
          ),
    );
  }
}
