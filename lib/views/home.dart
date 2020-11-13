import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:webproject/helper_functions/helper_functions.dart';
import 'package:webproject/services/database.dart';
import 'package:webproject/widgets/TaskTile.dart';

import 'package:webproject/widgets/widget.dart';


class Home extends StatefulWidget {
  String username;
  final String userEmail;
  Home({this.username, this.userEmail});

  @override
  _HomeState createState() => _HomeState();
}

String uId = "2jCJYvjCikSoczLXfCLbJoAbgvg1";

class _HomeState extends State<Home> {

  Stream taskStream;

  DatabaseServices databaseServices = new DatabaseServices();

  String date;
  TextEditingController taskEdittingControler = new TextEditingController();

  @override
  void initState() {
    var now = DateTime.now();
    date = "${HelperFunctions.getWeek(now.weekday)} ${HelperFunctions.getYear(now.month)} ${now.day}";

    databaseServices.getTasks(uId).then((val){ 
      taskStream = val;

      setState(() {});

    });

    super.initState();
  }


  Widget taskList(){

    return StreamBuilder(
      stream: taskStream,
      builder: (context, snapshot){
        return snapshot.hasData ?
        ListView.builder(

            padding: EdgeInsets.only(top: 16),
           itemCount: snapshot.data.documents.length,
            shrinkWrap: true,
            itemBuilder: (context, index){
              DocumentSnapshot data = snapshot.data.documents[index];
              log("message"+snapshot.data.documents.length.toString());
              log("documentID"+snapshot.data.documents[index].documentID.toString());
             log(data['task']);
              return TaskTile(
               // true,"data","check"
                data['isCompleted'],
                data['task'],
                snapshot.data.documents[index].documentID,
              );
            }) : Container();
      },
    );

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Widgets().mainAppar(),
      body: SingleChildScrollView(
        child: Container(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24,vertical: 32),
            width: 600,
            child: Column(
              children: [
              Text("My Day", style: TextStyle(
                fontSize: 18,
              ),),
              Text("$date"),
                Row(
                  children: [
                  Expanded(
                    child: TextField(
                      controller: taskEdittingControler,
                      decoration: InputDecoration(
                        hintText: "task"
                      ),
                      onChanged: (val){
                       // taskEdittingControler.text = val;
                        setState(() {

                        });
                      },
                    ),
                  ),
                  SizedBox(width: 6,),
                  taskEdittingControler.text.isNotEmpty ?
                  GestureDetector(
                    onTap: (){

                      Map<String, dynamic> taskMap = {
                        "task" : taskEdittingControler.text,
                        "isCompleted" : false
                      };

                      DatabaseServices().createTask(uId,taskMap);
                      taskEdittingControler.text = "";
                    },
                      child: Container(
                        padding: EdgeInsets
                          .symmetric(horizontal: 12, vertical: 5),
                          child: Text("ADD"))) : Container()
                ],),
                taskList()
            ],),
          ),
        ),
      ),
    );
  }
}



