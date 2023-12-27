import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nezam/layout/profilescreens/profile.dart';
import 'package:nezam/shared/constants.dart';
import 'package:nezam/shared/cubit/cubit.dart';
import 'package:nezam/shared/cubit/states.dart';
import 'generated/l10n.dart';
import 'layout/adding_screens_layout/type_of_task_layout.dart';
import 'layout/main_screens/main.dart';
import 'layout/registration/sign_in.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..getUser() ,
      child: BlocConsumer<AppCubit, States>(
        listener: (BuildContext context, States state) {
        },
        builder: (BuildContext context, States state) {
          if(auth.currentUser == null){
            return SignIn();
          }
          return Scaffold(
          appBar: AppBar(
            centerTitle: true,
              title: Text(S.of(context).title, textAlign: TextAlign.center),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>
                          MyProfile()
                      ),
                    );
                    // AppCubit.get(context).logout(context);builder
                  },
                  icon: const Icon(Icons.account_circle),
                  color: color2,
                )
              ],
              backgroundColor: color1,
            leading:
              Row(
                children: [
                  PopupMenuButton(
                    icon: Image.asset('assets/icons/menu.png'),
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
                  // IconButton(
                  //   onPressed: () {
                  //   },
                  //   icon: const Icon(Icons.notifications_active),
                  //   color: color2,
                  // ),

                ],
              )
            ),
            body: MyMain(),
            bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor: mainColor,
                selectedItemColor: color2,
                unselectedItemColor: color2.withOpacity(.60),
                items: [
                  const BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: ''
                  ),
                  BottomNavigationBarItem(
                      icon: Image.asset('assets/icons/people.png'),
                      label: ''
                  ),
                  const BottomNavigationBarItem(
                      icon: Icon(Icons.add),
                      label: ''
                  ),
                  BottomNavigationBarItem(
                      icon: Image.asset('assets/icons/Bar Chart Down.png'),
                      label: ''
                  ),
                  BottomNavigationBarItem(
                      label: '',
                      icon: Image.asset('assets/icons/Certificate.png')
                  ),
                ]),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(bottom: 0.0),
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