import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:ask_ash/models/chat_models.dart';
import 'package:ask_ash/models/models_model.dart';
import 'package:http/http.dart' as http;

import '../constant/api_const.dart';

class ApiService {
  static Future<List<ModelsModel>> getModels() async {
    try {
      var response = await http.get(
        Uri.parse("$BASE_URL/models"),
        headers: {'Authorization': 'Bearer $API_KEY'},
      );

      Map jsonResponse = jsonDecode(response.body);
      if (jsonResponse['error'] != null) {
        // print("jsonResponse['error'] ${jsonResponse['error']["message"]}");
        throw HttpException(jsonResponse['error']["message"]);
      }
      // print("JsonResponse $jsonResponse");
      List temp = [];
      for (var value in jsonResponse["data"]) {
        temp.add(value);
        // log("temp ${value["id"]}");
      }

      return ModelsModel.modelsFromSnapshot(temp);
    } catch (error) {
      log("error $error");
      rethrow;
    }
  }

  //send message fct
  static Future<List<ChatModel>> sendMessage(
      {required String message, required String modelId}) async {
    try {
      log("modelId $modelId");
      var response = await http.post(
        Uri.parse("$BASE_URL/completions"),
        headers: {
          'Authorization': 'Bearer $API_KEY',
          'Content-Type': "application/json"
        },
        body: jsonEncode(
          {
            "model": modelId,
            "prompt": message,
            "max_tokens": 100,
            "temperature": 0.7,
          },
        ),
      );

      Map jsonResponse = jsonDecode(response.body);
      if (jsonResponse['error'] != null) {
        // print("jsonResponse['error'] ${jsonResponse['error']["message"]}");
        throw HttpException(jsonResponse['error']["message"]);
      }
      List<ChatModel> chatList = [];
      if (jsonResponse["choices"].length > 0) {
        chatList = List.generate(
          jsonResponse["choices"].length,
          (index) => ChatModel(
            msg: jsonResponse["choices"][index]["text"],
            chatIndex: 1,
          ),
        );
        // log("jsonResponse[choices]text ${jsonResponse["choices"][0]["text"]}");
      }
      return chatList;
    } catch (error) {
      log("error $error");
      rethrow;
    }
  }
}
