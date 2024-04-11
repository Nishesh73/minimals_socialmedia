import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:minimalsocialmedia/chatappdir/chathome.dart';
import 'package:minimalsocialmedia/provider/themeprovider.dart';
import 'package:minimalsocialmedia/screens/home.dart';
import 'package:minimalsocialmedia/screens/register.dart';
import 'package:minimalsocialmedia/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {

   SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
 bool circularProgress = false;
    TextEditingController _emailController = TextEditingController();
  
  TextEditingController _passwordController = TextEditingController();

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


  login()async{
    try {
        setState(() {
      circularProgress = true;
    });
      
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailController.text, password: _passwordController.text);
    //data for chat app
      await  FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser?.uid??null).set({
      "currentEmail":FirebaseAuth.instance.currentUser?.email??null,
      "uid":FirebaseAuth.instance.currentUser?.uid??null,
     //here since i initially created doc while signup now it will only update
     //that doc means set method 1.create as well as 2. update document
    });
     setState(() {
      circularProgress = false;
    });
      
     showDialogBox(context, "successfully login");
     //to hide the dialogbox
     Navigator.pop(context);
    //  Future.delayed(Duration(seconds: 5), (){
    //   //disappear the dialog after login
    //   Navigator.pop(context);
    //  });
     
     //using delay method
    // await Future.delayed(Duration(milliseconds: 5));//no need of using await keyword befor future.delayed
    // we use await inorder a wait process which complet in the future, but Future.delayed(), itself
    //return future, which completed sometime in future



      
     
    
     Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatHome()));
     //learn 1. then property 2. delay method
        
  
      
    }

    // on FirebaseAuthException catch(e){
    //   //exception related with firebase auth all exception

    //   print("firebase exception is $e");

    // }
    
    
     catch (e) {
       setState(() {
      circularProgress = false;
    });
      
       showDialogBox(context, e.toString());
      print("exception is $e");
      
    }
  
      
    
      
    

    



  }

  @override
  Widget build(BuildContext context) {
    //greatest ui of all time
    return Scaffold(
      backgroundColor:Provider.of<ThemeNotifier>(context).darkTheme==true?Colors.black87: const Color.fromARGB(255, 224, 189, 189),
      
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          
        
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Icon(Icons.lock, size: 60,),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: Text("Welcome back you have been missed"),
            ),
            SizedBox(height: 15,),
           //take only space available not more than that
         
          
              
                Flexible(child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextField(
                    controller: _emailController,
                      style: TextStyle(color:Provider.of<ThemeNotifier>(context).darkTheme==true?Colors.black87: const Color.fromARGB(255, 224, 189, 189) ),
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
                    obscureText: true,
                      style: TextStyle(color:Provider.of<ThemeNotifier>(context).darkTheme==true?Colors.black87: const Color.fromARGB(255, 224, 189, 189) ),
                    decoration: InputDecoration(
                      hintText: "Password",
                       hintStyle: TextStyle(color: Provider.of<ThemeNotifier>(context).darkTheme==true?Colors.black87:Colors.black),
                      filled: true,
                      fillColor: Colors.white,
                      border: InputBorder.none,
                    ),
                                   ),
                 )),

                //  Padding(
                //    padding: const EdgeInsets.symmetric(horizontal: 8.0,
                //    vertical: 5),

                //    child: GestureDetector(
                //     onTap: () {
                //       print("forgot button tapped");
                //     },
                //      child: Container(
                //       alignment: Alignment.centerRight,
                //       child: Text("Forgot password?"),
                //      ),
                //    ),
                   
                //    ),
                    SizedBox(height: 10,),
                   Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                   child: GestureDetector(
                    onTap: (){
                      login();
                    },
                     child:circularProgress?Center(child: CircularProgressIndicator()): Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        
                        color: Colors.black),
                      
                      width: double.maxFinite,
                      height: 45,
                      child: Center(child: Text("Sign in",
                      style: TextStyle(color: Colors.white),
                      )),
                     
                     ),
                   ),
                   
                   ),
                   SizedBox(height: 20,),

                            Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Text("Not a member yet ?"),
                    SizedBox(width: 4,),
                      GestureDetector(
                        onTap: (){
                               Navigator.push(context, MaterialPageRoute(builder: (context) => Register()));
                        },
                        
                        child: Text("Register now", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),)),
 ],),

                
                  


              
                
              
              
           
        
        ],),
      ),


    );





  }
}
