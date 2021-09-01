import 'package:flutter/material.dart';
import 'package:todoapp/database/database-helper.dart';
import 'package:todoapp/database/models/task.dart';
import 'package:todoapp/widgets/todowidget.dart';
import 'package:todoapp/database/models/todo.dart' as TodoModel;

class TaskPage extends StatefulWidget {
  final Task? _task;

  TaskPage(Task? task) : _task = task;

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  int _taskId = 0;
  String _taskTitle = '';

  @override
  void initState() {
    if (widget._task != null) {
      var task = widget._task!.getTask();
      _taskId = task['id'];
      _taskTitle = task['title'];
    }
    super.initState();
  }

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
                    onSubmitted: (val) {
                      if (val != '') {
                        if (widget._task == null) {
                          databaseHelper.insertTask(new Task(title: val));
                        } else {
                          widget._task!.setTitle(val);
                          databaseHelper.insertTask(widget._task!);
                        }
                      }
                    },
                    controller: TextEditingController()..text = _taskTitle,
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
              Expanded(
                  child: FutureBuilder<List<TodoModel.Todo>>(
                initialData: [],
                future: databaseHelper.getTodo(_taskId),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          var _todoInstance = snapshot.data![index].getTodo();
                          return GestureDetector(
                            onTap: () {
                              var isDone = _todoInstance['isDone'];
                              if (isDone == 0) {
                                snapshot.data![index].setCompletion(1);
                              } else {
                                snapshot.data![index].setCompletion(0);
                              }
                              databaseHelper.insertTodo(snapshot.data![index]);
                              setState(() {});
                            },
                            child: Todo(_todoInstance['description'],
                                _todoInstance['isDone'] == 0 ? false : true),
                          );
                        });
                  } else {
                    return Text('No Assigned to do\'s');
                  }
                },
              )),
              Row(
                children: [
                  Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Color(0XFF868290), width: 1.5)),
                    margin: EdgeInsets.only(right: 16),
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: 'Enter to do item ..',
                          border: InputBorder.none),
                      onSubmitted: (val) {
                        if (val != '') {
                          TodoModel.Todo _todoInstance = new TodoModel.Todo(
                              description: val, isDone: 0, taskId: _taskId);
                          databaseHelper.insertTodo(_todoInstance);
                          setState(() {});
                        }
                      },
                    ),
                  )
                ],
              )
            ]),
            Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TaskPage(null)));
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
