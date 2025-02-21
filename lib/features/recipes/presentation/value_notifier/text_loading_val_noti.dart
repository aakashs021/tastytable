import 'package:flutter/material.dart';

class TextLoadingValNoti extends ChangeNotifier{
  bool isloaded=false;
  imageLoaded(){
    isloaded=true;
    notifyListeners();
  }
}