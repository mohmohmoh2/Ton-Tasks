import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../shared/components/components.dart';
import '../../shared/constants.dart';

class MyMain extends StatelessWidget {
  MyMain({super.key});
  // Home Page Date
  final String formatedHome = DateFormat('yyyy-MMMM-dd').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          timeDate(context,formatedHome),
          const SizedBox(height: 30,),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: firestoreService.getNotesStream(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List tasks = snapshot.data!.docs;
                  return ListView.builder(
                    shrinkWrap: true,
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot ds = tasks[index];
                        String id = ds.id;
                        Map<String, dynamic> task = ds.data() as Map<String, dynamic>;
                        return task['userId'] == auth.currentUser!.uid ? buildTaskItem(id,task, context): const SizedBox();
                      }
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
