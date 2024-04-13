import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:minimalsocialmedia/chatappdir/chatroom.dart';
import 'package:minimalsocialmedia/chatappdir/userlist.dart';
import 'package:minimalsocialmedia/screens/register.dart';
class ChatHome extends StatefulWidget {
  const ChatHome({super.key});

  @override
  State<ChatHome> createState() => _ChatHomeState();
}

class _ChatHomeState extends State<ChatHome> {

//handling logout opeartion
  logOut()async{
    //streambuilder's auth properties automatically detect any change thus,
    //no need to use setstate
    try {
      await FirebaseAuth.instance.signOut();
      //force to navigate into register page if it is not self directed
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Register()));
      
    } catch (e) {
      
    }
    
   


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("chat home") ,

        actions: [
          IconButton(onPressed: (){

            logOut();
          }, icon: Icon(Icons.logout))
        ],
      ),

      body: StreamBuilder(stream: FirebaseFirestore.instance.collection("users").where("uid", isNotEqualTo: FirebaseAuth.instance.currentUser?.uid).snapshots(),
       builder: (context, asynsnap){
        if(asynsnap.connectionState==ConnectionState.waiting){
          return Center(child: CircularProgressIndicator());
        }
        if(!asynsnap.hasData||asynsnap.data==null){
          return Text("no data is found");

        }
        return ListView.builder(
          shrinkWrap: true,
          itemCount: asynsnap.data?.docs.length,//it will handle null value gracefully
          //in some case we have to use ?. and ??
          //scenario if you want to give default value then use ?? otherwise ?.enough will
          //handle null value eg. asynsnap.data?.docs.length??1 here you want to give default
          //value 1 that's why use ??, otherwise don't need to give asynsnap.data?.docs.length??null
          //as asynsnap.data?.docs.length??null and asynsnap.data?.docs.length both handle null value error 
          // but generally if you think
          //given value may be null use ??, otherwise you may think given object
          //may be null in that scenario use ?.
          itemBuilder: (context, index){
            var snap = asynsnap.data?.docs[index];//if value is null then docs property not call

            return UserList(
              snap: snap,
              tapF: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatRoom(
                  receiverId: snap?.get("uid"),//it will handle null error during runtime


                )));
              },
            
            );


          });

       }),
      
      
    );
  }
}