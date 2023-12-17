import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nezam/mainScreen.dart';
import 'package:nezam/shared/components/components.dart';
import 'package:nezam/shared/cubit/states.dart';
import '../../generated/l10n.dart';
import '../../shared/constants.dart';
import '../../shared/cubit/cubit.dart';

class AddScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  // Form Controllers
  final titleController = TextEditingController();
  final descController = TextEditingController();
  final dateController = TextEditingController();

  AddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (BuildContext context) => AppCubit()..createDataBase() ,
      child: BlocConsumer<AppCubit, States>(
        listener: (BuildContext context, States state) {
          if(state is InsertDBState){
            Navigator.pop(context);}
        },
        builder: (BuildContext context, States state) {
          return Scaffold(
              body: SafeArea(
                child: Form(
                  key: formKey,
                  child: Container(
                    color: const Color(0xffE8EEF6),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                               const SizedBox(height: 30,),
                              Text(S.of(context).newTask,
                                style: TextStyle(
                                  fontSize: 35.0,
                                  fontWeight: FontWeight.bold,
                                  color: color2,
                                ),
                              ),
                              const SizedBox(height: 40,),
                              textFld(
                                controller: titleController,
                                hintText: S.of(context).taskTitleHint,
                                type: TextInputType.multiline,
                                validate: (value){
                                  if(value.isEmpty){
                                    return S.of(context).AlertTitle;
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                              textFld(
                                  controller: dateController,
                                  hintText: S.of(context).dateHint,
                                  type: TextInputType.none,
                                  onTap: (){
                                        showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime.parse('2044-12-31'),
                                        ).then((value) {
                                          value.toString();
                                          dateController.text = DateFormat('yyyy-MM-dd').format(value!);
                                        });
                                      },
                                  validate: (value){
                                  if(value.isEmpty){
                                    return S.of(context).AlertDate;
                                  }
                                  return null;
                                },
                                  suffix:  Icons.calendar_today_outlined,
                              ),
                              const SizedBox(height: 20,),
                              textFld(
                                controller: descController,
                                hintText: S.of(context).descriptionHint,
                                type: TextInputType.multiline,
                                manLength: 5,
                                minLength: 5,
                                validate: (value){
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20,),
                              // const Expanded(child: SizedBox(width: 20,)),
                            ],
                          ),
                        ),
                        bottomBar(context,'oneTimeTask',titleController,dateController,descController,formKey),

                      ],
                    ),
                  ),
                ),
              )
          );
        },
      ),
    );
  }
}

