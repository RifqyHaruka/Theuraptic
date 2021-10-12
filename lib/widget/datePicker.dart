import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:haldac/pages/appointment.dart';
import 'package:haldac/provider/appointment_provider.dart';
import 'package:haldac/provider/auth_provider.dart';
import 'package:haldac/theme.dart';
import 'dart:ui';

import 'package:provider/provider.dart';

class DatePick extends StatefulWidget {
  TextEditingController text1 = TextEditingController(text: '2');
  @override
  _DatePickState createState() => _DatePickState();
}

class _DatePickState extends State<DatePick> {
  @override
  Widget build(BuildContext context) {
    AppointmentProvider appointmentProvider =
        Provider.of<AppointmentProvider>(context);

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.only(left: 30, right: 30),
            height: 50,
            width: MediaQuery.of(context).size.width - 60,
            decoration: BoxDecoration(
                border: Border.all(color: primary),
                borderRadius: BorderRadius.circular(8)),
            child: Center(
              child: Column(
                children: [
                  TextFormField(
                    onChanged: (value) {},
                    keyboardType: TextInputType.number,
                    controller: widget.text1,
                    decoration: InputDecoration.collapsed(
                        hintText: ('Masukan Jumlah Pertemuan (Min 1 Pertemuan)')
                            .toString()),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              DatePicker.showDateTimePicker(context,
                  showTitleActions: true,
                  minTime: DateTime(2020, 5, 5, 20, 50),
                  maxTime: DateTime(2020, 6, 7, 05, 09), onChanged: (date) {
                print('change $date in time zone ' +
                    date.timeZoneOffset.inHours.toString());
                appointmentProvider.waktu = date.toString();
                print(appointmentProvider.waktu);
              }, onConfirm: (date) {
                print('confirm $date');
                appointmentProvider.waktu = date.toString();
                print(appointmentProvider.waktu);
                widget.text1.text = appointmentProvider.waktu;
                print(widget.text1.text);
              }, locale: LocaleType.id);
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 10),
              width: 320,
              height: 50,
              decoration: BoxDecoration(color: hijauBlock),
            ),
          )
        ],
      ),
    );
  }
}
