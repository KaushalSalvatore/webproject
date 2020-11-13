import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:webproject/services/database.dart';

class TaskTile extends StatefulWidget {
  final bool isCompleted;
  final String task;
  final String documentId;
  TaskTile( this.isCompleted,this.task, this.documentId);

  @override
  _TaskTileState createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  String uId = "2jCJYvjCikSoczLXfCLbJoAbgvg1";
  TextEditingController taskEdittingControler = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Text(
            widget.task,
            style: TextStyle(
                color: widget.isCompleted ? Colors.black87 :
                Colors.black87.withOpacity(0.7),
                fontSize: 17,

            ),
          ),

          Spacer(),

          GestureDetector(
            onTap: () {

              _showDialog();
            },
            child: Icon(
                Icons.edit, size: 13, color: Colors.black87.withOpacity(0.7)
            ),
          ),
          SizedBox(width: 10,),
          GestureDetector(
            onTap: () {
              DatabaseServices().deleteTask(uId, widget.documentId);
            },
            child: Icon(
                Icons.close, size: 13, color: Colors.black87.withOpacity(0.7)
            ),
          )
        ],
      ),
    );
  }
  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Edit Task"),
          content: TextField(
            controller: taskEdittingControler,
            decoration: InputDecoration(
                hintText: "edit task"
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Icon(Icons.done, size: 13, color: Colors.black87.withOpacity(0.7)),
              onPressed: () {
                Map<String,dynamic> taskMap = {
                  "isCompleted" : !widget.isCompleted,
                  "task": taskEdittingControler.text,
                };

                DatabaseServices().updateTask(uId, taskMap, widget.documentId);
                Navigator.of(context).pop();
                taskEdittingControler.text = "";


              },
            ),
            new FlatButton(
              child: new Icon(Icons.close, size: 13, color: Colors.black87.withOpacity(0.7)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
