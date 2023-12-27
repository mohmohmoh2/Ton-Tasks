import 'package:flutter/material.dart';
import 'package:nezam/modules/add_screen/addscreen.dart';
import 'package:nezam/shared/cubit/cubit.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../generated/l10n.dart';
import '../../layout/adding_screens_layout/monthly.dart';
import '../../layout/adding_screens_layout/repeat_type.dart';
import '../../layout/adding_screens_layout/weekly.dart';
import '../../layout/adding_screens_layout/yearly.dart';
import '../../layout/view_screens/view_task.dart';
import '../../maindcreen.dart';
import '../constants.dart';

// Reusable Text Form Field
Widget textFld({
  required TextEditingController controller,
  required String hintText,
  IconData? icon,
  minLength = 1,
  manLength = 1,
  required TextInputType type,
  bool isPassword = false,
  IconData? suffix,
  Function? suffixPressed,
  Function? onTap,
  Function? onChange,
  Function? onSubmit,
  Function? validate,

}) => TextFormField(
  cursorColor: color3,
  controller: controller,
  decoration: InputDecoration(
    hintStyle: TextStyle(color: color3),
    hintText: hintText,
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20.0)),
    ),
    suffixIcon: IconButton(
      onPressed: (){
        suffixPressed!();
      },
      icon: Icon(suffix),
    ),
  ),
  onTap: (){
    onTap!();
  },
  minLines: minLength,
  maxLines: manLength,
  keyboardType: type,
  validator: (value){
    return validate!(value);
  },

);

// Home Date Widget
Widget timeDate(context,formatedHome) => Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(formatedHome, style: const TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        )),
        const SizedBox(height: 5),
        Text(S.of(context).today),
      ],
    ),
    const SizedBox(height: 20,),
  ],
);

// Reusable Task Item
Widget buildTaskItem(id,model, BuildContext context) => Container(
  margin: const EdgeInsets.only(
    bottom: 10.0,
  ),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(12.0),
    color: model['status'] == 'new' ? color1 : color2,
  ),
  padding: const EdgeInsets.symmetric(
    horizontal: 15.0,
  ),
  child: Row(
    children: [
      Expanded(
        child: GestureDetector(
          onTap: (){
            selectedid = id;
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>
              const ViewTask()
              ),
            );
          },
          child:
        Text(
            '${model['title']}', style: TextStyle(color: model['status'] == 'new' ? color2 : mainColor)),
        ),
      ),
        model['status'] == 'new' ? TextButton(
          onPressed: () {
            AppCubit.get(context).onChangeButtonPressed(status: model['status'], id: id);
          },
          child: CircularPercentIndicator(
            radius: 22.0,
            lineWidth: 5.0,
            percent: 0.75,
            center: const Text("3/4",style: TextStyle(fontSize: 12),),
            progressColor: color4,
          ),
        ) :
        IconButton(onPressed: (){
          AppCubit.get(context).onChangeButtonPressed(status: model['status'], id: id);
        }, icon: Icon( Icons.check_circle, color: mainColor)),
    ],
  ),
);

Widget emptyTasks(context) => Center(
  child: Text(
    S.of(context).empty,
    style: const TextStyle(
      fontSize: 30.0,
      fontWeight: FontWeight.bold,
    ),
  ),
);

// Bottom bar on adding screens
Widget bottomBar(context, String refScreen,titleController,dateController,descController,formKey) => BottomAppBar(
  shape: const CircularNotchedRectangle(),
  notchMargin: 10,
  color: screenBackgroundColor,
  child: Directionality(
    textDirection: TextDirection.rtl,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: mainColor, width: 2.0),
              color: color4,
            ),
            child: TextButton.icon(
              onPressed: (){
                if (refScreen == 'oneTimeTask'){
                  if(formKey.currentState!.validate()){
                    if(descController.text.isEmpty){descController.text = 'E';}
                    AppCubit.get(context).insertToDB(
                        title: titleController.text,
                        date: dateController.text,
                        desc: descController.text,
                        context: context
                    );
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)  => const MainScreen()), (Route<dynamic> route) => false);
                  }
                }
                if (AppCubit.get(context).repeat == 1) {
                      Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>
                        AddScreen()
                    ),
                  );
                    } else if (AppCubit.get(context).repeat == 2) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>
                          const RepeatType()
                      ),
                    );
                }
                if(AppCubit.get(context).selectedRadio == 'value1') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>
                        const YearlyTasks()
                    ),
                  );
                } else if (AppCubit.get(context).selectedRadio == 'value2'){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>
                        const MonthlyTasks()
                    ),
                  );
                } else if (AppCubit.get(context).selectedRadio == 'value3') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>
                        const WeeklyTasks()
                    ),
                  );}
              },
                label: Text(S.of(context).next
                , style: TextStyle(
                    color: mainColor
                ),),
              icon: Icon(Icons.chevron_left_outlined, color: mainColor,),
            ),
          ),
        ),
        const SizedBox(width: 20,),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: color4, width: 2.0),
          ),
          child: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(Icons.chevron_right_outlined, color: color4,),
          ),
        ),
      ],
    ),
  ),
);

