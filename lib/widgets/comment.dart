import 'package:flutter/material.dart';
import 'package:minimalsocialmedia/provider/themeprovider.dart';
import 'package:provider/provider.dart';
class Comment extends StatelessWidget {
  String commenData;
  Comment({super.key, required this.commenData});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Provider.of<ThemeNotifier>(context).darkTheme==true?Colors.black87: const Color.fromARGB(255, 241, 239, 239)
      ),

      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(commenData),
      ),
    );
  }
}