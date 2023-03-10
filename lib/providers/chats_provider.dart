import 'package:ask_ash/models/chat_models.dart';
import 'package:ask_ash/services/api_services.dart';
import 'package:flutter/material.dart';

class ChatProvider with ChangeNotifier {
  List<ChatModel> chatList = [];
  List<ChatModel> get getChatList {
    return chatList;
  }

  void addUserMessage({required String msg}) {
    chatList.add(ChatModel(
      msg: msg,
      chatIndex: 0,
    ));
    notifyListeners();
  }

  Future<void> sendMessageAndGetAnswer(
      {required String msg, required String chooseModelId}) async {
          chatList.addAll(
        await ApiService.sendMessage(
            message: msg,
            modelId: chooseModelId),
      );
       notifyListeners();
      }
}
