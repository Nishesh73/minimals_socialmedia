import 'package:flutter/material.dart';

class Cbutton extends StatelessWidget {
  String path;
   Cbutton({super.key, required this.path});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(color: Colors.white,
        borderRadius: BorderRadius.circular(7),
        
        ),
      
        child: Padding(
          padding: const EdgeInsets.all(9.0),
          child: Image.asset(path,
          width: 20,
          height: 20,
          
          
          ),
        ),
      ),
    );
  }
}