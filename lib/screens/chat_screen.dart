import 'package:ask_ash/constant/constant.dart';
import 'package:ask_ash/services/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:ask_ash/changemod/theme_model.dart';
import '../widgets/chat_widget.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final bool _isTyping = true;

  late TextEditingController textEditingController;

  @override
  void initState() {
    textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ThemeModel themeNotifier, child) {
      return Scaffold(
        appBar: AppBar(
          elevation: 2,
          leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(AssetsManager.openailogo)),
          title: const Text("Ask-Ash"),
          actions: [
            IconButton(
              onPressed: () {
                themeNotifier.isDark
                    ? themeNotifier.isDark = false
                    : themeNotifier.isDark = true;
                // await Changemode.showdrop(context: context);
                //enable dark mode and light mode
              },
              icon: Icon(themeNotifier.isDark
                  ? Icons.wb_sunny
                  : Icons.nightlight_round),
            ),
          ],
        ),
        body: SafeArea(
            child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return Chatwidget(
                      msg: chatMessages[index]["msg"].toString(),
                      chatIndex: int.parse(
                          chatMessages[index]["chatIndex"].toString()),
                    );
                  }),
            ),
            if (_isTyping) ...[
              const SpinKitThreeBounce(
                color: Colors.white,
                size: 18,
              ),
              const SizedBox(
                height: 15,
              ),
              Material(
                color: cardColor,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          style: const TextStyle(color: Colors.white70),
                          controller: textEditingController,
                          onSubmitted: (value) {
                            //send msg
                          },
                          decoration: const InputDecoration.collapsed(
                              hintText: "Hi! how can I help you?",
                              hintStyle: TextStyle(color: Colors.grey)),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          //send msg
                        },
                        icon: const Icon(
                          Icons.send,
                          color: Colors.white70,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ]
          ],
        )),
      );
    },
    );
  }
}
