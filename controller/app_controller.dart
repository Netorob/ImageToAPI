import 'package:flutter/material.dart';

class AppController extends ChangeNotifier{

  static AppController instance = AppController();

  bool theme = false;
  mudarTema(){
    theme = !theme;
    notifyListeners();
  }
}