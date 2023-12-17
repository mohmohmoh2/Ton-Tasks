import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'generated/l10n.dart';
import 'mainScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var myLocale = Intl.getCurrentLocale();
    return  MaterialApp(
      title: ' TON Tasks ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: myLocale == "en" ? GoogleFonts.poppins().fontFamily : GoogleFonts.cairo().fontFamily,
      ),
      home: const MainScreen(),
        locale: const Locale('ar', ''),
        localizationsDelegates: const [
          S.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,

          // ... app-specific localization delegate[s] here
        ],
        supportedLocales: S.delegate.supportedLocales,
        initialRoute: "/",
    );
  }
}
