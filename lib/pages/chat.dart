import 'package:flutter/material.dart';
import 'package:haldac/provider/auth_provider.dart';
import 'package:haldac/provider/message_provider.dart';
import 'package:haldac/theme.dart';
import 'package:haldac/widget/chat-tile.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // @override
  // void initState() {
  //   chat();
  //   super.initState();
  // }

  // chat() async {
  //   await Provider.of<MessageProvider>(context, listen: false).getMessage();
  // }

  Widget header() {
    return Container(
      margin: EdgeInsets.only(top: 80, left: 20, bottom: 15),
      child: Text(
        'Kumpulan pesan dan \nkonsultasi Anda',
        style: whiteText.copyWith(fontSize: 18, fontWeight: medium),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    MessageProvider messageProvider = Provider.of<MessageProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    cobaChat() async {
      setState(() {
        // messageProvider.getMessage(authProvider.user.token as String);
      });

      // Navigator.pushNamed(context, 'chat-detail');
    }

    Widget contentFill() {
      return Container(
        margin: EdgeInsets.only(top: 16, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(onTap: cobaChat, child: ChatTile()),
            ChatTile()
          ],
        ),
      );
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              width: double.infinity,
              decoration: BoxDecoration(color: hijauBlock),
              child: header()),
          contentFill()
        ],
      ),
    );
  }
}
