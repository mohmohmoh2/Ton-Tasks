import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nezam/layout/view_screens/edit_task.dart';

import '../../generated/l10n.dart';
import '../../shared/constants.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';

class ViewTask extends StatelessWidget {

  const ViewTask({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit, States>(
          listener: (BuildContext context, state) {  },
          builder: (BuildContext context, state) {
            return Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: Text(S.of(context).title, textAlign: TextAlign.center,),
                  backgroundColor: color1,
                ),
              body: Container(
                padding: const EdgeInsets.fromLTRB(15,35,15,0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text('View Task',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: color3)),
                        SizedBox(
                          width: double.infinity,
                          child: StreamBuilder<QuerySnapshot>(
                            stream: firestoreService.geTaskData(),
                            builder: (context, snapshot) {
                              List tasks = snapshot.data!.docs;
                              var task;
                              if (snapshot.hasData) {
                                for (int i = 0; i < tasks.length; i++){
                                  DocumentSnapshot ds = tasks[i];
                                  Map<String, dynamic> taska = ds.data() as Map<String, dynamic>;
                                  if(ds.id == selectedid){
                                    task = taska;
                                    print(task);

                                    if(task['desc'] == null){
                                    task['desc'] = 'E';
                                  }
                                  }
                                }
                              }
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 30,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text('Task Title',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
                                      Container(
                                        width: double.infinity,
                                        height: 1,
                                        color: Colors.grey,
                                      ),
                                      Text(task['title']),
                                    ],
                                  ),
                                  const SizedBox(height: 30,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text('Task Description',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
                                      Container(
                                        width: double.infinity,
                                        height: 1,
                                        color: Colors.grey,
                                      ),
                                      const SizedBox(height: 5,),
                                      SizedBox(
                                          height: 100,
                                          child: Text(task['desc'] == 'E' ? 'No Description' : task['desc'])
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 40,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        children: [
                                          const Text('Year'),
                                          const SizedBox(height: 5,),
                                          Text(task['year'].toString()),
                                        ],
                                      ),
                                      Container(
                                        width: 1,
                                        height: 30,
                                        color: Colors.grey,
                                      ),
                                      Column(
                                        children: [
                                          const Text('Month'),
                                          const SizedBox(height: 5,),

                                          Text(task['month'].toString()),
                                        ],
                                      ),
                                      Container(
                                        width: 1,
                                        height: 30,
                                        color: Colors.grey,
                                      ),
                                      Column(
                                        children: [
                                          const Text('Day'),
                                          const SizedBox(height: 5,),
                                          Text(task['day'].toString()),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 40,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10.0),
                                            color: Colors.green,
                                          ),
                                          padding: const EdgeInsets.fromLTRB(15,5,15,5),
                                          child: Text(task['status'],
                                              style: const TextStyle(fontSize: 15,
                                                  fontWeight: FontWeight.bold
                                              )
                                          )
                                      ),
                                      const SizedBox(width: 20,),
                                      Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10.0),
                                            color: Colors.green,
                                          ),
                                          padding: const EdgeInsets.fromLTRB(15,5,15,5),
                                          child: Text(task['repeatType'],
                                              style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              )
                                          )
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            },)
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: 120,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              color: color3,
                            ),
                            padding: const EdgeInsets.fromLTRB(5,0,5,0),
                            child: TextButton(
                                onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => EditTask()));
                            }, child: Text('Edit Task',style: TextStyle(color: mainColor,fontWeight: FontWeight.bold),)),
                          ),
                          Container(
                              width: 120,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                color: Colors.red,
                              ),
                              padding: const EdgeInsets.fromLTRB(5,0,5,0),
                              child: TextButton(
                                  onPressed: (){
                                    AppCubit.get(context).deleteTask(selectedid);
                                  },
                                  child: Text('Delete',style: TextStyle(color: mainColor,fontWeight: FontWeight.bold),)
                              )
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              )
            );
          }
      ),
    );
  }
}
