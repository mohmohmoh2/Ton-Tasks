import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nezam/shared/components/components.dart';
import 'package:nezam/shared/constants.dart';
import 'package:nezam/shared/cubit/cubit.dart';
import 'package:nezam/shared/cubit/states.dart';
import 'generated/l10n.dart';
import 'layout/adding_screens_layout/type_of_task_layout.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDataBase() ,
      child: BlocConsumer<AppCubit, States>(
        listener: (BuildContext context, States state) {
        },
        builder: (BuildContext context, States state) {

          var tasks = task;
          return Scaffold(
          appBar: AppBar(
            centerTitle: true,
              title: Text(S.of(context).title, textAlign: TextAlign.center,),
              actions: [
                PopupMenuButton(
                  onSelected: (value){
                    AppCubit.get(context).changeLang(value);
                  },
                    itemBuilder: (context) => [
                   PopupMenuItem(
                    value: 'ar',
                    child: Text(S.of(context).arabic),
                  ),
                   PopupMenuItem(
                    value: 'en',
                    child: Text(S.of(context).english),
                  ),
                ]),
              ],
              backgroundColor: color1,
            ),
            body: Container(
                  color: mainColor,
                child: Padding(
                padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      timeDate(context),
                      const SizedBox(height: 30,),
                      Expanded(
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (context, index) => buildTaskItem(tasks[index], context),
                          separatorBuilder: (context, index) => const SizedBox(height: 10,),
                          itemCount: tasks.length,
                        ),
                      ),
                      Container(height: 90,color: mainColor)
                    ],
                  ),
                ),
                ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: FloatingActionButton(
                backgroundColor: color2,
                shape: const CircleBorder(),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>
                     const TypeTask()
                    ),
                  );
                },
                child: Icon(Icons.add,
                  color: mainColor,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}