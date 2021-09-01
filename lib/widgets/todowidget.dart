import 'package:flutter/material.dart';

class Todo extends StatefulWidget {
  final String? _text;
  final bool _isDone;

  const Todo(String? text, bool isDone)
      : _text = text,
        _isDone = isDone;

  @override
  _TodoState createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Row(
        children: [
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
                border: Border.all(color: Color(0XFF868290), width: 1.5)),
            margin: EdgeInsets.only(right: 16),
            child: widget._isDone
                ? Image(
                    image: AssetImage('assets/images/checkbox-mark.png'),
                  )
                : null,
          ),
          Flexible(
              child: Text(
            widget._text ?? "No to-do item",
            style: TextStyle(
                color: widget._isDone ? Color(0XFF211551) : Color(0XFF868290),
                fontWeight:
                    widget._isDone ? FontWeight.bold : FontWeight.normal,
                fontSize: 18),
          ))
        ],
      ),
    );
  }
}
