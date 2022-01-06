import 'package:flutter/material.dart';
import 'package:haldac/model/appointmet_detail_model.dart';
import 'package:haldac/model/historyAppointment_model.dart';
import 'package:haldac/pages/history.dart';
import 'package:haldac/pages/statusTerapi.dart';
import 'package:haldac/provider/appointment_provider.dart';
import 'package:haldac/provider/auth_provider.dart';
import 'package:haldac/provider/historyAppointment_provider..dart';
import 'package:haldac/theme.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryDetail extends StatefulWidget {
  final HistoryAppointmentModel? history;
  final List<AppointmentDetailModel>? appointment;
  HistoryDetail(this.history, this.appointment);

  @override
  State<HistoryDetail> createState() => _HistoryDetailState();
}

class _HistoryDetailState extends State<HistoryDetail> {
  var dateFormat = DateFormat('hh:mm a');
  var dateFormatYear = DateFormat('dd-MM-yyyy hh:mm a');
  @override
  void initState() {
    getHistory();
    super.initState();
  }

  getHistory() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.get('token');
    print(pref.get('token'));
    if (await Provider.of<HistoryAppointmentProvider>(context, listen: false)
            .getHistoryDetail(token.toString(), widget.history!.id as int) ==
        true) {
      setState(() {});
      print(widget.appointment![0].date);
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
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HistoryPage()));
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
          ],
        ),
      );
    }

    Widget appointmentDate(int index) {
      return (authProvider.roles == 'USER')
          ? GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StatusTerapi(
                            widget.appointment,
                            historyAppointmentProvider.historydetail[index].id,
                            widget.history,
                            dateFormatYear
                                .format(DateTime.parse(
                                    historyAppointmentProvider
                                        .historydetail[index].date
                                        .toString()))
                                .toString(),
                            dateFormat
                                .format(DateTime.parse(
                                    historyAppointmentProvider
                                        .historydetail[index].sesiAkhir
                                        .toString()))
                                .toString())));
              },
              child: Container(
                margin:
                    EdgeInsets.only(top: 14, left: 25, right: 25, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Terapi ke-' + (index + 1).toString(),
                      style:
                          borderText.copyWith(fontSize: 14, fontWeight: medium),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 50,
                      height: 40,
                      decoration: BoxDecoration(
                          border: (historyAppointmentProvider
                                      .historydetail[index].status ==
                                  'TRUE')
                              ? Border.all(color: hijauBlock)
                              : Border.all(color: border),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              margin: EdgeInsets.only(left: 16),
                              child: Text(
                                dateFormatYear
                                        .format(DateTime.parse(
                                            historyAppointmentProvider
                                                .historydetail[index].date
                                                .toString()))
                                        .toString() +
                                    ' - ' +
                                    dateFormat
                                        .format(DateTime.parse(
                                            historyAppointmentProvider
                                                .historydetail[index].sesiAkhir
                                                .toString()))
                                        .toString(),
                                style: (historyAppointmentProvider
                                            .historydetail[index].status ==
                                        'TRUE')
                                    ? price.copyWith(
                                        fontSize: 14, fontWeight: medium)
                                    : dateText.copyWith(
                                        fontSize: 14, fontWeight: medium),
                              )),
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
              ),
            )
          : Container(
              margin: EdgeInsets.only(top: 14, left: 25, right: 25, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Terapi ke-' + (index + 1).toString(),
                    style:
                        borderText.copyWith(fontSize: 14, fontWeight: medium),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 50,
                    height: 40,
                    decoration: BoxDecoration(
                        border: (historyAppointmentProvider
                                    .historydetail[index].status ==
                                'TRUE')
                            ? Border.all(color: hijauBlock)
                            : Border.all(color: border),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            margin: EdgeInsets.only(left: 16),
                            child: Text(
                              dateFormatYear
                                      .format(DateTime.parse(
                                          historyAppointmentProvider
                                              .historydetail[index].date
                                              .toString()))
                                      .toString() +
                                  ' - ' +
                                  dateFormat
                                      .format(DateTime.parse(
                                          historyAppointmentProvider
                                              .historydetail[index].sesiAkhir
                                              .toString()))
                                      .toString(),
                              style: (historyAppointmentProvider
                                          .historydetail[index].status ==
                                      'TRUE')
                                  ? price.copyWith(
                                      fontSize: 14, fontWeight: medium)
                                  : dateText.copyWith(
                                      fontSize: 14, fontWeight: medium),
                            )),
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
                    historyAppointmentProvider.historydetail.length,
                    (index) => appointmentDate(index))),
          ],
        ),
      )),
    );
  }
}
