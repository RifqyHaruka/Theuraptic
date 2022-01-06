import 'package:flutter/material.dart';
import 'package:haldac/model/category_model.dart';
import 'package:haldac/pages/webView.dart';
import 'package:haldac/provider/appointment_provider.dart';
import 'package:haldac/provider/auth_provider.dart';
import 'package:haldac/theme.dart';
import 'package:haldac/widget/loading.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Summary extends StatefulWidget {
  final DoctorModel dokter;
  final int jumlahPertemuan;
  final List date;
  final List sesi;
  final List sesiAkhir;
  final List hargaPerPertemuan;
  final int harga;

  Summary(this.dokter, this.jumlahPertemuan, this.date, this.sesiAkhir,
      this.sesi, this.harga, this.hargaPerPertemuan);

  @override
  State<Summary> createState() => _SummaryState();
}

class _SummaryState extends State<Summary> {
  bool isLoading = false;
  var dateFormat = DateFormat('hh:mm a');
  var dateFormatYear = DateFormat('dd-MM-yyyy hh:mm a');
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    AppointmentProvider appointmentProvider =
        Provider.of<AppointmentProvider>(context);

    handleMidtrans() async {
      setState(() {
        isLoading = true;
      });

      if (await appointmentProvider.getAppointment(
          authProvider.user.id,
          widget.dokter.id,
          widget.harga,
          authProvider.user.name,
          authProvider.user.email,
          authProvider.user.token as String)) {
        print(appointmentProvider.appointment.url);
        for (var i = 0; i < widget.jumlahPertemuan; i++) {
          if (await appointmentProvider.getAppointmentDetail(
              appointmentProvider.appointment.id,
              widget.dokter.id,
              widget.date[i].toString(),
              authProvider.user.token as String,
              widget.sesiAkhir[i].toString(),
              int.parse(widget.sesi[i]),
              widget.hargaPerPertemuan[i])) {
            print('Berhasil');
          }
        }
      }

      setState(() {
        isLoading = false;
      });
    }

    appointmentDetailHandler() async {}

    Widget header() {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: 90,
        decoration: BoxDecoration(color: hijauBlock),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.only(left: 30),
                child: Icon(
                  Icons.arrow_back_rounded,
                  color: white,
                  size: 40,
                ),
              ),
            ),
            SizedBox(width: 30),
            Text(
              'Summary \nAppointment Terapi',
              style: whiteText.copyWith(fontSize: 18, fontWeight: medium),
            )
          ],
        ),
      );
    }

    Widget inputan(String header, String data, String urlGambar) {
      return Container(
        margin: EdgeInsets.only(top: 7, left: 30, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              header,
              style: borderText.copyWith(fontSize: 12, fontWeight: medium),
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  data,
                  style: borderText.copyWith(fontSize: 14, fontWeight: medium),
                ),
                Image.asset(
                  urlGambar,
                  width: 20,
                  height: 20,
                )
              ],
            ),
            Divider(
              height: 20,
              color: border,
            )
          ],
        ),
      );
    }

    Widget content() {
      return Container(
        margin: EdgeInsets.only(top: 7),
        child: Column(
          children: [
            inputan('Nama Saya', authProvider.user.name.toString(),
                'assets/SumProfile.png'),
            inputan('Nama Terapis', widget.dokter.name.toString(),
                'assets/SumTherap.png'),
            inputan('Jumlah Terapi', widget.jumlahPertemuan.toString(),
                'assets/SumTot.png'),
            inputan(
                'Total Harga',
                NumberFormat.currency(locale: 'id')
                    .format(widget.harga)
                    .toString(),
                'assets/SumTotPrice.png'),
          ],
        ),
      );
    }

    Widget appointmentDate(int index) {
      return Container(
        margin: EdgeInsets.only(top: 24, left: 25, right: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Terapi ke-' + (index + 1).toString(),
              style: borderText.copyWith(fontSize: 14, fontWeight: medium),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width - 50,
              height: 40,
              decoration: BoxDecoration(
                  border: Border.all(color: border),
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      margin: EdgeInsets.only(left: 16),
                      child: Text(dateFormatYear.format(widget.date[index]) +
                          ' - ${dateFormat.format(widget.sesiAkhir[index])}')),
                  Container(
                    margin: EdgeInsets.only(right: 16),
                    child: Image.asset(
                      'assets/Calendar.png',
                      width: 20,
                      height: 20,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget button() {
      return GestureDetector(
        onTap: () async {
          await handleMidtrans();
          await appointmentDetailHandler();
          // for (var i = 0; i < widget.jumlahPertemuan; i++) {
          //   appointmentDetailHandler(widget.date[i]);
          // }
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      WebViewe(appointmentProvider.appointment.url)));
        },
        child: Container(
          margin: EdgeInsets.only(top: 20, left: 25, right: 25, bottom: 30),
          width: MediaQuery.of(context).size.width - 50,
          height: 55,
          decoration: BoxDecoration(
              color: hijauBlock, borderRadius: BorderRadius.circular(10)),
          child: Center(
              child: Text(
            'Buat Pembayaran',
            style: whiteText.copyWith(fontSize: 16, fontWeight: medium),
          )),
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            header(),
            content(),
            SizedBox(
              height: 20,
            ),
            Column(
                children: List.generate(
                    widget.jumlahPertemuan, (index) => appointmentDate(index))),
            (isLoading == true)
                ? Loading(
                    margin: 20,
                  )
                : button()
          ],
        ),
      )),
    );
  }
}
