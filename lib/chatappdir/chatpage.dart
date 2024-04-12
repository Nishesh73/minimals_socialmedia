import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
class Chatpage extends StatelessWidget {
  //in any chat application each message associated with 1. the sender who sent it
  //and 2. content of message itself
  String message;
  String senderId;
  String senderEmail;
  Timestamp timestamp;// to receive data of timeStamp type
  // DateFormat.yMMMEd().format(DateTime.now());-- gives date informatio
  //DateFormat.jms().format(now);--give time information
  //DateTime and TimeStamp both gives the same value date and time 


  
  
   Chatpage({super.key, required this.message, required this.senderId, required this.senderEmail, required this.timestamp});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: senderId==FirebaseAuth.instance.currentUser?.uid?MainAxisAlignment.end : MainAxisAlignment.start,
        
        children: [
          Column(
            children: [
              Text(senderEmail, style: TextStyle(color: Colors.blue.withOpacity(.8)),),
              Container(
                decoration: BoxDecoration(
                  color: senderId==FirebaseAuth.instance.currentUser?.uid? Color.fromARGB(255, 4, 72, 127): Color.fromARGB(255, 220, 204, 204),
                  borderRadius: BorderRadius.circular(10)
                ),
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * .7
                  //meaning max width it can occupy is 70 % if message content width less than 70 % it will shrink
                  //and take the space it required no flexible widget is required however in the case 
                  //width: MediaQuery.of(context).size.width * .7 property it will always take 70 % regardless 
                  //of message content width. so to get flexible type of feature we have to use flexible widget
                  //if we want to use width: property instead, maxwidth: property
                  
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(message, style: TextStyle(color: senderId==FirebaseAuth.instance.currentUser?.uid? Colors.white:Colors.black),),
                      //dart will convert any datat type to string representation if we include using string interpolation
                      Text("${DateFormat.yMMMEd().format(timestamp.toDate())} At ${DateFormat.jms().format(timestamp.toDate())} "),
                      // Text(DateFormat.jms().format(timestamp.toDate())),
                    ],
                  ),
                ),
              ),
              
            ],
          ),
      
      
        ],),
    );
   
  

  }}
   