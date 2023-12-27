import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nezam/shared/constants.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';

class MyProfile extends StatelessWidget {
  MyProfile({super.key});
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => AppCubit()..getUser(),
      child: BlocConsumer<AppCubit, States>(
        listener: (BuildContext context, state) {
          if (state is UpdateNameState) {
            AppCubit.get(context).getUser();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('User Name updated successfully'),
                backgroundColor: Colors.green,
              ),
            );
          }
          if (state is UploadImageState) {
            AppCubit.get(context).getUser();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('User Image updated successfully'),
                backgroundColor: Colors.green,
              ),
            );
          }
          if (state is ImagePickedState) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Uploading image ...'),
                backgroundColor: Colors.green,
              ),
            );
          }
        },
        builder: (BuildContext context, state) {
          return Scaffold(
              backgroundColor: mainColor,
              appBar: AppBar(
                backgroundColor: mainColor,
              ),
              body: Container(
                padding: const EdgeInsets.fromLTRB(25,5,25,30),
                child:  Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  width: 85,
                                  height: 85,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 50,
                                    backgroundImage: userData['img'] != 'img' ? NetworkImage(userData['img']) : const AssetImage('assets/icons/account.png') as ImageProvider,
                                  ),
                                ),

                                Text(userData['name'],style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 20),),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 22,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Image.asset('assets/icons/bill.png', width: 24, height: 24,),
                                Text(userData['addedTasks'].toString(),style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
                                Text('Total Tasks',style: TextStyle(fontSize: 14,color: Colors.grey[700])),
                              ],
                            ),
                            const SizedBox(width: 30,),
                            Column(
                              children: [
                                Image.asset('assets/icons/account.png', width: 24, height: 24,),
                                const Text('682',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
                                Text('Followers',style: TextStyle(fontSize: 14,color: Colors.grey[700])),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 22,),
                        Text('Settings',style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold,color: color2),textAlign: TextAlign.start,),
                        const SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.settings),
                                const SizedBox(width: 10,),
                                Text('App Settings',style: TextStyle(fontSize: 16,color: color3)),
                              ],
                            ),
                            const Icon(Icons.chevron_right)
                          ],
                        ),
                        const SizedBox(height: 22,),
                        Text('Account',style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold,color: color2),textAlign: TextAlign.start,),
                        const SizedBox(height: 10,),
                        GestureDetector(
                          onTap: (){
                            showDialog(
                                context: context,
                                builder: (_) {
                                  return AlertDialog(backgroundColor: color2,
                                    title: Text('Change account name',style: TextStyle(color: mainColor,fontSize: 16,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: <Widget>[
                                          const SizedBox(height: 10,),
                                          TextFormField(
                                              controller: nameController,
                                              decoration: InputDecoration(
                                                hintStyle: TextStyle(color: Colors.grey[400],fontSize: 16),
                                                border: const OutlineInputBorder(
                                                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                                ),
                                                hintText: "Enter Your Name",
                                              )
                                          ),
                                          const SizedBox(height: 10,),
                                        ],
                                      ),
                                    ),
                                    actions: <Widget>[
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              padding: const EdgeInsets.all(8),
                                              child: TextButton(
                                                child: Text('Cancel',style: TextStyle(color: mainColor)),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 10,),
                                          Expanded(
                                            child: Container(
                                              padding: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(20),
                                                color: bgButton,
                                              ),
                                              child: TextButton(
                                                child: Text('Edit',style: TextStyle(color: color3),),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                  AppCubit.get(context).updateUserName (nameController.text);
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                    ],
                                  );
                                }
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.account_circle_outlined),
                                  const SizedBox(width: 10,),
                                  Text('Change Account Name',style: TextStyle(fontSize: 15,color: color3)),
                                ],
                              ),
                              const Icon(Icons.chevron_right)
                            ],
                          ),
                        ),
                        const SizedBox(height: 18,),
                        GestureDetector(
                          onTap: (){
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(backgroundColor: color2,
                                    title: Text('Change account password',style: TextStyle(color: mainColor,fontSize: 16,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: <Widget>[
                                          const SizedBox(height: 10,),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('Enter old password',style: TextStyle(color: mainColor),),
                                              TextFormField(
                                                  controller: nameController,
                                                  obscureText: true,
                                                  decoration: InputDecoration(
                                                    hintStyle: TextStyle(color: Colors.grey[400],fontSize: 16),
                                                    border: const OutlineInputBorder(
                                                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                                    ),
                                                  )
                                              ),
                                              const SizedBox(height: 10,),
                                              Text('Enter new password',style: TextStyle(color: mainColor)),
                                              TextFormField(
                                                  controller: nameController,
                                                  obscureText: true,
                                                  decoration: InputDecoration(
                                                    hintStyle: TextStyle(color: Colors.grey[400],fontSize: 16),
                                                    border: const OutlineInputBorder(
                                                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                                    ),
                                                  )
                                              ),
                                              const SizedBox(height: 10,),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    actions: <Widget>[
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              padding: const EdgeInsets.fromLTRB(5,3,5,3),
                                              child: TextButton(
                                                child: Text('Cancel',style: TextStyle(color: mainColor)),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 10,),
                                          Expanded(
                                            child: Container(
                                              padding: const EdgeInsets.fromLTRB(5,3,5,3),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(20),
                                                color: bgButton,
                                              ),
                                              child: TextButton(
                                                child: Text('Edit',style: TextStyle(color: color3),),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                }
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset('assets/icons/key-square.png', width: 24, height: 24,),
                                  const SizedBox(width: 10,),
                                  Text('Change Account Password',style: TextStyle(fontSize: 15,color: color3)),
                                ],
                              ),
                              const Icon(Icons.chevron_right)
                            ],
                          ),
                        ),
                        const SizedBox(height: 18,),
                        GestureDetector(
                          onTap: (){
                            showModalBottomSheet(
                                context: context,
                                builder: (_) {
                                  return Container(
                                    width: double.infinity,
                                    height: 150,
                                    color: Colors.transparent,
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          color: color2,
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20),
                                          )
                                      ),
                                      child: Column(
                                        children: [
                                          const SizedBox(height: 20,),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  TextButton(onPressed: () {
                                                    AppCubit.get(context).imagePicCamera();
                                                  },
                                                      child: Text('Take picture',style: TextStyle(fontSize: 16,color: mainColor))
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  TextButton(
                                                      onPressed: () {
                                                        AppCubit.get(context).imagePic();
                                                      },
                                                      child: Text('Import from gallery',style: TextStyle(fontSize: 16,color: mainColor))
                                                  ),
                                                ],
                                              ),

                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset('assets/icons/gallery.png', width: 24, height: 24,),
                                  const SizedBox(width: 10,),
                                  Text('Change account image',style: TextStyle(fontSize: 15,color: color3)),
                                ],
                              ),
                              const Icon(Icons.chevron_right)
                            ],
                          ),
                        ),
                        const SizedBox(height: 22,),
                        Text('Ton Tasks',style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold,color: color2),textAlign: TextAlign.start,),
                        const SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset('assets/icons/about.png', width: 24, height: 24,),
                                const SizedBox(width: 10,),
                                Text('About Us',style: TextStyle(fontSize: 16,color: color3)),
                              ],
                            ),
                            const Icon(Icons.chevron_right)
                          ],
                        ),
                        const SizedBox(height: 18,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset('assets/icons/flash.png', width: 24, height: 24,),
                                const SizedBox(width: 10,),
                                Text('Help & Feedback',style: TextStyle(fontSize: 16,color: color3)),
                              ],
                            ),
                            const Icon(Icons.chevron_right)
                          ],
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: (){
                        AppCubit.get(context).logout(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/icons/logout.png', width: 24, height: 24,),
                          const SizedBox(width: 10,),
                          const Text('Log Out',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.red),textAlign: TextAlign.start,),
                        ],
                      ),
                    ),],
                ),
              )
          );
        },

      ),
    );
  }
}
