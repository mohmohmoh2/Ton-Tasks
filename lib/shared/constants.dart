import 'dart:ui';
import 'package:intl/intl.dart';

List<Map> task = [];

var userCredintials;

var selectedTitle,selectedDesc,selectedYear,selectedDay,selectedMonth,selectedStatus,selectedType,selectedid;
var cselectedRadio = '';

// Home Page Date
var now = DateTime.now();


var nYear = int.parse(formatyear.format(now));
var nMonth = int.parse(formatmonth.format(now));
var nDay = int.parse(formatday.format(now));

var formatter = DateFormat('yyyy-MM-dd');
var formatyear = DateFormat('yyyy');
var formatmonth = DateFormat('MM');
var formatday = DateFormat('dd');
String formattedDate = formatter.format(now);
List<String> date = formattedDate.split("-");
List<String> emonth = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'June', 'July', 'Aug', 'Sept', 'Oct', 'Nov', 'Dec'];

int nowYear = int.parse(date[0]);
int nowMonth = int.parse(date[1]) - 1;
int nowDay = int.parse(date[2]);


var mainColor = const Color(0xffE8EEF6);
var color1 = const Color.fromRGBO(67, 120, 219, 0.16);
var color2 =  const Color(0xff405DB5);
var color3 =  const Color(0xff21205A);
var color4 =  const Color(0xff1B68F3);
var screenBackgroundColor =  mainColor;

List<String> daysEn = ['Friday', 'Saturday', 'Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday'];