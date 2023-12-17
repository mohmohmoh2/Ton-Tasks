import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  // get collection of notes
  final CollectionReference tasks =
      FirebaseFirestore.instance.collection('tasks');

  // CREATE : add a new note

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
      'userId': desc,
    });
  }

  // READ: get notes from database
  Stream<QuerySnapshot> getNotesStream() {
    final noteStream = tasks.snapshots();
    print('===================******************===================');
    print(noteStream);
    return noteStream;
  }

  Future<void> updateStatus({required newStatus, required id}) {
    return tasks.doc(id).update({
      'status': newStatus,
    });
  }

//DELETE: delete notes given a doc id

  Future<void> deleteNote(String docId) {
    return tasks.doc(docId).delete();
  }
}
