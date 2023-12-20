import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:nezam/shared/constants.dart';
import 'package:nezam/shared/cubit/states.dart';
import 'package:sqflite/sqflite.dart';
import '../../generated/l10n.dart';
import '../../main.dart';
import '../firestrore.dart';


final FirestoreService firestoreService = FirestoreService();
class AppCubit extends Cubit<States> {
  AppCubit() : super(AppInitial());
  final DATABASE_NAME = 'todoo.db';
  var selectedRadio,title,desc,date;
  static AppCubit get(context) => BlocProvider.of(context);
  String stringLang = 'ar';
  List<Map> tasks = [];
  var repeat,element;
  var weaklyDays=[];

  static int getDaysInMonth(int year, int month) {
    if (month == DateTime.february) {
      final bool isLeapYear = (year % 4 == 0) && (year % 100 != 0) || (year % 400 == 0);
      return isLeapYear ? 29 : 28;
    }
    const List<int> daysInMonth = <int>[31, -1, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    return daysInMonth[month - 1];
  }

  Future insertToDB({required String title, required date, required String desc,})  async {
    print(date);
    //firestoreService.addNote(title: title, date: date, desc: desc);
  }

  // Get all data from database
  void getDataFromDB(dbb) {
    emit(GetDataFromDBState());
    dbb.rawQuery('SELECT * FROM tasks').then((value) {
      tasks = value;
      task = value;
      emit(GetDataFromDBState());
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
      S.load(const Locale('ar', ''));
      emit(ChangeBTMState());
    }else if(Intl.getCurrentLocale() == 'ar'){
      S.load(const Locale('en', ''));
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

  test(){
      var done = false;
  var now = DateTime.now();
  var formatter = DateFormat('EEEE');
  String formattedDate = formatter.format(now);
var list = 1;

// ['Friday', 'Saturday', 'Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday'];
  for (var element in daysEn ) {
    if(element != formattedDate && done == false){
        list = list + 1;
    }else if(element == formattedDate){
      done = true;
    }
  }
  //var first = daysEn.getRange(0, list);

  //var f = daysEn.addAll(first);
  daysEn.removeRange(0, list);

}

  yearlyAdding(context ,String title, String desc) async {
    var eyear = nYear;
    //    title TEXT, year INTEGER, month INTEGER, day INTEGER, desc TEXT, status TEXT;
      var count = [1,2,3,4,5,6,7,8,9,10,11,12];
      for(var ee in count) {
          firestoreService.addTaskYearly(title: title, year: eyear, desc: desc, month: 0, day: 0);
          eyear = eyear +1;
        }
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)  => const MyApp()), (Route<dynamic> route) => false);
  }

  monthlyAdding(context ,String title, String desc) async {

    var savedMonth = nMonth,savedYear = nYear;
    //    title TEXT, year INTEGER, month INTEGER, day INTEGER, desc TEXT, status TEXT;
    var db = await openDatabase(DATABASE_NAME,version: 1,);
    var count = [1,2,3,4,5,6,7,8,9,10,11,12];
    for(var ee in count) {
      firestoreService.addTaskMonthly(title: title, year: savedYear, desc: desc, month: savedMonth, day: 0).then((value) =>
      {
        savedMonth = savedMonth +1,
        if (nMonth > 12) {savedYear = savedYear + 1}
      });

    }
    getDataFromDB(db);
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)  => const MyApp()), (Route<dynamic> route) => false);
    // Delete a record
  }


  weeklyAdding(context , title, times, description) async {
    var db = await openDatabase(DATABASE_NAME,version: 1,);

    if (times != ''){
      var random = List<int>.generate(int.parse(times) +1 , (n) => n );
      var savedMonth = nMonth, savedYear = nYear, savedDay = nDay;
      var numOfDays = getDaysInMonth(nYear, nMonth);

      for(var e in random){
        if(numOfDays >= savedDay + 7){
          savedDay = savedDay + 7 ;
          firestoreService.addTaskWeekly(title: title, year: savedYear, desc: desc, month: savedMonth, day: savedMonth).then((value) =>

          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)  => const MyApp()), (Route<dynamic> route) => false)


          );
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
  var numDay=[];

  weekly(index){
    // [Friday, Saturday, Sunday, Monday, Tuesday, Wednesday, Thursday]
    var numDays = ['8', '9', '10', '11', '12', '13', '14'];
    var day = daysEn[index];

    if(weaklyDays.contains(day)){
      weaklyDays.remove(day);
      numDay.remove(numDays[index]);

    }else{
      weaklyDays.add(day);
      numDay.add(numDays[index]);
    }

    emit(WeaklyState());
  }


  getViewData(context, id) async {


  }

  Future deleteTask(id) async {
    var db = openDatabase(DATABASE_NAME,version: 1,);
    print(id);
    db.then((value) => {
      value.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) => {
        getDataFromDB(value),
        emit(DeleteState()),
      })
    });

  }

  editTask(title,description,year,month,day){
    print(title);
    print(description);
    print(year);
    print(month);
    print(day);
  }

  userLogin({required email, required password, required context}) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      ).then((value) => {
          print('User Info: ${FirebaseAuth.instance.currentUser}'),
          print(value.user!.uid),
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
          print('User Info: ${FirebaseAuth.instance.currentUser}'),
        print(value.user!.uid),
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

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

}

