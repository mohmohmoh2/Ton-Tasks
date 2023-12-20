import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'generated/l10n.dart';
import 'layout/registration/sign_in.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Ideal time to initialize
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
      home: SignIn(),
        locale: const Locale('en', ''),
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
