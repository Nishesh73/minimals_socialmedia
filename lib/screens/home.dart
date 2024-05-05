

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:minimalsocialmedia/provider/themeprovider.dart';
import 'package:minimalsocialmedia/screens/register.dart';
import 'package:minimalsocialmedia/widgets/likebutton.dart';
import 'package:minimalsocialmedia/widgets/wallpost.dart';
import 'package:provider/provider.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _postController = TextEditingController();


  
  //post data to firestore
   postToFirestore()async{
    try {
      
    DocumentReference documentReference = await FirebaseFirestore.instance.collection("posts").add({
      "userEmail": FirebaseAuth.instance.currentUser?.email,
      "userPost":_postController.text,
      "likes":[],
      "postId":"",
      "time": DateTime.now()
      
      
    });
    //now i got postid generated randomly i can update
    await documentReference.update({
      "postId": documentReference.id,//this is the random id generate by add 


    });

    setState(() {
      _postController.clear();
    });
      
    } catch (e) {
      print(e);
      
    }
 


   }
  
  logOut()async{
    //to handle error
    try {
        await FirebaseAuth.instance.signOut();
        //force to navigate into register if somethign went wrong
        Navigator.push(context as BuildContext, MaterialPageRoute(builder: (context)=>Register()));
      
    } catch (e) {
      print(e);
      
    }
  

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //whole body bg without appbar
      backgroundColor:Provider.of<ThemeNotifier>(context).darkTheme==true?Colors.black87: Color.fromARGB(255, 253, 246, 246),

      appBar: AppBar(
        automaticallyImplyLeading: false,
       backgroundColor: Provider.of<ThemeNotifier>(context).darkTheme==true?Colors.black87: Color.fromRGBO(250, 242, 242, 1),
        title: Text("Wall post"),
        centerTitle: true,
        actions: 
        
        [
          Switch(value: Provider.of<ThemeNotifier>(context).darkTheme , onChanged: (_){
            Provider.of<ThemeNotifier>(context, listen: false ).toogleTheme();

          }),
          
          IconButton(onPressed: (){

          logOut();
        }, icon: Icon(Icons.logout))],
      ),

      body: Column(children: [
      //best app developer on the planet
      
      Expanded(
        //limit to 5 documents only randomly
        child: StreamBuilder(stream: FirebaseFirestore.instance.collection("posts")
        // .limit(5)
         .orderBy("time", descending: true)
        .snapshots(),
        //document path-- means document's path/ghar--here postId, sometime docId
         builder: (context, asyncsnap){
          if(asyncsnap.connectionState==ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          }
          if(!asyncsnap.hasData||asyncsnap.data==null||asyncsnap.data!.docs.isEmpty){
            return Center(child: Text("Be the first one to post!"));
          }
        
          if(asyncsnap.hasError){
            return Text("something is wrong");
          }
        
          return Padding(

            //padding is very important here it will make sure that there is a
            //inner space bet the parent widget expanded with list which avoid
            //rendering error in runtime.
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: asyncsnap.data!.docs.length,
                  itemBuilder: (context, index){
                    var snap = asyncsnap.data!.docs[index];
                    //make separate widget like this to handle the state
                    var postId = snap.get("postId");
                    if(!postId.isEmpty || postId!=null){
                      //postId.isEmpty-check for empty string ""(no character), postId=null,
                      // means postId//contain no value, null and empty are different
                      // null- mean there's nothing here,""- there is something here but empty.eg string s = ""-is
                     //  still string, but it is empty,List l = [] still list , but empty list;
                    return WallPost(snap: snap,
                    postId: snap.get("postId"),
                    likeList: snap.get("likes")??[],
                    
                    );
                    }
               else     return Container();
                  
                    
                    
                  }),
          );
        
        
        
        
         }),
      ),
       
      
        Container(
          alignment: Alignment.bottomCenter,
          child: Row(children: [
            Expanded(child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _postController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Provider.of<ThemeNotifier>(context).darkTheme==true?Color.fromARGB(221, 187, 176, 176): Color.fromARGB(255, 191, 186, 186),
                  filled: true,
                ),
              ),
            )),
            IconButton(onPressed: (){
              postToFirestore();
          
          
            }, icon: Icon(Icons.arrow_circle_up))
          ],),
        )
      
      ],),
    );
  }
}