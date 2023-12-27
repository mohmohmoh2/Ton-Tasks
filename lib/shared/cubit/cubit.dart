import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:nezam/shared/constants.dart';
import 'package:nezam/shared/cubit/states.dart';
import '../../main.dart';
import 'dart:io';

class AppCubit extends Cubit<States> {
  AppCubit() : super(AppInitial());
  static AppCubit get(context) => BlocProvider.of(context);
  final DATABASE_NAME = 'todoo.db';
  var selectedRadio,desc;
  var repeat;
  var weaklyDays=[];


  static int getDaysInMonth(int year, int month) {
    if (month == DateTime.february) {
      final bool isLeapYear = (year % 4 == 0) && (year % 100 != 0) || (year % 400 == 0);
      return isLeapYear ? 29 : 28;
    }
    const List<int> daysInMonth = <int>[31, -1, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    return daysInMonth[month - 1];
  }

  Future insertToDB({required context,required String title, required date, required String desc,})  async {
    firestoreService.addNote(title: title, date: date, desc: desc).then((value) => {
      firestoreService.updateTasksNumber(context),
      getUser(),
    });
  }

  // Update the task states
  onChangeButtonPressed({required String status, required id}) async {
    String newStatus = status == 'done' ? 'new' : 'done';
    firestoreService.updateStatus(newStatus: newStatus, id: id);
  }

  // Change Active Language Variable
  changeLang(String value) async {
    if(Intl.getCurrentLocale() == value){
      emit(ChangeBTMState());
    }else if(Intl.getCurrentLocale() != value){
      if (Intl.getCurrentLocale() == 'en'){
      //S.load(const Locale('ar', ''));
      emit(ChangeBTMState());
    }else if(Intl.getCurrentLocale() == 'ar'){
      //S.load(const Locale('en', ''));
      emit(ChangeBTMState());
    }
    }
  }

  changeRepeatStyle(){
    emit(TypeOfTaskState());
  }

  radiobuttonTask(value){
    selectedRadio = value;
    cselectedRadio = value;
    emit(RadiobuttonTaskState());
  }

//   test(){
//       var done = false;
//   var now = DateTime.now();
//   var formatter = DateFormat('EEEE');
//   String formattedDate = formatter.format(now);
// var list = 1;
//
// // ['Friday', 'Saturday', 'Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday'];
//   for (var element in daysEn ) {
//     if(element != formattedDate && done == false){
//         list = list + 1;
//     }else if(element == formattedDate){
//       done = true;
//     }
//   }
//   //var first = daysEn.getRange(0, list);
//
//   //var f = daysEn.addAll(first);
//   daysEn.removeRange(0, list);
//
// }

  yearlyAdding(context ,String title, String desc) async {
    var eyear = nYear;
    //    title TEXT, year INTEGER, month INTEGER, day INTEGER, desc TEXT, status TEXT;
      for(var i=0; i < 12; i++) {
          firestoreService.addTaskYearly(title: title, year: eyear, desc: desc, month: 0, day: 0);
          firestoreService.updateTasksNumber(context);
          eyear = eyear +1;
        }
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)  => const MyApp()), (Route<dynamic> route) => false);
  }

  monthlyAdding(context ,String title, String desc) async {

    var savedMonth = nMonth,savedYear = nYear;
    //    title TEXT, year INTEGER, month INTEGER, day INTEGER, desc TEXT, status TEXT;
    for(var i=0; i < 12; i++) {
      firestoreService.addTaskMonthly(title: title, year: savedYear, desc: desc, month: savedMonth, day: 0).then((value) =>
      {
        firestoreService.updateTasksNumber(context),
        savedMonth = savedMonth +1,
        if (nMonth > 12) {savedYear = savedYear + 1}
      });
    }
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)  => const MyApp()), (Route<dynamic> route) => false);
    // Delete a record
  }

  weeklyAdding(context , title, times, description) async {
    if (times != ''){
      var savedMonth = nMonth, savedYear = nYear, savedDay = nDay;
      var numOfDays = getDaysInMonth(nYear, nMonth);
      for(var i=0; i < times; i++){
        if(numOfDays >= savedDay + 7){
          savedDay = savedDay + 7 ;
          firestoreService.addTaskWeekly(title: title, year: savedYear, desc: desc, month: savedMonth, day: savedMonth).then((value) =>
          {
            firestoreService.updateTasksNumber(context),
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)  => const MyApp()), (Route<dynamic> route) => false),
          });
        }else{
          savedDay = 7 - (numOfDays - savedDay) ;
          if (savedMonth == 12){
            savedMonth = 1;
            savedYear = savedYear + 1;
          }else{
            savedMonth = savedMonth + 1;
          }
        }
      }
    }
  }

  Future deleteTask(id) async {
    firestoreService.deleteNote(selectedid).then((value) => {
      emit(DeleteTaskState()),
    });
  }

  editTask(title,description,year,month,day){
    firestoreService.updateTask(id: selectedid, title: title, desc: description, year: year, month: month, day: day).then((value) => {
      selectedid= '',
      sTask = {},
      emit(UpdateTaskState()),
    });
  }

  userLogin({required email, required password, required context}) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      ).then((value) => {
          emit(SignInSuccessState()),
      });
    } on FirebaseAuthException catch  (e) {
      emit(SignInErrorState(e.message.toString()));
    }
  }

  userSignUp({required email, required password, required context}) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password
      ).then((value) => {
        firestoreService.addUser(id: auth.currentUser?.uid, email: email).then((value) => {
          emit(SignUpSuccessState()),
        }),
      });
    } on FirebaseAuthException catch  (e) {
      emit(SignUpErrorState(e.message.toString()));
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    firestoreService.addUser(id: auth.currentUser?.uid, email: auth.currentUser?.email).then((value) => {
      emit(SignInSuccessState()),
    });
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  logout(context) async {
    await FirebaseAuth.instance.signOut().then((value) => {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)  => const MyApp()), (Route<dynamic> route) => false)
    });
  }
  final img = ImagePicker();


  imagePicCamera() async{
    try {
      final image = await img.pickImage(source: ImageSource.camera);

      if(image == null) return;
      File imgfile = File(image.path);
      emit(ImagePickedState());
      uploadedImage(imgfile);
    } on PlatformException catch(e) {
      print('Failed to pick image: ${e.message}');
    }
  }

  imagePic() async{
    try {
      final image = await img.pickImage(source: ImageSource.gallery);
      if(image == null) return;
      File imgfile = File(image.path);
      emit(ImagePickedState());
      uploadedImage(imgfile);
    } on PlatformException catch(e) {
      print('Failed to pick image: $e');
    }
  }

  uploadedImage(File imgfile) async{
     firebase_storage.FirebaseStorage.instance
         .ref()
         .child('users/${auth.currentUser?.uid}profile.png')
         .putFile(imgfile).then((val) => {
       val.ref.getDownloadURL()
           .then((value) => {
         firestoreService.updateimg(newimg: value, id: auth.currentUser?.uid).then((value) => {
           emit(UploadImageState()),
         }),
       }),
     });
  }

  getUser(){
    firestoreService.getUserData().then((value) => {
      userData = value.data() as Map<String, dynamic>,
      emit(GetUserState()),
    });
  }

  updateUserName (name){
    firestoreService.updateName(newName: name, id: auth.currentUser?.uid).then((value) => {
      emit(UpdateNameState()),
    });
  }
}
