import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nezam/shared/constants.dart';
import 'package:nezam/shared/cubit/states.dart';
import 'package:sqflite/sqflite.dart';
import '../../generated/l10n.dart';
import '../../main.dart';



class AppCubit extends Cubit<States> {
  AppCubit() : super(AppInitial());
  final DATABASE_NAME = 'todoo.db';
  var selectedRadio,title,desc,date;
  static AppCubit get(context) => BlocProvider.of(context);
  String stringLang = 'ar';
  List<Map> tasks = [];
  var repeat;
  var weaklyDays=[];

  // Create and open the Database
  void createDataBase() {
    Object database;

    database =  openDatabase(
      DATABASE_NAME,
      version: 1,
      onCreate: (database, version) {
        database.execute('CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, year INTEGER, month INTEGER, day INTEGER, desc TEXT, status TEXT, tType TEXT)');
      },
      onOpen: (database) {
        getDataFromDB(database);
      },
    ).then((value) => {
      database = value,
      emit(CreateDBState()),
    });
  }

  // Insert task to database
  insertToDB({required String title, required String date, required String desc,})  async {
    var db = await openDatabase(DATABASE_NAME,version: 1);
    var d = date.split('-');
    var year = d[0],month = d[1], day = d[2];
    await db.transaction((txn)  => txn.rawInsert(
        'INSERT INTO tasks (title, year, month, day, desc, status ,tType) VALUES ("$title", "$year", "$month", "$day", "$desc", "new", "onTime")'
    )).then((value) => {
    getDataFromDB(db),

    });

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
  onChangeButtonPressed({required String status, required int id}) async {
    var db = await openDatabase(DATABASE_NAME,version: 1);
    String newStatus = status == 'done' ? 'new' : 'done';
    try {
      await db.rawUpdate(
          'UPDATE tasks SET status = ? WHERE id = ?', [newStatus, id]);
      getDataFromDB(db);
      emit(ChangeButtonPressedState());
    } catch (e) {
      print('Failed to update status: $e');
    }
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
      var db = await openDatabase(DATABASE_NAME,version: 1,);
      var count = [1,2,3,4,5,6,7,8,9,10,11,12];
        for(var ee in count) {
          await db.transaction((txn)  => txn.rawInsert(
              'INSERT INTO tasks (title, year, month, day, desc, status ,tType) VALUES ("$title", "$eyear", 0, 0, "$desc", "new", "Yearly")'
          ));
          eyear = eyear +1;
        }
    getDataFromDB(db);
    Navigator.push(context,
      MaterialPageRoute(builder: (context) =>
      const MyApp(),
      ),
    );
      // Delete a record
  }

  monthlyAdding(context ,String title, String desc) async {

    var savedMonth = nMonth,savedYear = nYear;
    //    title TEXT, year INTEGER, month INTEGER, day INTEGER, desc TEXT, status TEXT;
    var db = await openDatabase(DATABASE_NAME,version: 1,);
    var count = [1,2,3,4,5,6,7,8,9,10,11,12];
    for(var ee in count) {
      await db.transaction((txn)  => txn.rawInsert(
          'INSERT INTO tasks (title, year, month, day, desc, status ,tType) VALUES ("$title", "$savedYear", "$savedMonth", 0, "$desc", "new", "Monthly")'
      )).then((value) => {
          savedMonth = savedMonth +1,
          if (nMonth > 12) {savedYear = savedYear + 1}
      });
    }
    getDataFromDB(db);
    Navigator.push(context,
      MaterialPageRoute(builder: (context) =>
      const MyApp(),
      ),
    );
    // Delete a record
  }
  static int getDaysInMonth(int year, int month) {
    if (month == DateTime.february) {
      final bool isLeapYear = (year % 4 == 0) && (year % 100 != 0) || (year % 400 == 0);
      return isLeapYear ? 29 : 28;
    }
    const List<int> daysInMonth = <int>[31, -1, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    return daysInMonth[month - 1];
  }
  var cselectedRadio = '';

  weeklyAdding(context , title, times, description) async {
    var db = await openDatabase(DATABASE_NAME,version: 1,);

    if (times != ''){
      var random = List<int>.generate(int.parse(times), (n) => n );
      var savedMonth = nMonth, savedYear = nYear, savedDay = nDay;
      var numOfDays = getDaysInMonth(nYear, nMonth);

      for(var e in random){
        if(numOfDays >= savedDay + 7){
          savedDay = savedDay + 7 ;
          await db.transaction((txn)  => txn.rawInsert(
              'INSERT INTO tasks (title, year, month, day, desc, status ,tType) VALUES ("$title", "$savedYear", "$savedMonth", "$savedDay", "$desc", "new", "Weekly")'
          )).then((value) => {
             getDataFromDB(db),
          Navigator.push(context,
          MaterialPageRoute(builder: (context) =>
          const MyApp()))
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





}

