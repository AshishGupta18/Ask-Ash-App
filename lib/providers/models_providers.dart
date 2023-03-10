import 'package:ask_ash/models/models_model.dart';
import 'package:ask_ash/services/api_services.dart';
import 'package:flutter/material.dart';

class ModelsProvider with ChangeNotifier {
  String currentModel = "text-davinci-003";
  String get getCurrentModel {
    return currentModel;
  }

  void setModelsList(String newModel) {
    currentModel = newModel;
    notifyListeners();
  }

  List<ModelsModel> modelsList = [];

  List<ModelsModel> get getModelsList {
    return modelsList;
  }

  Future<List<ModelsModel>> getAllModels() async {
    modelsList = await ApiService.getModels();
    return modelsList;
  }

  void setCurrentModel(String model) {
    currentModel = model;
    notifyListeners();
  }
}
