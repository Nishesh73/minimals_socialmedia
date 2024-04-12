import 'package:flutter/material.dart';

class UserList extends StatelessWidget {
  var snap;
  Function tapF;
   UserList({super.key, required this.snap, required this.tapF});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:(){
        tapF();//calling function basically calling (){} 
      } ,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          decoration: BoxDecoration(color: Color.fromARGB(135, 231, 205, 205),
          borderRadius: BorderRadius.circular(5),
          
          ),
          //greatest app developer
          //greatest communicator
        
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: Icon(Icons.person),
              title: Text(snap.get("currentEmail")),
            ),
          ),
        ),
      ),
    );
  }
}