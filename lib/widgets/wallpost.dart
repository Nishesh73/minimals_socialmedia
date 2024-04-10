import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:minimalsocialmedia/provider/themeprovider.dart';
import 'package:minimalsocialmedia/widgets/comment.dart';
import 'package:minimalsocialmedia/widgets/commentbutton.dart';

import 'package:minimalsocialmedia/widgets/likebutton.dart';
import 'package:provider/provider.dart';

class WallPost extends StatefulWidget {
  var snap;
  String postId;//each post postid
  var likeList;//each post like
   
   WallPost({super.key, required this.snap, required this.postId, required this.likeList});

  @override
  State<WallPost> createState() => _WallPostState();
}

class _WallPostState extends State<WallPost> {
  TextEditingController commentController = TextEditingController();
  

bool isLike = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   isLike = widget.likeList.contains(FirebaseAuth.instance.currentUser!.email);// it will fetch
  //  current like status whether the post is liked or not by currentuser

  //getting commentcount


 


  }

//toggle the button
toogleButton(){
  //at begining if i tap button i liked
  setState(() {
    isLike = ! isLike;
    
  });
  //making like unlike persist
  if(isLike){
    //if i like post then add my email inside likes field
    FirebaseFirestore.instance.collection("posts").doc(widget.postId).update({
      "likes": FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.email])
    });
  }
  else{
       FirebaseFirestore.instance.collection("posts").doc(widget.postId).update({
      "likes": FieldValue.arrayRemove([FirebaseAuth.instance.currentUser!.email])
    });
    
    setState(() {
      
    });

  }

}
  //posting comment to firebase
commentPostToFirebase()async{
  try {
    await  FirebaseFirestore.instance.collection("posts").doc(widget.postId)
  .collection("comments").add({
    "commentData": commentController.text,


  });

  setState(() {
    commentController.clear();
  });
  Navigator.pop(context);

    
  } catch (e) {
    
  }

}
//for to make popup dialogc
commentDialogBox(){ 
  return showDialog(context: context, builder: (context){


    return AlertDialog(content: Row(children: [
       Expanded(child: TextField(
          controller: commentController,
        )),
        IconButton(onPressed: (){

       commentPostToFirebase();
          


        }, icon: Icon(Icons.send))


    ],) ,);
  });



}

  @override
  Widget build(BuildContext context) {
    return  Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: Provider.of<ThemeNotifier>(context).darkTheme==true?Colors.black87: Colors.white,
          ),
          child: Column(
            children: [
              Row(
                children: [
              
              
              
                
                
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                    
                     Column(children: [LikeButton(isLiked: isLike,
                    //like button gesturedetector
                    tap: (){
                      toogleButton();
                       },
                    
                    ),
                    Text("${widget.likeList.length} likes")],
               ),
                 
              
              
              
                  ),
              
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: [
                        //here commentButton constructor accept the function via tap parameter
                        CommentButton(tap: (){
                         commentDialogBox();
                        },),
                        // IconButton(onPressed: (){
                        //   commentDialogBox();
                        // }, icon: Icon(Icons.comment)),

              StreamBuilder(stream:widget.postId.isNotEmpty? FirebaseFirestore.instance.collection("posts").doc(widget.postId).collection("comments").snapshots():null,
              //add a null check to elimiate exception from null
               builder: (context,asyncsnap){

              if(!asyncsnap.hasData){
                return Center(child: CircularProgressIndicator());
              }
                      
                return asyncsnap.data==null?Text("wait"):  Text("${asyncsnap.data!.docs.length}");
              
               }
                      
                     ) ],
                    
                    ),
                  ),
              
                  Column(
                    children: [
              
              
                     Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(widget.snap.get("userPost")),
                    ),
                    
                        Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("log in as ${widget.snap.get("userEmail")}",
                      style: TextStyle(color: Colors.grey),
                      
                      ),
               ) ,
                   
                   
                   
                   ],
              
              
                   
            
              
              
                
               ) ]
              ),

              // fetching the commentdata using postid
              StreamBuilder(stream: FirebaseFirestore.instance.collection("posts").doc(widget.postId).collection("comments").snapshots(),
               builder: (context,asyncsnap){

              if(!asyncsnap.hasData){
                return Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                shrinkWrap: true,
                itemCount: asyncsnap.data!.docs.length,
                itemBuilder: (context, index){

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Comment(commenData: asyncsnap.data!.docs[index].get("commentData"),),
                  );

                  

                });



               })

               
            ],
          ),
        );
  }
}