import 'package:flutter/material.dart';
import 'package:haldac/chat-detail.dart';
import 'package:haldac/provider/auth_provider.dart';
import 'package:haldac/provider/message_provider.dart';
import 'package:haldac/theme.dart';
import 'package:provider/provider.dart';

class ChatTile extends StatelessWidget {
  const ChatTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MessageProvider messageProvider = Provider.of<MessageProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    @override
    void initState() {}

    cobaChat() async {
      // await messageProvider.getMessage(authProvider.user.token as String);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ChatDetail()));
    }

    return GestureDetector(
      onTap: cobaChat,
      child: Container(
        margin: EdgeInsets.only(top: 33),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/UserPic.png',
                  width: 52,
                  height: 52,
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Kevin Wijaya',
                        style: primaryText.copyWith(
                            fontSize: 16, fontWeight: regular),
                      ),
                      Text(
                        'Bagaimana keadaannya, ssadqklndfmoiqwfnoiqwnfoqwnfoqiwnfioqnfiqnwiof',
                        style: secondaryText.copyWith(
                            fontSize: 14, fontWeight: medium),
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                ),
                Text('15.18',
                    style:
                        primaryText.copyWith(fontSize: 10, fontWeight: regular))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
