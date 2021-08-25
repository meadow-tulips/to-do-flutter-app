import 'package:flutter/material.dart';
import 'package:todoapp/widgets/todowidget.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Stack(
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                children: [
                  Padding(
                      padding: EdgeInsets.only(right: 24),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Image(
                            image: AssetImage(
                                'assets/images/back_arrow_icon@1X.png')),
                      )),
                  Expanded(
                      child: TextField(
                    decoration: InputDecoration(
                        hintText: 'Enter task name', border: InputBorder.none),
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0XFF211551)),
                  ))
                ],
              ),
              Padding(
                  padding: EdgeInsets.only(
                    bottom: 12,
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: 'Enter description for the task',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 24)),
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 14),
                  )),
              Todo('create your first task', true),
              Todo('create your second task', false),
            ]),
            Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => TaskPage()));
                    },
                    child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Color(0XFFFE3572),
                        ),
                        child: Image(
                          image: AssetImage('assets/images/delete_icon@1X.png'),
                        ))))
          ],
        ),
      )),
    );
  }
}
