import 'package:flutter/material.dart';
import 'package:haldac/model/category_model.dart';
import 'package:haldac/theme.dart';
import 'package:haldac/widget/datePicker.dart';

class PilihTanggal extends StatefulWidget {
  final DoctorModel dokter;
  final int jumlahPertemuan;

  PilihTanggal(this.dokter, this.jumlahPertemuan);

  @override
  _PilihTanggalState createState() => _PilihTanggalState();
}

class _PilihTanggalState extends State<PilihTanggal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 400,
          child: ListView.builder(
            itemCount: widget.jumlahPertemuan,
            itemBuilder: (context, index) => DatePick(),
          ),
        ),
      ),
    );
  }
}
