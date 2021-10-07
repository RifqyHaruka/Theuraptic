import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:haldac/provider/auth_provider.dart';
import 'package:haldac/provider/message_provider.dart';
import 'package:haldac/widget/chat-bubble.dart';
import 'package:provider/provider.dart';
import 'package:pusher_client/pusher_client.dart';
import 'model/message_model.dart';
import 'theme.dart';

class ChatDetail extends StatefulWidget {
  const ChatDetail({Key? key}) : super(key: key);

  @override
  _ChatDetailState createState() => _ChatDetailState();
}

class _ChatDetailState extends State<ChatDetail> {
  PusherClient? pusher;
  Channel? channel;

  @override
  void initState() {
    getInit();

    super.initState();
  }

  getInit() async {
    await Provider.of<MessageProvider>(context, listen: false).channelBind();
  }

  // bindHandler() {
  //   channel!.bind('haruka-event', (event) {
  //     log(event!.data as String);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    MessageProvider messageProvider = Provider.of<MessageProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    PreferredSizeWidget header() {
      return PreferredSize(
          child: AppBar(
            backgroundColor: hijauBlock,
            centerTitle: false,
            title: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Image.asset(
                    "assets/UserPic.png",
                    width: 40,
                    height: 40,
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Alice Semesta',
                        style:
                            whiteText.copyWith(fontSize: 14, fontWeight: light),
                      ),
                      Text(
                        'Online',
                        style: secondaryText.copyWith(
                            fontSize: 15, fontWeight: light),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          preferredSize: Size.fromHeight(70));
    }

    Widget chatInput() {
      return Container(
        margin: EdgeInsets.only(top: 20, left: 20, bottom: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                      width: 270,
                      height: 45,
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                          color: primary,
                          borderRadius: BorderRadius.circular(12)),
                      child: Center(
                        child: TextFormField(
                          style: whiteText.copyWith(
                              fontSize: 14, fontWeight: regular),
                          decoration: InputDecoration.collapsed(
                              hintText: 'Write a Message',
                              hintStyle: secondaryText.copyWith(
                                  fontSize: 14, fontWeight: regular)),
                        ),
                      )),
                ),
                SizedBox(
                  width: 20,
                ),
                Icon(Icons.send)
              ],
            ),
          ],
        ),
      );
    }

    Widget content() {
      return ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 30),
          itemCount: messageProvider.message.length,
          itemBuilder: (BuildContext context, int index) {
            final MessageModel message = messageProvider.message[index];

            return ChatBubble(message: message);
          });
      //   // children: messageProvider.message
      //   //     .map((message) => ChatBubble(
      //   //           message: message,
      //   //         ))
      //   //     .toList()
      //   // ChatBubble(
      //   //   text: 'Halo Saya Asep',
      //   //   isSender: false,
      //   // ),
      //   // ChatBubble(
      //   //   text: 'Ive been feeling bad lately. What should I do?',
      //   //   isSender: true,
      //   // )
      // );
      // return ListView(
      //   padding: EdgeInsets.symmetric(horizontal: 30),
      //   children: [
      //     (messageProvider.isNull == true)
      //         ? Container()
      //         : ChatBubble(text: messageProvider.test)
      //     // ChatBubble(text: messageProvider.test)
      //   ],
      // );
    }

    return SafeArea(
      child: Scaffold(
        body: Scaffold(
            appBar: header(),
            bottomNavigationBar: chatInput(),
            backgroundColor: white,
            body: content()),
      ),
    );
  }
}
