import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nezam/layout/view_screens/edit_task.dart';
import 'package:nezam/maindcreen.dart';

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
          listener: (BuildContext context, state) {
            if(state is DeleteTaskState){
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)  => const MainScreen()), (Route<dynamic> route) => false);
            }
          },
          builder: (BuildContext context, state) {
            return Scaffold(
              backgroundColor: mainColor,
                appBar: AppBar(
                  centerTitle: true,
                  title: Text(S.of(context).title, textAlign: TextAlign.center,style: const TextStyle(fontWeight: FontWeight.bold),),
                  backgroundColor: mainColor,
                ),
              body: Container(
                padding: const EdgeInsets.fromLTRB(15,25,15,0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text('View Task',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: color3)),
                        SizedBox(
                          child: StreamBuilder<QuerySnapshot>(
                            stream: firestoreService.geTaskData(),
                            builder: (context, snapshot) {
                              List tasks = snapshot.data!.docs;
                              if (snapshot.hasData) {
                                for(var i = 0; i < tasks.length; i++){
                                  DocumentSnapshot ds = tasks[i];
                                  String id = ds.id;
                                  Map<String, dynamic> task = ds.data() as Map<String, dynamic>;
                                  id == selectedid ?  sTask = task : null;
                                }
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 30,),
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.fromLTRB(15,20,15,20),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.0),
                                        color: color1,
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text('Task Title',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: color4)),
                                          Text(sTask['title']),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 10,),
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.fromLTRB(15,20,15,20),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.0),
                                        color: color1,
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text('Task Description',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: color4)),
                                          const SizedBox(height: 5,),
                                          SizedBox(
                                              height: 100,
                                              child: Text(sTask['description'] == 'E' ? 'No Description' : sTask['description'])
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 20,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Column(
                                          children: [
                                            const Text('Year'),
                                            const SizedBox(height: 5,),
                                            Text(sTask['year'].toString()),
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

                                            Text(sTask['month'].toString()),
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
                                            Text(sTask['day'].toString()),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 40,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.timer_sharp,color: color3,),
                                            const SizedBox(width: 8,),
                                            Text('Repeat Type :',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: color3)),
                                          ],
                                        ),
                                        Container(
                                          padding: const EdgeInsets.fromLTRB(15,5,15,5),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10.0),
                                            color: color3,
                                          ),
                                            child: Text(sTask['repeatType'],style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),)),
                                      ],
                                    ),
                                    const SizedBox(height: 10,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.flag_outlined,color: color3,),
                                            const SizedBox(width: 8,),
                                            Text('Task Status :',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: color3)),
                                          ],
                                        ),
                                        Container(
                                            padding: const EdgeInsets.fromLTRB(15,5,15,5),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10.0),
                                              color: color3,
                                            ),
                                            child: Text(sTask['status'],style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),)),
                                      ],
                                    ),
                                  ],
                                );
                              }else {
                                return const SizedBox();
                              }
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
                                    showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) => AlertDialog(
                                        title: const Text('Delete Task'),
                                        content: Container(
                                          padding: const EdgeInsets.fromLTRB(5,30,5,0),
                                            child: Text('Are You Sure You Want To Delete This Task?',style: TextStyle(fontSize: 17,color: color3))),
                                        actions: <Widget>[
                                          Container(
                                            padding: const EdgeInsets.fromLTRB(5,40,5,0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                Container(
                                                  padding: const EdgeInsets.fromLTRB(5,0,5,0),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(8.0),
                                                    color: color3,
                                                  ),
                                                  child: TextButton(
                                                    onPressed: () => Navigator.pop(context),
                                                    child: Text('No',style: TextStyle(color: mainColor,fontWeight: FontWeight.bold)),
                                                  ),
                                                ),
                                                Container(
                                                  padding: const EdgeInsets.fromLTRB(5,0,5,0),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(8.0),
                                                    color: Colors.red,
                                                  ),
                                                  child: TextButton(
                                                    onPressed: () => AppCubit.get(context).deleteTask(selectedid),
                                                    child: Text('Yes',style: TextStyle(color: mainColor,fontWeight: FontWeight.bold))
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      )
                                    );
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
