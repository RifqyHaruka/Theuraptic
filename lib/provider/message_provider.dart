import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:haldac/model/message_model.dart';
import 'package:haldac/services/message_services.dart';
import 'package:pusher_client/pusher_client.dart';

class MessageProvider with ChangeNotifier {
  bool _isNull = true;
  String? _test;
  PusherClient? pusher;
  Channel? channel;
  List<MessageModel> _message = [];
  List<String> _coba = [];

  List<MessageModel> get message => _message;
  bool get isNull => _isNull;
  String get test => _test as String;
  List<String> get coba => _coba;

  set coba(List<String> coba) {
    _coba = coba;
    notifyListeners();
  }

  set test(String test) {
    _test = test;
    notifyListeners();
  }

  set isNull(bool isNull) {
    _isNull = isNull;
    notifyListeners();
  }

  // set message(List<MessageModel> message) {
  //   _message = message;
  //   notifyListeners();
  // }

  // Future<void> getMessage(String token) async {
  //   // try {
  //   //   List<MessageModel> message = await MessageService().getMessage(token);
  //   //   _message = message;
  //   // } catch (e) {
  //   //   print('salah di provider');
  //   //   print(e);
  //   // }

  //   try {
  //     PusherClient pusher = await PusherClient(
  //         '4ba1ed2899b97dd0fb6c', PusherOptions(cluster: 'ap1'));
  //     pusher.connect();

  //     pusher.onConnectionStateChange((state) {
  //       print(state!.currentState);
  //     });
  //     pusher.onConnectionError((error) {
  //       print(error!.message);
  //     });
  //     Channel channel = await pusher.subscribe('haruka-channel');
  //     channel.bind('haruka-event', (event) {
  //       channel.trigger('haruka-event', event!.data);
  //     });
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  Future<void> channelBind() async {
    try {
      pusher = PusherClient(
          '4ba1ed2899b97dd0fb6c', PusherOptions(cluster: 'ap1'),
          autoConnect: false);
      pusher!.connect();
      channel = pusher!.subscribe('haruka-channel');
      channel!.bind('haruka-event', (event) {
        if (event!.data!.isEmpty) {
          _isNull = true;
        } else {
          _isNull = false;
          var data = jsonDecode(event.data as String)['data']['messages'];

          List<MessageModel> model = [];

          for (var item in data) {
            model.add(MessageModel.fromJson(item));
          }

          _message = model;
        }

        // print(_test);
        notifyListeners();
      });
    } catch (e) {
      print(e);
    }
  }

  // Future<void> channelBindList(String token) async {
  //   try {
  //     pusher = PusherClient(
  //         '4ba1ed2899b97dd0fb6c', PusherOptions(cluster: 'ap1'),
  //         autoConnect: false);
  //     pusher!.connect();
  //     channel = pusher!.subscribe('haruka-channel');
  //     channel!.bind('haruka-event', (event) async {
  //       if (event!.data!.isEmpty) {
  //         _isNull = true;
  //       } else {
  //         _isNull = false;
  //         List<MessageModel> data = await MessageService().getMessage(token);

  //         _message = data;
  //         notifyListeners();
  //       }

  //       // print(_test);
  //       notifyListeners();
  //     });
  //   } catch (e) {
  //     print(e);
  //   }
  // }
  // Future<void> pusher() async {
  //   try {
  //     PusherClient pusherClient = await PusherClient(
  //         '4ba1ed2899b97dd0fb6c', PusherOptions(cluster: 'ap1'));
  //     pusherClient.connect();
  //   } catch (e) {}
  // }
}
