import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:haldac/model/category_model.dart';
import 'package:haldac/pages/appointment.dart';
import 'package:haldac/pages/pilihPertemuan.dart';
import 'package:haldac/pages/summary.dart';
import 'package:haldac/provider/appointment_provider.dart';
import 'package:haldac/theme.dart';
import 'package:haldac/widget/datePicker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PilihTanggal extends StatefulWidget {
  final DoctorModel dokter;
  final int jumlahPertemuan;
  final List list;
  final List listanggal;
  final List listSesiAkhir;
  final List listHarga;

  PilihTanggal(this.dokter, this.jumlahPertemuan, this.list, this.listanggal,
      this.listSesiAkhir, this.listHarga);
  @override
  _PilihTanggalState createState() => _PilihTanggalState();
}

class _PilihTanggalState extends State<PilihTanggal> {
  List<TextEditingController>? controllers;
  List<String> coba = [];

  @override
  void initState() {
    AppointmentProvider().time.length = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var dateFormat = DateFormat('dd-MM-yyyy hh:mm a');
    var list = [for (var i = 0; i < widget.jumlahPertemuan; i++) ''];

    AppointmentProvider appointmentProvider =
        Provider.of<AppointmentProvider>(context);

    Widget header() {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: 90,
        decoration: BoxDecoration(color: hijauBlock),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
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
            SizedBox(width: 64),
            Text(
              'Atur Tanggal',
              style: whiteText.copyWith(fontSize: 18, fontWeight: medium),
            )
          ],
        ),
      );
    }

    //
    Widget button() {
      return GestureDetector(
        onTap: () {
          var totalHarga = 0;
          for (var i = 0; i < widget.listHarga.length; i++) {
            totalHarga = totalHarga + widget.listHarga[i] as int;
          }

          // print(totalHarga);
          // print(widget.listHarga);
          // print(widget.listSesiAkhir);
          // print(widget.listanggal);

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Summary(
                      widget.dokter,
                      widget.jumlahPertemuan,
                      widget.listanggal,
                      widget.listSesiAkhir,
                      widget.list,
                      totalHarga,
                      widget.listHarga)));
        },
        child: Container(
          margin: EdgeInsets.only(top: 50, left: 25, right: 25, bottom: 30),
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              header(),
              SizedBox(
                height: 15,
              ),
              Column(
                children: List.generate(widget.jumlahPertemuan, (index) {
                  return Container(
                      margin: EdgeInsets.only(top: 25, right: 25, left: 25),
                      width: MediaQuery.of(context).size.width - 50,
                      decoration: BoxDecoration(
                          color: containerDatePicker,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width - 50,
                            height: 34,
                            decoration: BoxDecoration(
                                color: hijauBlock,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10))),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Terapi ' + (index + 1).toString(),
                                      style: whiteText.copyWith(
                                          fontSize: 16, fontWeight: medium)),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 14,
                          ),
                          Container(
                              margin: EdgeInsets.only(left: 14, bottom: 8),
                              child: Text('Isi Sesi Mulai',
                                  style: borderText.copyWith(
                                      fontSize: 12, fontWeight: medium))),
                          GestureDetector(
                            onTap: () {
                              print("Ini Length " +
                                  appointmentProvider.time.length.toString());
                              DatePicker.showDateTimePicker(context,
                                  showTitleActions: true,
                                  minTime: DateTime.now(), onChanged: (date) {
                                print('change $date in time zone ' +
                                    date.timeZoneOffset.inHours.toString());

                                print(appointmentProvider.waktu);
                              }, onConfirm: (date) {
                                print('confirm $date');

                                print(appointmentProvider.time.length);
                                // (appointmentProvider.time.length == index)
                                //     ? appointmentProvider.time
                                //         .insert(index, date)
                                //     : appointmentProvider.time.removeAt(index);
                                // appointmentProvider.time.insert(index, date);
                                // (appointmentProvider.time.length != 0)
                                //     ? appointmentProvider.time[index] = date
                                //     : print('salah');

                                // if (appointmentProvider.time.length == 0) {
                                //   for (var i = 0;
                                //       i < widget.jumlahPertemuan;
                                //       i++) {
                                //     appointmentProvider.time.insert(i, date);
                                //   }
                                // } else if (appointmentProvider.time.length ==
                                //     widget.jumlahPertemuan) {
                                //   appointmentProvider.time
                                //       .replaceRange(index, index + 1, [date]);
                                // }
                                widget.listanggal
                                    .replaceRange(index, index + 1, [date]);
                                print(widget.listanggal);
                                setState(() {});

                                // print("Ini" +
                                //     appointmentProvider.time[index].toString());

                                // //

                                // print(appointmentProvider.waktu);

                                // print("Ini Time Provider : " +
                                //     appointmentProvider.time.toString());
                                // print("Ini Provider ke -" +
                                //     index.toString() +
                                //     appointmentProvider.time.toString());
                                // print("Ini Index:" + index.toString());
                                //                     // print(appointmentProvider.waktu);

                                //                     // print('nilai controllers ' +
                                //                     //     (controllers?[index].text).toString());
                                //                     // print(text1.text);
                              }, locale: LocaleType.id);
                            },
                            child: Container(
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                        // (appointmentProvider.time.length == 0)
                                        //     ? 'Pilih Tanggal & Jam Terapi'
                                        //     : (index == 0)
                                        //         ? dateFormat.format(
                                        //             appointmentProvider.time[0])
                                        //         : (appointmentProvider
                                        //                     .time[index] ==
                                        //                 appointmentProvider
                                        //                     .time[0])
                                        //             ? 'Pilih Tanggal & Jam Terapi'
                                        //             : dateFormat
                                        //                 .format(
                                        //                     appointmentProvider
                                        //                         .time[index])
                                        //                 .toString(),

                                        dateFormat
                                            .format(widget.listanggal[index]),
                                        style: dateText.copyWith(
                                            fontSize: 14, fontWeight: medium)),
                                    Icon(Icons.calendar_today_sharp,
                                        color: hijauBlock)
                                  ]),
                            ),
                          ),

                          SizedBox(
                            height: 14,
                          ),
                          Container(
                              margin: EdgeInsets.only(left: 14, bottom: 8),
                              child: Text('Durasi Sesi',
                                  style: borderText.copyWith(
                                      fontSize: 12, fontWeight: medium))),
                          Container(
                            margin: EdgeInsets.only(left: 20, right: 20),
                            child: DropdownButton<String>(
                              value: widget.list[index].toString(),
                              isExpanded: true,
                              // icon: const Icon(Icons.arrow_downward),
                              // iconSize: 24,
                              // elevation: 16,
                              style: TextStyle(color: hijauBlock),

                              onChanged: (String? newValue) {
                                setState(() {
                                  print(appointmentProvider.sesi.length);
                                  print(index);
                                  print(appointmentProvider.sesi);
                                  print(list);
                                  print(widget.list);

                                  widget.list.replaceRange(
                                      index, index + 1, [newValue.toString()]);
                                  print(widget.list);

                                  widget.listSesiAkhir
                                      .replaceRange(index, index + 1, [
                                    widget.listanggal[index].add(Duration(
                                        minutes:
                                            int.parse(widget.list[index]))),
                                  ]);

                                  print(widget.listSesiAkhir);

                                  if (widget.list[index] == '30') {
                                    widget.listHarga.replaceRange(index,
                                        index + 1, [widget.dokter.price! * 1]);
                                  } else if (widget.list[index] == '45') {
                                    widget.listHarga.replaceRange(
                                        index,
                                        index + 1,
                                        [(widget.dokter.price! * 1.5).round()]);
                                  } else if (widget.list[index] == '60') {
                                    widget.listHarga.replaceRange(index,
                                        index + 1, [widget.dokter.price! * 2]);
                                  } else if (widget.list[index] == '90') {
                                    widget.listHarga.replaceRange(index,
                                        index + 1, [widget.dokter.price! * 3]);
                                  } else if (widget.list[index] == '120') {
                                    widget.listHarga.replaceRange(index,
                                        index + 1, [widget.dokter.price! * 4]);
                                  }
                                  print(widget.listHarga);

                                  // if (appointmentProvider.sesi.length == 0) {
                                  //   for (var i = 0;
                                  //       i < widget.jumlahPertemuan;
                                  //       i++) {
                                  //     appointmentProvider.sesi
                                  //         .insert(i, newValue.toString());
                                  //   }
                                  // } else {
                                  //   appointmentProvider.sesi.replaceRange(
                                  //       index, index + 1, [newValue.toString()]);
                                  // }
                                  // print(appointmentProvider
                                  //     .sesi); // print(appointmentProvider.sesi[index]);
                                });
                              },
                              items: <String>[
                                '30',
                                '45',
                                '60',
                                '90',
                                '120'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text('$value Menit'),
                                );
                              }).toList(),
                            ),
                          ),
                          SizedBox(
                            height: 14,
                          ),
                          Container(
                              margin: EdgeInsets.only(left: 14, bottom: 8),
                              child: Text('Sesi Selesai (Terisi Otomatis)',
                                  style: borderText.copyWith(
                                      fontSize: 12, fontWeight: medium))),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                    dateFormat.format(widget.listanggal[index]
                                        .add(Duration(
                                            minutes: int.parse(
                                                widget.list[index])))),
                                    style: dateText.copyWith(
                                        fontSize: 14, fontWeight: medium)),
                                Icon(Icons.lock_clock_outlined,
                                    color: hijauBlock)
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 14,
                          ),
                          Container(
                              margin: EdgeInsets.only(left: 20, right: 20),
                              child: Image.asset('assets/Line.png')),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  'Harga',
                                  style: dateText.copyWith(
                                      fontSize: 14, fontWeight: medium),
                                ),
                                Text(
                                    '${NumberFormat.currency(locale: 'id').format(widget.listHarga[index])}',
                                    style: price.copyWith(
                                        fontSize: 14, fontWeight: medium))
                              ],
                            ),
                          )
                          // Text(
                          //   '${widget.listHarga[index]}',
                          //   style: dateText.copyWith(
                          //       fontSize: 14, fontWeight: medium),
                          // ),
                          // Text('${widget.listHarga[index]}')

                          // else if (appointmentProvider.sesi.length != 0 &&
                          //     appointmentProvider.time.length == 0) ...[
                          //   Text('Masukan Tanggal Dulu')
                          // ] else if (appointmentProvider.sesi.length == 0) ...[
                          //   Text(
                          //       '${dateFormat.format(appointmentProvider.time[index].add(Duration(minutes: 30)))}')
                          // ] else if (appointmentProvider.sesi[0] ==
                          //         appointmentProvider.sesi[index] &&
                          //     appointmentProvider.time[0] ==
                          //         appointmentProvider.time[index]) ...[
                          //   Text('Silahkan Masukan Tanggal dan Jam')
                          // ] else ...[
                          //   Text(
                          //       '${dateFormat.format(appointmentProvider.time[index].add(Duration(minutes: int.parse(appointmentProvider.sesi[index]))))}')
                          // ]
                        ],
                      ));
                }),
              ),
              // (appointmentProvider.time.length == 0) ? Container() : button()
              // if (appointmentProvider.time.length == 0 &&
              //     widget.jumlahPertemuan == 1) ...[
              //   Container()
              // ] else if (appointmentProvider.time.length == 0) ...[
              //   Container()
              // ] else if (appointmentProvider.time.first !=
              //     appointmentProvider.time.last) ...[
              //   button()
              // ] else
              //   button()
              button()
              // : (appointmentProvider.time.first ==
              //         appointmentProvider.time.last)
              //     ? Container()
              //     : (appointmentProvider.time.first ==
              //                 appointmentProvider.time.last &&
              //             widget.jumlahPertemuan == 1)
              //         ? button()
              //         : Container()
            ],
          ),
        ),
      ),
    );
  }
}
