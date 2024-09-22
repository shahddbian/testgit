import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todoapp/model/dataClass.dart';
import 'package:todoapp/model/task.dart';

class firebaseUtils {
  static CollectionReference<Task> getTaskCollection(String uId) {
    return getUserCollection()
        .doc(uId)
        .collection(Task.collectionName)
        .withConverter<Task>(
            fromFirestore: ((snapshot, options) =>
                Task.fromFireStore(snapshot.data()!)),
            toFirestore: (task, options) => task.toFirestore());
  }

  static Future<void> addTasktoFireStore(Task task, String uId) async {
    var taskCollection = getTaskCollection(uId);
    var taskDocRef = taskCollection.doc();
    task.id = taskDocRef.id;
    await taskDocRef.set(task);
  }

  static Future<void> editTaskFromFireStore(Task task, String uId) async {
    await getTaskCollection(uId).doc(task.id).update(task.toFirestore());
  }

  static Future<void> deletetaskfromfire(Task task, String uId) {
    return getTaskCollection(uId).doc(task.id).delete();
  }

  static CollectionReference<Myuser> getUserCollection() {
    return FirebaseFirestore.instance
        .collection(Myuser.collectionName)
        .withConverter<Myuser>(
            fromFirestore: ((snapshot, options) =>
                Myuser.Fromfirestore(snapshot.data()!)),
            toFirestore: ((user, options) => user.tofiesStore()));
  }

  static Future<void> addUsertofire(Myuser myuser) {
    return getUserCollection().doc(myuser.id).set(myuser);
  }

  static Future<Myuser?> readUserfromfire(String uId) async {
    var snapshot = await getUserCollection().doc(uId).get();
    return snapshot.data();
  }
}