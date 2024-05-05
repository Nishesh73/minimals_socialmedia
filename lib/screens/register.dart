// import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:minimalsocialmedia/chatappdir/chathome.dart';
import 'package:minimalsocialmedia/provider/themeprovider.dart';
import 'package:minimalsocialmedia/screens/home.dart';
import 'package:minimalsocialmedia/screens/login.dart';
import 'package:provider/provider.dart';
class Register extends StatefulWidget {

   Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool circularProgress = false;

  TextEditingController _emailController = TextEditingController();

    TextEditingController _passwordController = TextEditingController();

      TextEditingController _confirmPasswordController = TextEditingController();

      showDialogBox(BuildContext context, String e)async{
        //although i am not using await here, async represent asynchrnous operation it will take
        //sometime to complete operation in the future
        return showDialog(context: context, builder: (context){
          return AlertDialog(
                 shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5)
          
            ),
            content: Text("$e"),

          );


        });
      }
      

   signUp(BuildContext context)async{
    //if some error occured regarding auth go do clean, pub get then restart vs code
    setState(() {
      circularProgress = true;
    });
    if(_passwordController.text!=_confirmPasswordController.text){
         setState(() {
     circularProgress = false;
   });
      showDialogBox(context, "match the password with confirm password");

      return;
    }

    try {
      //showing circular progress indicator

    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _emailController.text, password: _passwordController.text);
    //storing user for chat app
    FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser?.uid??null).set({
      "currentEmail":FirebaseAuth.instance.currentUser?.email??null,
      "uid":FirebaseAuth.instance.currentUser?.uid??null,
      //if currentuser is not null ,uid property will run by ?. operator, suppose currentuser is
      //null then entire expression will be null, handle by ?? operator. dart compiler and flutter
      //compiler will handle this without causing any error
    });
    setState(() {
     circularProgress = false;
   });
     //showing dialog box
   showDialogBox(context, "successfully signup");
   //hiding dialog box
   Navigator.pop(context);


  //  Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatHome()));
   Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
   //hiding circular progress
  
 
  
      
    }
    //will handle all the possible error regarding the firebase auth
    // on FirebaseAuthException catch(e){
    //   showDialogBox(context, e.toString());
    //   print("firebase exception is $e");
    // }
    
    //will handle all error, along with firebaseauthexception also
     catch (e) {
         setState(() {
     circularProgress = false;
   });
      showDialogBox(context, e.toString());
      
    }



  



   }

  @override
  Widget build(BuildContext context) {
      //greatest ui of all time
    return Scaffold(
      backgroundColor:Provider.of<ThemeNotifier>(context).darkTheme==true?Colors.black87: const Color.fromARGB(255, 224, 189, 189),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              
            
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Icon(Icons.lock, size: 60,),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: Text("We will create account for you"),
                ),
                SizedBox(height: 15,),
               //take only space available not more than that
             
              
                  
                    Flexible(child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextField(
                         controller: _emailController,
                         style: TextStyle(color:Provider.of<ThemeNotifier>(context).darkTheme==true?Colors.black87: Colors.black ),
                        decoration: InputDecoration(
                          
                          hintText: "Email",
                          hintStyle: TextStyle(color: Provider.of<ThemeNotifier>(context).darkTheme==true?Colors.black87:Colors.black),
                          filled: true,
                          fillColor: Colors.white,
                          border: InputBorder.none,
                        ),
                      ),
                    )),
                    SizedBox(height: 10,),
                    //password
                     Flexible(child: Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 8.0),
                       child: TextField(
                        controller: _passwordController ,
                          style: TextStyle(color:Provider.of<ThemeNotifier>(context).darkTheme==true?Colors.black87: Colors.black ),
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Password",
                           hintStyle: TextStyle(color: Provider.of<ThemeNotifier>(context).darkTheme==true?Colors.black87:Colors.black),
                          filled: true,
                          fillColor: Colors.white,
                          border: InputBorder.none,
                        ),
                                       ),
                     )),
            
                        SizedBox(height: 10,),
                    //password
                     Flexible(child: Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 8.0),
                       child: TextField(
                        controller: _confirmPasswordController ,
                        obscureText: true,
                          style: TextStyle(color:Provider.of<ThemeNotifier>(context).darkTheme==true?Colors.black87: Colors.black ),
                        decoration: InputDecoration(
                          hintText: "Confirm Password",
                           hintStyle: TextStyle(color: Provider.of<ThemeNotifier>(context).darkTheme==true?Colors.black87:Colors.black),
                          filled: true,
                          fillColor: Colors.white,
                          border: InputBorder.none,
                        ),
                                       ),
                     )),
            
            
                
                   
                        SizedBox(height: 10,),
                       Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 8.0),
                       child: GestureDetector(
                        onTap: (){
                          signUp(context);
                          
                        },
                         child: circularProgress?Center(child: CircularProgressIndicator()): Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            
                            color: Colors.black),
                          
                          width: double.maxFinite,
                          height: 45,
                          child: Center(child: Text("Sign up",
                          style: TextStyle(color: Colors.white),
                          )),
                         
                         ),
                       ),
                       
                       ),
                       SizedBox(height: 20,),
                       Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Text("Already signup?"),
                        SizedBox(width: 4,),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => SignIn()));
                            },
                            
                            child: Text("Signin now", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),)),
             ],),
            
                   
                        
                       
                        
                    
                      
                      
            
            
                  
                    
                  
                  
               
            
            ],),
          ),
        ),
      ),


    );

  }
}