import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices {

  uploadUserInfo(String userId, Map userMap){
    FirebaseFirestore.instance.collection("users")
        .doc(userId)
        .set(userMap)
        .catchError((e){
      print(e.toString());
    });
  }

  updateTask(String userId, Map taskMap, String documentId){
    FirebaseFirestore.instance.collection("users")
        .doc(userId)
        .collection("tasks")
        .doc(documentId)
        .set(taskMap);
  }

  createTask(String userId, Map taskMap){
    FirebaseFirestore.instance.collection("users")
        .doc(userId)
        .collection("tasks")
        .add(taskMap);
  }

  getTasks(String userId) async {
    return await FirebaseFirestore.instance.collection("users")
        .doc(userId)
        .collection("tasks")
        .snapshots();
        }

  deleteTask(String userId,String documentId){
    FirebaseFirestore.instance.collection("users")
        .doc(userId)
        .collection("tasks")
        .doc(documentId)
        .delete()
        .catchError((e){
      print(e.toString());
    });
  }

}