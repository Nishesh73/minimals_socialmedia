import 'dart:js';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:minimalsocialmedia/firebase_options.dart';
import 'package:minimalsocialmedia/provider/themeprovider.dart';
import 'package:minimalsocialmedia/screens/home.dart';
import 'package:minimalsocialmedia/screens/login.dart';
import 'package:minimalsocialmedia/screens/register.dart';
import 'package:provider/provider.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  runApp( ChangeNotifierProvider<ThemeNotifier>(
    create: (context)=>ThemeNotifier(),
    
    child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //getting theme light or black
      theme: Provider.of<ThemeNotifier>(context).getTheme(),
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(),
       builder: (context, snapshot){
        //it will handle if user is login then show home othrwise show the register page
        if(snapshot.hasData){
          return Home();
        }
return Register();

       })
      
      
      
      
       
    );}}