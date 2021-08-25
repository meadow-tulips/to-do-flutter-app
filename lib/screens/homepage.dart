import 'package:flutter/material.dart';
import 'package:todoapp/screens/taskpage.dart';
import 'package:todoapp/widgets/taskcardwidget.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
                width: double.infinity,
                color: Color(0xFFF6F6F6),
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                child: Stack(
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 32),
                            child: Image(
                              image: AssetImage('assets/images/logo@1X.png'),
                            ),
                          ),
                          Expanded(
                              child: ListView(
                            children: [
                              Taskcard("Get Started !",
                                  "Hello user. Welcome to our To do Application ! One can add a whole bunch of items in their list of everyday to do's."),
                              Taskcard(),
                              Taskcard(),
                              Taskcard(),
                              Taskcard()
                            ],
                          )),
                        ]),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TaskPage()));
                          },
                          child: Image(
                            image: AssetImage('assets/images/add_icon.png'),
                            height: 50,
                            width: 50,
                          )),
                    )
                  ],
                ))));
  }
}
