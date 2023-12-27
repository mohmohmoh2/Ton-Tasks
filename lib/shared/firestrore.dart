import 'package:cloud_firestore/cloud_firestore.dart';
import 'constants.dart';

class FirestoreService {
  // get collection of notes
  final CollectionReference tasks =
      FirebaseFirestore.instance.collection('tasks');

  Future getUserData() {
    return FirebaseFirestore.instance.collection('users').doc(auth.currentUser?.uid).get();
  }

  // Add One Time Task
  Future<void> addNote({required String title, required date, required String desc,}) {
    var d = date.split('-');
    var year = d[0],month = d[1], day = d[2];
    return tasks.add({
      'title': title,
      'description': desc,
      'year': year,
      'month': month,
      'day': day,
      'status': 'new',
      'repeatType': 'OneTime',
      'lastDate': Timestamp.now(),
      'userId': auth.currentUser?.uid,
    });
  }

  // Add User data
  Future<void> addUser({required id, required email}) {
    return FirebaseFirestore.instance.collection('users').doc(id).set({
      'id': id,
      'name': 'year',
      'email': email,
      'img': 'img',
      'addedTasks': 0,
      'addDate': Timestamp.now(),
    });
  }

  // Update Image
  Future<void> updateimg({required newimg, required id}) {
    return FirebaseFirestore.instance.collection('users').doc(id).update({
      'img': newimg,
    });
  }

  Future<void> updateName({required newName, required id}) {
    return FirebaseFirestore.instance.collection('users').doc(id).update({
      'name': newName,
    });
  }

  updateTasksNumber(context) {
    var newcount = userData['addedTasks'] + 1;
    FirebaseFirestore.instance.collection('users').doc(auth.currentUser?.uid).update({
      'addedTasks': newcount,
    }).then((value) => getUserData());
  }

  //Add yearly Task
  Future<void> addTaskYearly({required String title, required String desc,required year,required month,required day}) {
    return tasks.add({
      'title': title,
      'description': desc,
      'year': year,
      'month': month,
      'day': day,
      'status': 'new',
      'repeatType': 'Yearly Task',
      'lastDate': Timestamp.now(),
      'userId': auth.currentUser?.uid,
    });
  }

  // Add Monthly Task
  Future<void> addTaskMonthly({required String title, required String desc,required year,required month,required day}) {
    return tasks.add({
      'title': title,
      'description': desc,
      'year': year,
      'month': month,
      'day': day,
      'status': 'new',
      'repeatType': 'Monthly Task',
      'lastDate': Timestamp.now(),
      'userId': auth.currentUser?.uid,
    });
  }

  // Add Weekly Task
  Future<void> addTaskWeekly({required String title, required desc,required year,required month,required day}) {
    return tasks.add({
      'title': title,
      'description': desc,
      'year': year,
      'month': month,
      'day': day,
      'status': 'new',
      'repeatType': 'Monthly Task',
      'lastDate': Timestamp.now(),
      'userId': auth.currentUser?.uid,
    });
  }

  // READ: get notes from database
  Stream<QuerySnapshot> getNotesStream() {
    final noteStream = tasks.orderBy("lastDate",descending: true).snapshots();
    return noteStream;
  }

  // Get Data
  Stream<QuerySnapshot> geTaskData() {
    final vtasks = tasks.snapshots();
    return vtasks;
  }

  // Update Status
  Future<void> updateStatus({required newStatus, required id}) {
    return tasks.doc(id).update({
      'status': newStatus,
    });
  }

  Future<void> updateTask({required id, required title,required desc, required year, required month,required day}) {
    return tasks.doc(id).update({
      'title': title,
      'description': desc,
      'year': year,
      'month': month,
      'day': day,
      'lastDate': Timestamp.now(),
    });
  }

    Future<void> deleteNote(String docId) {
      return tasks.doc(docId).delete();
    }

//DELETE: delete notes given a doc id


}
