import 'package:flutter/material.dart';
import 'package:haldac/model/appointmet_detail_model.dart';
import 'package:haldac/model/historyAppointment_model.dart';
import 'package:haldac/pages/historyDetail.dart';
import 'package:haldac/provider/auth_provider.dart';
import 'package:haldac/provider/historyAppointment_provider..dart';
import 'package:haldac/theme.dart';
import 'package:haldac/widget/loading.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class StatusTerapi extends StatefulWidget {
  final List<AppointmentDetailModel>? appointment;

  final HistoryAppointmentModel? history;
  final String? date;
  final String? sesiAkhir;
  final int? id;
  StatusTerapi(
    this.appointment,
    this.id,
    this.history,
    this.date,
    this.sesiAkhir,
  );

  @override
  State<StatusTerapi> createState() => _StatusTerapiState();
}

class _StatusTerapiState extends State<StatusTerapi> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    HistoryAppointmentProvider historyAppointmentProvider =
        Provider.of<HistoryAppointmentProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    statusHandler() async {
      setState(() {
        isLoading = true;
      });

      if (await historyAppointmentProvider.setStatus(
          authProvider.user.token as String, widget.id as int)) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    HistoryDetail(widget.history, widget.appointment)));
      }

      setState(() {
        isLoading = false;
      });
    }

    Widget header() {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: 90,
        decoration: BoxDecoration(color: hijauBlock),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: 30),
              child: Icon(
                Icons.arrow_back_rounded,
                color: white,
                size: 40,
              ),
            ),
            SizedBox(width: 30),
            Text(
              'History \nAppointment Terapi',
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
            inputan('Nama Saya', widget.history!.user!.name.toString(),
                'assets/SumProfile.png'),
            inputan('Nama Terapis', widget.history!.dokter!.name.toString(),
                'assets/SumTherap.png'),
            inputan(
                'Jumlah Terapi',
                historyAppointmentProvider.historydetail.length.toString(),
                'assets/SumTot.png'),
            inputan(
                'Total Harga',
                NumberFormat.currency(locale: 'id')
                    .format(widget.history!.price)
                    .toString(),
                'assets/SumTotPrice.png'),
            SizedBox(
              height: 22,
            ),
            Text(
              'Waktu dan tanggal Terapi',
              style: borderText.copyWith(fontSize: 12, fontWeight: medium),
            ),
            Container(
              margin: EdgeInsets.only(top: 22),
              width: MediaQuery.of(context).size.width - 50,
              height: 40,
              decoration: BoxDecoration(
                  border: Border.all(color: border),
                  borderRadius: BorderRadius.circular(10)),
              child: Container(
                  margin: EdgeInsets.only(left: 16, top: 10),
                  child: Text('${widget.date} - ${widget.sesiAkhir}')),
            )
          ],
        ),
      );
    }

    Widget button() {
      return GestureDetector(
        onTap: () {
          statusHandler();
        },
        child: (isLoading == true)
            ? Loading(
                margin: 0,
              )
            : Container(
                margin: EdgeInsets.only(),
                width: MediaQuery.of(context).size.width - 60,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5), color: buttonHijau),
                child: Center(
                  child: Text(
                    'Selesai',
                    style:
                        whiteText.copyWith(fontSize: 18, fontWeight: semiBold),
                  ),
                ),
              ),
      );
    }

    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            header(),
            content(),
            SizedBox(
              height: 30,
            ),
            button()
          ],
        ),
      )),
    );
  }
}
