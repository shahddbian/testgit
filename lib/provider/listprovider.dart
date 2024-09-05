import 'package:flutter/cupertino.dart';
import 'package:todoapp/firsbaseutils.dart';
import '../model/task.dart';

class listprovider extends ChangeNotifier {
  List<Task> tasklist = [];
  var selectdate = DateTime.now();

  void getAllTasksfromFire(String uId) async {
    var qSnapshot = await firebaseUtils.getTaskCollection(uId).get();
    tasklist = qSnapshot.docs.map((doc) {
      return doc.data();
    }).toList();
    tasklist = tasklist.where((task) {
      return selectdate.day == task.dateTime.day &&
          selectdate.month == task.dateTime.month &&
          selectdate.year == task.dateTime.year;
    }).toList();

    tasklist.sort((task1, task2) {
      return task1.dateTime.compareTo(task2.dateTime);
    });
    notifyListeners(); // يجب استدعاء notifyListeners لتحديث الواجهة
  }

  void changedate(DateTime newDate, String uId) {
    selectdate = newDate;
    getAllTasksfromFire(uId);
  }
}
