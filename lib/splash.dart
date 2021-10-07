import 'dart:async';
import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:haldac/model/user_model.dart';

import 'package:haldac/provider/auth_provider.dart';
import 'package:haldac/provider/category_provider.dart';
import 'package:haldac/provider/dokter_provider.dart';
import 'package:haldac/provider/message_provider.dart';
import 'package:haldac/theme.dart';
import 'package:provider/provider.dart';
import 'package:pusher_client/pusher_client.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  PusherClient? pusher;
  Channel? channel;

  bool isAuth = false;

  getInit() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    var token = pref.get('token');
    if (token != null) {
      setState(() {
        isAuth = true;
        print(token);
        getInit2();
      });
    } else {
      Timer(Duration(seconds: 2), () {
        Navigator.pushNamed(context, '/daftar');
      });
    }
  }

  getDokter() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    var token = pref.getString('token');
    await Provider.of<DokterProvider>(context, listen: false).getDokters(token);
  }

  @override
  void initState() {
    getInit();
    getDokter();
    // Timer(Duration(seconds: 2), () {
    //   Navigator.pushNamed(context, '/daftar');
    // });

    //   print(isAuth);
    // } else {
    //   Timer(Duration(seconds: 3), () {
    //     Navigator.pushNamed(context, '/daftar');
    //   });
    // }
    // Timer(Duration(seconds: 2), () {
    //   Navigator.pushNamed(context, '/daftar');
    // });
    // PusherClient pusher =
    //     PusherClient('4ba1ed2899b97dd0fb6c', PusherOptions(cluster: 'ap1'));
    // pusher.connect();
    // Channel channel = pusher.subscribe('my-channel');

    // channel.bind('my-event', (event) {
    //   setState(() {
    //     print(event!.data);
    //   });
    // });
    // pusher.onConnectionStateChange((state) {
    //   log(state!.currentState as String);
    // });
    // pusher.onConnectionError((error) {
    //   log(error!.message as String);
    // });
    // try {
    //   pusher = PusherClient(
    //       '4ba1ed2899b97dd0fb6c', PusherOptions(cluster: 'ap1'),
    //       autoConnect: false);
    //   pusher!.connect();
    //   channel = pusher!.subscribe('haruka-channel');

    //   channel!.bind('haruka-event', (event) {
    //     log(event!.data as String);
    //   });
    // } catch (e) {
    //   print(e);
    // }

    // initPusher();

    super.initState();
  }

  getInit2() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.get('token');

    await Provider.of<AuthProvider>(context, listen: false).getData();
    Navigator.pushNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/Logo.png',
              width: 187,
              height: 186,
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                pusher!.disconnect();
              },
              child: Container(
                width: 100,
                height: 50,
                color: Colors.black,
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> initPusher() async {
    // try {
    //   await Pusher.init('508d712f416e23d84bf4', PusherOptions(cluster: 'ap1'));
    // } catch (e) {
    //   print(e);
    // }

    // Pusher.connect(onConnectionStateChange: (val) {
    //   print(val.currentState);
    // }, onError: (err) {
    //   print(err.message);
    // });

    try {
      PusherClient pusher =
          PusherClient('508d712f416e23d84bf4', PusherOptions(cluster: 'ap1'));
      pusher.connect();
      pusher.onConnectionStateChange((state) {
        print(state!.currentState);
      });
      pusher.onConnectionError((error) {
        print(error!.message);
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> getMessage() async {
    // try {
    //   List<MessageModel> message = await MessageService().getMessage(token);
    //   _message = message;
    // } catch (e) {
    //   print('salah di provider');
    //   print(e);
    // }
  }
}
