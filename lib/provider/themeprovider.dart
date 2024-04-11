import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier extends ChangeNotifier{
  bool darkTheme = false;

  //getting theme

  getTheme(){

//       SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//       //initially it's value will be false oviously
//  darkTheme =  sharedPreferences.getBool("isDt")??false;


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
  // saveThemeState(darkTheme);
  notifyListeners();
}


saveThemeState(bool darkThemeState)async{
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setBool("isDt", darkThemeState);



}


}