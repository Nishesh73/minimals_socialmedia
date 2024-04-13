// import 'dart:js';this is for web

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minimalsocialmedia/chatappdir/chathome.dart';
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
  
   MyApp({super.key});

  // This widget is the root of your application.
  //never give up best app developer on the planet
  @override
  Widget build(BuildContext context) {
    return 

         MaterialApp(
        ////getting theme light or black
          theme: Provider.of<ThemeNotifier>(context).getTheme(),//it will return themedata
    // return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(),
         builder: (context, snapshot){
        //  //it will handle if user is login then show home othrwise show the register page
         // //if any type of authdata will change then stream will emit new auth data, Streambuilder
          
        //  // responsible for rebuilding buil method, on the basis of that  ChatHome and Register page will display, if there
         // //is no auth data Register page will display otherwise ChatHome page will display
          
          if(snapshot.hasData){
            // return ChatHome();
            return Home();
          }


      return Register();
      
         })
        
        //prompt - means encourage(like push)
        
        
         
      );


      //  } ,

       
    // );


    }
    
     }