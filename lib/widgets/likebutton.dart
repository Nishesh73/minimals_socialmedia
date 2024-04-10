import 'package:flutter/material.dart';
class LikeButton extends StatelessWidget {
  bool isLiked;
  //to handle individual like separare ontap also required
  Function tap;
   LikeButton({super.key, required this.isLiked, required this.tap});
  //inorder to maintain seperate state for each post we need sepearate widget

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        tap();
        
      },

      child: isLiked?Icon(Icons.favorite): Icon(Icons.favorite_border),
    );
    
    
     
  }
}