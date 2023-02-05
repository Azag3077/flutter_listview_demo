import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class Controller extends GetxController {
  Set mainEnglishWords = <String>{};
  var englishWords = <String>{}.obs;
  FocusNode focusNode = FocusNode();

  @override
  void onInit() {
    super.onInit();
    getEnglishWords();
  }

  void getEnglishWords() async {
    rootBundle.loadString("assets/words/words.txt").then((value){
      mainEnglishWords = value.split('\n').toSet();
      englishWords = value.split('\n').toSet().obs;
    });
  }

  void onSearch(String text) {
    englishWords.clear();
    for (String name in mainEnglishWords) {
      if (
      name.toLowerCase().contains(text.toLowerCase())
      ){
        englishWords.add(name);
      }
    }
  }

  void onListItemTap() {
    focusNode.unfocus();
  }
}