import 'package:flutter/material.dart';

class ThemeNotifier extends ChangeNotifier{
  bool darkTheme = true;

  //getting theme

  getTheme(){
    if(darkTheme == true){
      return ThemeData.dark();
    }
    else{
      return ThemeData.light();
    }

  }
//toggle the theme
toogleTheme(){
  darkTheme = !darkTheme;
  notifyListeners();
}


}