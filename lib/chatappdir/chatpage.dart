import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
class Chatpage extends StatelessWidget {
  //in any chat application each message associated with 1. the sender who sent it
  //and 2. content of message itself
  String message;
  String senderId;
  
  
   Chatpage({super.key, required this.message, required this.senderId});

  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: senderId==FirebaseAuth.instance.currentUser?.uid?MainAxisAlignment.end : MainAxisAlignment.start,
      
      children: [
        Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * .7
            //meaning max width it can occupy is 70 % if message content width less than 70 % it will shrink
            //and take the space it required no flexible widget is required however in the case 
            //width: MediaQuery.of(context).size.width * .7 property it will always take 70 % regardless 
            //of message content width. so to get flexible type of feature we have to use flexible widget
            //if we want to use width: property instead, maxwidth: property
            
          ),
          child: Text(message),
        ),


      ],);
   
  

  }}
   