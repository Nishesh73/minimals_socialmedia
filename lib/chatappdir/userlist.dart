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
      child: Container(
        child: ListTile(
          leading: Icon(Icons.person),
          title: Text(snap.get("currentEmail")),
        ),
      ),
    );
  }
}