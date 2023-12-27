import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nezam/layout/registration/sign_in.dart';
import '../../generated/l10n.dart';
import '../../maindcreen.dart';
import '../../shared/components/components.dart';
import '../../shared/constants.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit, States>(
        listener: (BuildContext context, state) {
          if(state is SignUpErrorState){
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Error'),
                content: Text(state.error),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Close'),
                    child: const Text('Close'),
                  ),
                ],
              ),
            );
          }else if(state is SignUpSuccessState){
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)  => const MainScreen()), (Route<dynamic> route) => false);
          }
        },
        builder: (BuildContext context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: mainColor,
            body: SingleChildScrollView(
              reverse: true,
              child: Column(
                children: [
                  SafeArea(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        children: [
                          const SizedBox(
                              height: 250,
                              child: Image(image: AssetImage('assets/signin.png'))),
                          const SizedBox(height: 30),
                          Container(
                            height: 50,
                            color: Colors.red[900],
                            child: TextButton(onPressed: (){},
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                        height: 20,
                                        child: Image.asset('assets/icons/google.png')),
                                    const SizedBox(width: 10,),
                                    const Text('Sign Up With Google',style: TextStyle(color: Colors.white)),
                                  ],
                                )
                            ),
                          ),
                          const SizedBox(height: 15),
                          Container(
                            height: 50,
                            color: Colors.black,
                            child: TextButton(onPressed: (){},
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                        height: 20,
                                        child: Image.asset('assets/icons/apple.png')),
                                    const SizedBox(width: 10,),
                                    const Text('Sign Up With Apple',style: TextStyle(color: Colors.white)),
                                  ],
                                )
                            ),
                          ),
                          const SizedBox(height: 15),
                          Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              Container(
                                height: 1,
                                color: Colors.grey,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                color: Colors.white,
                                child: Text(S.of(context).or),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          textFld(
                            controller: emailController,
                            hintText: S.of(context).email,
                            icon: Icons.email,
                            type: TextInputType.emailAddress,
                            validate: (value){
                              if (value!.isEmpty){
                                return S.of(context).emailValidation;
                              }
                            },
                          ),
                          const SizedBox(height: 10,),
                          textFld(
                            controller: passwordController,
                            hintText: S.of(context).password,
                            icon: Icons.lock,
                            type: TextInputType.visiblePassword,
                            isPassword: true,
                            validate: (value){
                              if (value!.isEmpty){
                                return S.of(context).passwordValidation;
                              }
                            },
                          ),
                          const SizedBox(height: 15,),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Container(
                              color: color3,
                              child: TextButton(
                                  onPressed: (){
                                    AppCubit.get(context).userSignUp(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      context: context,
                                    );
                                  },

                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(S.of(context).signUp,style: const TextStyle(color: Colors.white)),
                                      const SizedBox(width: 10,),
                                      const Icon(Icons.arrow_right_alt,color: Colors.white,)
                                    ],
                                  )
                              ),
                            ),
                          ),
                          const SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(S.of(context).haveAccount),
                              TextButton(
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) =>  SignIn()));
                                },
                                child: Text(S.of(context).signIn),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom))
                ],
              ),
            ),
          );
        },),
    );
  }
}
