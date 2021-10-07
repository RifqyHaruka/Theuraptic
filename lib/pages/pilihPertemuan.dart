import 'package:flutter/material.dart';
import 'package:haldac/model/dokter_model.dart';
import 'package:haldac/pages/webView.dart';
import 'package:haldac/provider/appointment_provider.dart';
import 'package:haldac/provider/auth_provider.dart';
import 'package:haldac/provider/category_provider.dart';
import 'package:haldac/provider/dokter_provider.dart';
import 'package:haldac/theme.dart';
import 'package:provider/provider.dart';

class JumlahPertemuan extends StatefulWidget {
  final int price;
  final int doctorId;
  JumlahPertemuan(this.price, this.doctorId);
  TextEditingController text1 = TextEditingController(text: '1');

  @override
  State<JumlahPertemuan> createState() => _JumlahPertemuanState();
}

class _JumlahPertemuanState extends State<JumlahPertemuan> {
  @override
  Widget build(BuildContext context) {
    AppointmentProvider appointmentProvider =
        Provider.of<AppointmentProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    handleMidtrans() async {
      if (await appointmentProvider.getAppointment(
          authProvider.user.id,
          widget.doctorId,
          num.parse(appointmentProvider.getNilai) as int,
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

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(left: 10),
                height: 50,
                width: 500,
                decoration: BoxDecoration(border: Border.all(color: primary)),
                child: Center(
                  child: TextFormField(
                    onChanged: (value) {
                      if (value == '') {
                        value = '0';
                      } else {
                        value = (widget.price * num.parse(value)).toString();
                      }

                      print("Ini Value dari parameter : " + value);
                      appointmentProvider.setNilai = value;
                      print(value);
                    },
                    keyboardType: TextInputType.number,
                    controller: widget.text1,
                    decoration: InputDecoration.collapsed(
                        hintText: ('Masukan Jumlah Pertemuan (Min 1 Pertemuan)')
                            .toString()),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.only(left: 10),
                height: 50,
                width: 500,
                decoration:
                    BoxDecoration(border: Border.all(color: hijauBlock)),
                child: Center(
                    child: Text((appointmentProvider.getNilai == '1')
                        ? widget.price.toString()
                        : appointmentProvider.getNilai)
                    // (num.parse(appointmentProvider.getNilai) * widget.price)
                    //     .toString()
                    // child: TextFormField(
                    //   keyboardType: TextInputType.number,
                    //   controller: text,
                    //   decoration: InputDecoration.collapsed(hintText: ''),
                    // ),
                    ),
              ),
              SizedBox(
                height: 10,
              ),
              (appointmentProvider.getNilai == '0')
                  ? Container()
                  : GestureDetector(
                      onTap: () {
                        handleMidtrans();
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
    );
  }
}
