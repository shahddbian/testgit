import 'package:flutter/cupertino.dart';
import 'package:todoapp/model/dataClass.dart';

class Userprovider extends ChangeNotifier {
  Myuser? currentUser;

  void updateUser(Myuser newUser) {
    currentUser = newUser;
    notifyListeners();
  }
}
