import 'package:flutter/material.dart';
import 'package:haldac/model/historyAppointment_model.dart';
import 'package:haldac/pages/historyDetail.dart';
import 'package:haldac/pages/home.dart';
import 'package:haldac/provider/auth_provider.dart';
import 'package:haldac/provider/historyAppointment_provider..dart';
import 'package:haldac/theme.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryCard extends StatefulWidget {
  HistoryAppointmentModel? history;
  String? token;
  HistoryCard(this.history);

  @override
  _HistoryCardState createState() => _HistoryCardState();
}

class _HistoryCardState extends State<HistoryCard> {
  @override
  Widget build(BuildContext context) {
    HistoryAppointmentProvider historyAppointmentProvider =
        Provider.of<HistoryAppointmentProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    appointmentDetailHandler() async {
      print(widget.history!.id);

      SharedPreferences pref = await SharedPreferences.getInstance();
      var token = pref.get('token');
      if (await historyAppointmentProvider.getHistoryDetail(
          token as String, widget.history!.id as int)) {
        print(historyAppointmentProvider.historydetail);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HistoryDetail(
                    widget.history, historyAppointmentProvider.historydetail)));
      }
    }

    var dateFormat = DateFormat('dd-MM-yyyy hh:mm ');
    return GestureDetector(
      onTap: () {
        appointmentDetailHandler();
      },
      child: Container(
          margin: EdgeInsets.only(top: 10, right: 10, left: 10, bottom: 10),
          width: MediaQuery.of(context).size.width,
          height: 112,
          decoration: BoxDecoration(
              color: historyCard, borderRadius: BorderRadius.circular(15)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    (authProvider.roles == 'USER')
                        ? widget.history!.dokter!.name.toString()
                        : widget.history!.user!.name.toString(),
                    style:
                        blackText.copyWith(fontSize: 14, fontWeight: regular),
                  ),
                  Text(
                    NumberFormat.currency(locale: 'id')
                        .format(widget.history!.price),
                    style: price.copyWith(fontSize: 14, fontWeight: regular),
                  )
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    '${widget.history!.code}',
                    style:
                        blackText.copyWith(fontSize: 14, fontWeight: regular),
                  ),
                  Text(
                    dateFormat
                        .format(widget.history!.createdAt as DateTime)
                        .toString(),
                    style: price.copyWith(fontSize: 14, fontWeight: regular),
                  )
                ],
              )
            ],
          )),
    );
  }
}
