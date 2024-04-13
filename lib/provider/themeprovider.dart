import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier extends ChangeNotifier{
  bool darkTheme = false;

  //getting theme

 Future<ThemeData> getTheme()async{
  //since getTheme() function return future<Themedata> thats why i have to wait
  //till it gives Themedata we can use futurebuilder or steambuilder to handle this

      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//       //initially it's value will be false oviously
 darkTheme =  sharedPreferences.getBool("isDt")??false;


    if(darkTheme == true){
      return ThemeData.dark();
    }
    else{
      return ThemeData.light();
    }

  }
//toggle the theme
toogleTheme(BuildContext context){
  //show the circularprogress indicator and dismiss as like dialogbox
  showDialog(context: context, builder: (context) {
    return CircularProgressIndicator();

  });
  darkTheme = !darkTheme;
  
  //after operation complete dialog dismiss
  Navigator.pop(context);
  notifyListeners();
  saveThemeState(darkTheme);//same thme state in background without blocking the code
}


saveThemeState(bool darkThemeState)async{
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setBool("isDt", darkThemeState);



}


}