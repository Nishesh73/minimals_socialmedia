import 'package:flutter/material.dart';
class CommentButton extends StatelessWidget {
  Function tap;
  
   CommentButton({super.key, required this.tap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        tap();//function call
      },
      
      child: Icon(Icons.comment),
    );
  }
}