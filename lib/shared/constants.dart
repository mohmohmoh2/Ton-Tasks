import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

import 'firestrore.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
Map<String, dynamic> sTask = {};

var imagePath = '';

var selectedYear,selectedDay,selectedMonth,selectedid;
var cselectedRadio = '';

var userData = {};
final FirestoreService firestoreService = FirestoreService();

// Home Page Date
var now = DateTime.now();

var nYear = int.parse(formatyear.format(now));
var nMonth = int.parse(formatmonth.format(now));
var nDay = int.parse(formatday.format(now));

var formatyear = DateFormat('yyyy');
var formatmonth = DateFormat('MM');
var formatday = DateFormat('dd');

var mainColor = const Color(0xffE8EEF6);
var screenBackgroundColor =  mainColor;
var color1 = const Color.fromRGBO(67, 120, 219, 0.16);
var color2 =  const Color(0xff405DB5);
var color3 =  const Color(0xff21205A);
var color4 =  const Color(0xff1B68F3);
var bgButton =  const Color(0xff8687E7);

List<String> daysEn = ['Friday', 'Saturday', 'Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday'];