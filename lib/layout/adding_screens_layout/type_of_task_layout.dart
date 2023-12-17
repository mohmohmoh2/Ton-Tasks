import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nezam/shared/constants.dart';

import '../../generated/l10n.dart';
import '../../shared/components/components.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';

class TypeTask extends StatelessWidget {
  const TypeTask({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit, States>(
        listener: (BuildContext context, States state) {

        },
        builder: (BuildContext context, States state) {
          var scolor = color1, stcolor = color2,fcolor = color1, ftcolor = color2;
          if (AppCubit.get(context).repeat == 1){
            scolor = color2;
            stcolor = Colors.white;
            ftcolor = color2;
            fcolor = color1;
          }else if (AppCubit.get(context).repeat == 2){
            scolor = color1;
            stcolor = color2;
            ftcolor = Colors.white;
            fcolor = color2;
          }

          return Scaffold(
                body: SafeArea(
                  child: Container(
                    padding: const EdgeInsets.only(top: 50.0),
                    color: screenBackgroundColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(S.of(context).typeOfTaskTitle,
                                    textAlign: TextAlign.center ,
                                    style: TextStyle(
                                        color: color3,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold
                                    ),),
                                  const SizedBox(height: 10,),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 50.0),
                                    child: Text(S.of(context).typeOfTaskSub,
                                        textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: color3,
                                          fontSize: 10,
                                        ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 110,),
                              GestureDetector(
                                onTap: (){
                                  AppCubit.get(context).repeat = 1;
                                  AppCubit.get(context).changeRepeatStyle();

                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100.0),
                                    color: scolor,
                                  ),
                                  height: 140,
                                  width: 140,
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.looks_one_outlined,
                                          color: stcolor,
                                          size: 50,
                                        ),
                                        Text(S.of(context).oneTime,
                                          style: TextStyle(color: stcolor),
                                        ),
                                    ])
                                ),
                              ),
                              const SizedBox(height: 60,),
                              GestureDetector(
                                onTap: (){
                                  AppCubit.get(context).repeat = 2;
                                  AppCubit.get(context).changeRepeatStyle();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100.0),
                                    color: fcolor,
                                  ),
                                  width: 140,
                                  height: 140,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.repeat_one_outlined,
                                        color: ftcolor,
                                        size: 50,
                                      ),
                                      Text(S.of(context).Repeatable,
                                      style: TextStyle(
                                        color: ftcolor
                                      ),
                                      ),
                                    ]),
                                ),
                              ),
                            ],
                          ),
                        ),
                        bottomBar(context, 'taskTypeScreen','titleController','dateController','descController','formKey'),
                      ],
                    ),
                  ),
                ),
          );
        },
      ),
    );
  }
}
