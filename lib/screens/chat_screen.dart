import 'dart:developer';
import 'package:ask_ash/constant/constant.dart';
import 'package:ask_ash/providers/chats_provider.dart';
import 'package:ask_ash/providers/models_providers.dart';
import 'package:ask_ash/services/assets_manager.dart';
import 'package:ask_ash/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import '../services/services.dart';
import '../widgets/chat_widget.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool _isTyping = false;

  late TextEditingController textEditingController;
  late FocusNode focusNode;
  late ScrollController _listScrollController;

  @override
  void initState() {
    _listScrollController = ScrollController();
    textEditingController = TextEditingController();
    focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _listScrollController.dispose();
    textEditingController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  // List<ChatModel> chatList = [];

  @override
  Widget build(BuildContext context) {
    final modelsProvider = Provider.of<ModelsProvider>(context);
    final chatProvider = Provider.of<ChatProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(AssetsManager.openailogo)),
        title: const Text("Ask-Ash"),
        actions: [
          IconButton(
              onPressed: () async {
                await Services.showModalSheet(context: context);
              },
              icon: const Icon(
                Icons.more_vert_rounded,
                color: Colors.white,
              )
              // await Changemode.showdrop(context: context);
              //enable dark mode and light mode
              ),
        ],
      ),
      body: SafeArea(
          child: Column(children: [
        Flexible(
          child: ListView.builder(
              controller: _listScrollController,
              itemCount: chatProvider.getChatList.length, //chatList.length,
              itemBuilder: (context, index) {
                return Chatwidget(
                  msg: chatProvider
                      .getChatList[index].msg, //chatList[index].msg,
                  chatIndex: chatProvider.getChatList[index]
                      .chatIndex, //chatList[index].chatIndex,
                );
              }),
        ),
        if (_isTyping) ...[
          const SpinKitThreeBounce(
            color: Colors.white,
            size: 18,
          ),
        ],
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
                    focusNode: focusNode,
                    style: const TextStyle(color: Colors.white70),
                    controller: textEditingController,
                    onSubmitted: (value) async {
                      await sendMessageFCT(
                          modelsProvider: modelsProvider,
                          chatProvider: chatProvider);
                      //send msg
                    },
                    decoration: const InputDecoration.collapsed(
                        hintText: "Hi! how can I help You?",
                        hintStyle: TextStyle(color: Colors.grey)),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    await sendMessageFCT(
                        modelsProvider: modelsProvider,
                        chatProvider: chatProvider);
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
      ])),
    );
  }

  void scrollListentoEND() {
    _listScrollController.animateTo(
        _listScrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 2),
        curve: Curves.easeOut);
  }

  Future<void> sendMessageFCT(
      {required ModelsProvider modelsProvider,
      required ChatProvider chatProvider}) async {

if (_isTyping) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: TextWidget(
            label: "You can't send multiple Messages at one time",
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }


    if (textEditingController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: TextWidget(
            label: "Please type some Message here",
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    try {
      String msg = textEditingController.text;
      setState(() {
        _isTyping = true;
        chatProvider.addUserMessage(
          msg: msg);
        // chatList.add(ChatModel(msg: textEditingController.text, chatIndex: 0));
        textEditingController.clear();
        focusNode.unfocus();
      });
      await chatProvider.sendMessageAndGetAnswer(
          msg: msg,
          chooseModelId: modelsProvider.getCurrentModel);
      // chatList.addAll(
      //   await ApiService.sendMessage(
      //       message: textEditingController.text,
      //       modelId: modelsProvider.getCurrentModel),
      // );
      setState(() {});
    } catch (error) {
      log("error $error");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: TextWidget(
          label: error.toString(),
        ),
        backgroundColor: Colors.red,
      ));
    } finally {
      scrollListentoEND();
      setState(() {
        _isTyping = false;
      });
    }
  }
}
