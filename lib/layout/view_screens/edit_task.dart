import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../generated/l10n.dart';
import '../../maindcreen.dart';
import '../../shared/constants.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';

class EditTask extends StatelessWidget {
  EditTask({super.key});

  final titleController = TextEditingController();
  final descController = TextEditingController();
  final yearController = TextEditingController();
  final monthController = TextEditingController();
  final dayController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit, States>(
          listener: (BuildContext context, state) {
            if(state is UpdateTaskState){
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)  => const MainScreen()), (Route<dynamic> route) => false);
            }
          },
          builder: (BuildContext context, state) {
            titleController.text = sTask['title'];
            descController.text = sTask['description'] == 'E' ? ' ' : sTask['description'];
            yearController.text = sTask['year'];
            monthController.text = sTask['month'];
            dayController.text = sTask['day'];
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
                              child: Column(
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
                                      TextFormField(
                                          controller: titleController,
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                          ),

                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 30,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text('Task Description',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
                                      const SizedBox(height: 5,),
                                      SizedBox(
                                          child: TextFormField(
                                            minLines: 5,
                                            maxLines: 5,
                                            controller: descController,
                                            decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                            ),
                                          ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 30,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        children: [
                                          const Text('Year'),
                                          const SizedBox(height: 5,),
                                          SizedBox(
                                            width: 70,
                                            height: 60,
                                            child: TextFormField(
                                              controller: yearController,
                                              keyboardType: TextInputType.number,
                                              decoration: InputDecoration(
                                                border: const OutlineInputBorder(),
                                                hintText: selectedYear,
                                              ),
                                            ),
                                          ),
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
                                          SizedBox(
                                            width: 50,
                                            height: 50,
                                            child: TextFormField(
                                              controller: monthController,
                                              keyboardType: TextInputType.number,
                                              decoration: InputDecoration(
                                                border: const OutlineInputBorder(),
                                                hintText: selectedMonth,
                                              ),
                                            ),
                                          ),
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
                                          SizedBox(
                                            width: 50,
                                            height: 50,
                                            child: TextFormField(
                                              controller: dayController,
                                              keyboardType: TextInputType.number,
                                              decoration: InputDecoration(
                                                border: const OutlineInputBorder(),
                                                hintText: selectedDay,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 30,),
                                ],
                              ),
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
                                      AppCubit.get(context).editTask(titleController.text,descController.text,yearController.text,monthController.text,dayController.text);
                                    },
                                    child: Text('Save',style: TextStyle(color: mainColor,fontWeight: FontWeight.bold),)),
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
