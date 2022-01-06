import 'package:flutter/material.dart';
import 'package:haldac/pages/home.dart';
import 'package:haldac/provider/auth_provider.dart';
import 'package:haldac/provider/historyAppointment_provider..dart';
import 'package:haldac/theme.dart';
import 'package:haldac/widget/history_card.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  void initState() {
    getHistory();
    super.initState();
    print(HistoryAppointmentProvider().history.length);
  }

  bool? isLoading;

  getHistory() async {
    setState(() {
      isLoading = true;
    });

    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.get('token');
    print(pref.get('token'));
    await Provider.of<HistoryAppointmentProvider>(context, listen: false)
        .getHistory(token.toString(),
            Provider.of<AuthProvider>(context, listen: false).user.id as int);

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    HistoryAppointmentProvider historyAppointmentProvider =
        Provider.of<HistoryAppointmentProvider>(context);
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
                    MaterialPageRoute(builder: (context) => HomePage()));
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
              'Riwayat Transaksi',
              style: whiteText.copyWith(fontSize: 18, fontWeight: medium),
            )
          ],
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        body: (isLoading == true)
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(children: [
                  header(),
                  Column(
                      children: historyAppointmentProvider.history
                          .map((history) => HistoryCard(history))
                          .toList())
                ]),
              ),
      ),
    );
  }
}
