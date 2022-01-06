import 'package:flutter/material.dart';
import 'package:haldac/chat-detail.dart';
import 'package:haldac/pages/anak.dart';
import 'package:haldac/pages/appointment.dart';
import 'package:haldac/pages/daftar.dart';
import 'package:haldac/pages/home.dart';
import 'package:haldac/pages/homeTherapis.dart';
import 'package:haldac/pages/lansia.dart';
import 'package:haldac/pages/mainTherapis.dart';
import 'package:haldac/pages/pilihTanggal.dart';
import 'package:haldac/pages/pilihaLogin.dart';
import 'package:haldac/pages/profile.dart';
import 'package:haldac/pages/sign_in.dart';
import 'package:haldac/pages/sign_up.dart';
import 'package:haldac/pages/summary.dart';
import 'package:haldac/provider/appointment_provider.dart';
import 'package:haldac/provider/article_provider.dart';
import 'package:haldac/provider/auth_provider.dart';
import 'package:haldac/provider/category_provider.dart';
import 'package:haldac/provider/dokter_provider.dart';
import 'package:haldac/provider/historyAppointment_provider..dart';
import 'package:haldac/provider/message_provider.dart';

import 'package:haldac/splash.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MessageProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => DokterProvider()),
        ChangeNotifierProvider(
          create: (context) => CategoryProvider(),
        ),
        ChangeNotifierProvider(create: (context) => AppointmentProvider()),
        ChangeNotifierProvider(
            create: (context) => HistoryAppointmentProvider()),
        ChangeNotifierProvider(create: (context) => ArticleProvider())
      ],
      child: MaterialApp(
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaleFactor: 1.0,
            ), //set desired text scale factor here
            child: child as Widget,
          );
        },
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => SplashPage(),
          '/daftar': (context) => DaftarPage(),
          '/home': (context) => HomePage(),
          '/sign-in': (context) => SignInPage(),
          '/sign-up': (context) => SignUpPage(),
          '/profile': (context) => ProfilePage(),
          '/appointment': (context) => Appointment(),
          '/chat-detail': (context) => ChatDetail(),
          '/anak': (context) => TumbuhKembangAnak(),
          '/lansia': (context) => InfoLansia(),
          '/pilihanLogin': (context) => PilihanLogin(),
          '/main-therapis': (context) => MainTherapis()
        },
      ),
    );
  }
}
