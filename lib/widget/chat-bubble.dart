import 'package:flutter/material.dart';
import 'package:haldac/model/message_model.dart';
import 'package:haldac/provider/auth_provider.dart';
import 'package:haldac/theme.dart';
import 'package:provider/provider.dart';

class ChatBubble extends StatelessWidget {
  final String? text;
  bool? isSender;
  final MessageModel? message;

  ChatBubble({this.text, this.isSender = false, this.message});
  // this.message});

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    if ((authProvider.user.id).toString() != message!.userId) {
      isSender = true;
    } else {
      isSender = false;
    }
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: (isSender == true)
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: (isSender == true)
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              Flexible(
                child: Container(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.6),
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(isSender as bool ? 12 : 0),
                          topRight: Radius.circular(isSender as bool ? 0 : 12),
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12)),
                      color: (isSender == true) ? white : bubbleChat),
                  child: Text(
                    message!.body as String,
                    style:
                        primaryText.copyWith(fontSize: 14, fontWeight: regular),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
