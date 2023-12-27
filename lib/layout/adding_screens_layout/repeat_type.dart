import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../generated/l10n.dart';
import '../../shared/components/components.dart';
import '../../shared/constants.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';

class RepeatType extends StatelessWidget {
  const RepeatType({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => AppCubit(),
        child: BlocConsumer<AppCubit, States>(
          listener: (BuildContext context, States state) {
          },
          builder: (BuildContext context, States state) {
            var selected = 4.0;
            var notselected = 1.0;
            var width1 = notselected, width2 = notselected, width3 = notselected;
            if (AppCubit.get(context).selectedRadio == 'value1'){
              width1 = selected;
              width2 = notselected;
              width3 = notselected;
            } else if (AppCubit.get(context).selectedRadio == 'value2'){
              width1 = notselected;
              width2 = selected;
              width3 = notselected;
            } else if (AppCubit.get(context).selectedRadio == 'value3'){
              width1 = notselected;
              width2 = notselected;
              width3 = selected;
            }
            return Scaffold(
              body: SafeArea(
                child: Container(
                  color: screenBackgroundColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(10,50.0,10,0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                                children: [
                                  Text(S.of(context).repeatTypeTitle,
                                    textAlign: TextAlign.center ,
                                    style: TextStyle(
                                      color: color3,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold
                                    ),),
                                  const SizedBox(height: 10,),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 50.0),
                                    child: Text(S.of(context).repeatTypeSub,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: color3,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            const SizedBox(height: 120,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: color3,width: width1),
                                    borderRadius: BorderRadius.circular(12.0),
                                    color: color1,
                                  ),
                                  child: RadioListTile(value: 'value1',title: Column(
                                    children: [
                                      Text(S.of(context).YearlyRadioTitle,textAlign: TextAlign.start),
                                      Text(S.of(context).YearlyRadioSub,style: TextStyle(fontSize: 10,color: color3)),
                                    ],
                                  ) ,
                                      groupValue: AppCubit.get(context).selectedRadio,
                                      onChanged: (onChanged){
                                    AppCubit.get(context).radiobuttonTask(onChanged);
                                  }),
                                ),
                                const SizedBox(height: 20,),
                                Container(
                                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: color3,width: width2),
                                    borderRadius: BorderRadius.circular(12.0),
                                    color: color1,
                                  ),
                                  child: RadioListTile(value: 'value2',title: Column(
                                    children: [
                                      Text(S.of(context).monthlyRadioTitle,textAlign: TextAlign.start),
                                      Text(S.of(context).monthlyRadioSub,style: TextStyle(fontSize: 10,color: color3)),
                                    ],
                                  ) ,
                                      groupValue: AppCubit.get(context).selectedRadio,
                                      onChanged: (onChanged){
                                    AppCubit.get(context).radiobuttonTask(onChanged);
                                      }),
                                ),
                                const SizedBox(height: 20,),
                                Container(
                                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                    border: Border.all(color: color3,width: width3),
                                    color: color1,
                                  ),
                                  child: RadioListTile(value: 'value3',title: Column(
                                    children: [
                                      Text(S.of(context).weeklyRadioTitle,textAlign: TextAlign.start),
                                      Text(S.of(context).weeklyRadioSub,style: TextStyle(fontSize: 10,color: color3)),
                                    ],
                                  ) ,
                                      groupValue: AppCubit.get(context).selectedRadio,
                                      onChanged: (onChanged){
                                    AppCubit.get(context).radiobuttonTask(onChanged);
                                      }),
                                )
                              ]
                            ),
                            const SizedBox(height: 20,),
                          ],
                        ),
                      ),
                      bottomBar(context, 'repeatTypeScreen','titleController','dateController','descController','formKey')
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
