import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:minimalsocialmedia/chatappdir/chatpage.dart';
class ChatRoom extends StatefulWidget {
  String receiverId;

  ChatRoom({super.key, required this.receiverId});

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}



class _ChatRoomState extends State<ChatRoom> {
  TextEditingController chatController = TextEditingController();
  var chatRoomId;

  

  

//fetching the chatroomId at the begining


  sendMessage()async{
  
    try {
        //storing message in firebase
    await FirebaseFirestore.instance
    .collection("chats")
    .doc(chatRoomId)
    .collection("message")
    .add({
      "message": chatController.text,
      "timeStamp": DateTime.now(),
      "senderId": FirebaseAuth.instance.currentUser?.uid,


    });
    setState(() {
      chatController.clear();
    });
      
    } catch (e) {
      
    }
  




  }
//creating chatroomid
@override
  void initState() {
    // TODO: implement initState
    super.initState();
      //creating chatroom
    var currentUseId = FirebaseAuth.instance.currentUser?.uid;
    List ids = [widget.receiverId, currentUseId];
    ids.sort();//it will sort id in ascending order
    chatRoomId = ids.join("-");//after sort put - bet two id eg a-b, suppose a and b are id
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat room"),
      ),
      body: Column(
        children: [
          Expanded(
            child:  StreamBuilder(stream: FirebaseFirestore.instance.collection("chats").doc(chatRoomId??null).collection("message").orderBy("timeStamp", descending: false).snapshots(),
            //if i donot use order by property then message will generate randomly or inconsistently
             builder: (context, asnapshot) {
              print("chatroom id is $chatRoomId");
              if(asnapshot.connectionState==ConnectionState.waiting){
                return Center(child: CircularProgressIndicator());
              }
              if(!asnapshot.hasData||asnapshot.data==null){
                return Text("no message");
            
              }
              return Padding(
                //padding is directly applied to immediate child here for Entire Listview.builder
                //padding is applied
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  
                  shrinkWrap: true,
                  itemCount: asnapshot.data?.docs.length,
                  itemBuilder: (context, index){
                
                    // return Chatpage(message: message);
                            
                  return Chatpage(
                    message: asnapshot.data?.docs[index].get("message"),
                    senderId: asnapshot.data?.docs[index].get("senderId"),
                  
                  
                  );
                            
                            
                }),
              );
               
             },),
          ),
          Container(
            child: Row(children: [
              Expanded(child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: chatController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    fillColor: Color.fromARGB(255, 235, 197, 197),
                    filled: true,
                  ),
                
                ),
              )),
              IconButton(onPressed: (){
                sendMessage();
          
              }, icon: Icon(Icons.arrow_upward_rounded))
            ],),
          ),
        ],
      )

  
    );
  }
}