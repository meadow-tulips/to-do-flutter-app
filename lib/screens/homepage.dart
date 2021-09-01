import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/database/database-helper.dart';
import 'package:todoapp/screens/taskpage.dart';
import 'package:todoapp/widgets/taskcardwidget.dart';
import 'package:todoapp/database/models/task.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  DatabaseHelper _dbHelper = DatabaseHelper();

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
                              child: FutureBuilder<List<Task>>(
                                  initialData: [],
                                  future: _dbHelper.getAllTasks(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return ListView.builder(
                                        itemCount: snapshot.data!.length,
                                        itemBuilder: (context, index) {
                                          var _taskInstance =
                                              snapshot.data![index].getTask();
                                          return GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          TaskPage(snapshot
                                                                  .data![
                                                              index]))).then(
                                                  (value) => setState(() {}));
                                            },
                                            child: Taskcard(
                                                _taskInstance['title'],
                                                _taskInstance['description']),
                                          );
                                        },
                                      );
                                    } else {
                                      return Center(child: Text('No Lists'));
                                    }
                                  })),
                        ]),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TaskPage(null)))
                                .then((value) => setState(() {}));
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
