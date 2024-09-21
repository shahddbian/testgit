import 'package:flutter/cupertino.dart';
import 'package:todoapp/firsbaseutils.dart';
import '../model/task.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class listprovider extends ChangeNotifier {
  List<Task> tasklist = [];
  var selectdate = DateTime.now();

  Future<void> getAllTasksfromFire(String uId) async {
    var qSnapshot = await firebaseUtils.getTaskCollection(uId).get();
    tasklist = qSnapshot.docs.map((doc) => doc.data()).toList();
    tasklist = tasklist.where((task) {
      return selectdate.day == task.dateTime.day &&
          selectdate.month == task.dateTime.month &&
          selectdate.year == task.dateTime.year;
    }).toList();

    tasklist.sort((task1, task2) => task1.dateTime.compareTo(task2.dateTime));
    notifyListeners();
  }

  Future<void> updateTask(Task task, String uId, DateTime oldDate) async {
    var taskCollection = firebaseUtils.getTaskCollection(uId);
    var oldTasksSnapshot =
        await taskCollection.where('dateTime', isEqualTo: oldDate).get();

    for (var doc in oldTasksSnapshot.docs) {
      var taskDoc = doc.data();
      if (taskDoc.id == task.id) {
        await doc.reference.delete();
        break;
      }
    }
    await firebaseUtils.editTaskFromFireStore(task, uId);
    await getAllTasksfromFire(uId);
    notifyListeners();
  }

  void changedate(DateTime newDate, String uId) {
    selectdate = newDate;
    getAllTasksfromFire(uId);
  }
}
