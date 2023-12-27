import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/components/components.dart';
import '../../shared/constants.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';
import '../../generated/l10n.dart';

class MonthlyTasks extends StatelessWidget {
  const MonthlyTasks ({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit, States>(
        listener: (BuildContext context, state) {  },
        builder: (BuildContext context, state) {
          var formKey = GlobalKey<FormState>();
          // Form Controllers
          final titleController = TextEditingController();
          final descController = TextEditingController();
          return Scaffold(
            body: SafeArea(
              child: Container(
                color: screenBackgroundColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(15,50,15,0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:[
                          Column(
                            children: [
                              Text(S.of(context).AddMonthlyTitle,
                                textAlign: TextAlign.center ,
                                style: TextStyle(
                                    color: color3,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold
                                ),),
                              const SizedBox(height: 10,),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                                child: Text(S.of(context).AddMonthlySub,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: color3
                                  ),),
                              ),
                            ],
                          ),
                          Form(
                            key: formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(height: 30,),
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
                                const SizedBox(height: 20,),
                                textFld(
                                  controller: descController,
                                  hintText: S.of(context).descriptionHint,
                                  type: TextInputType.multiline,
                                  validate: (value){
                                    return null;
                                  },
                                  manLength: 5,
                                  minLength: 5,
                                ),
                                const SizedBox(height: 20,),
                                // const Expanded(child: SizedBox(width: 20,)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    BottomAppBar(
                      shape: const CircularNotchedRectangle(),
                      notchMargin: 10,
                      color: screenBackgroundColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              border: Border.all(color: color4, width: 2.0),
                            ),
                            child: IconButton(
                              onPressed: (){
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.chevron_left_outlined, color: color4,),
                            ),
                          ),
                          const SizedBox(width: 20,),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                border: Border.all(color: mainColor, width: 2.0),
                                color: Colors.green,
                              ),
                              child: TextButton.icon(
                                onPressed: (){
                                  if(cselectedRadio == 'value2'){
                                    if(formKey.currentState!.validate()){
                                      AppCubit.get(context).monthlyAdding(context ,titleController.text, descController.text);
                                    }
                                  }
                                },
                                icon: Icon(Icons.check_circle, color: mainColor,),
                                label: Text(S.of(context).con
                                  , style: TextStyle(
                                      color: mainColor
                                  ),),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            )
          );
        },
      ),
    );
  }
}
