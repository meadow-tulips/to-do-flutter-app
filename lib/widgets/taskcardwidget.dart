import 'package:flutter/material.dart';

class Taskcard extends StatefulWidget {
  final String ? title;
  final String ? desc;
  const Taskcard([String ? title, String ? desc]): title = title, desc = desc;

  @override
  _TaskcardState createState() => _TaskcardState();
}

class _TaskcardState extends State<Taskcard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Text(widget.title ?? 'No Title Provided', 
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Color(0XFF211551),
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0,
                ),
              ),
            Padding(padding: EdgeInsets.only(top: 10),
              child:  Text(widget.desc != null && widget.desc!.isNotEmpty ? widget.desc! : "No Description Provided",
                style: TextStyle(
                  color: Color(0XFF868290),
                  fontWeight: FontWeight.normal,
                  height: 1.5,
                  fontSize: 16.0,
                ),
              ),
            )
      ],)
      ,
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 32
      ),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.white),
      width: double.infinity,
    );
  }
}