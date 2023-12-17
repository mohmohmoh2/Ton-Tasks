// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Ton Tasks`
  String get title {
    return Intl.message(
      'Ton Tasks',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get today {
    return Intl.message(
      'Today',
      name: 'today',
      desc: '',
      args: [],
    );
  }

  /// `Arabic`
  String get arabic {
    return Intl.message(
      'Arabic',
      name: 'arabic',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `New Task`
  String get newTask {
    return Intl.message(
      'New Task',
      name: 'newTask',
      desc: '',
      args: [],
    );
  }

  /// `Task Title`
  String get taskTitleHint {
    return Intl.message(
      'Task Title',
      name: 'taskTitleHint',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get dateHint {
    return Intl.message(
      'Date',
      name: 'dateHint',
      desc: '',
      args: [],
    );
  }

  /// `Task Description`
  String get descriptionHint {
    return Intl.message(
      'Task Description',
      name: 'descriptionHint',
      desc: '',
      args: [],
    );
  }

  /// `Empty`
  String get empty {
    return Intl.message(
      'Empty',
      name: 'empty',
      desc: '',
      args: [],
    );
  }

  /// `Write The Task Title Please`
  String get AlertTitle {
    return Intl.message(
      'Write The Task Title Please',
      name: 'AlertTitle',
      desc: '',
      args: [],
    );
  }

  /// `Write The Task Description Please`
  String get AlertDescription {
    return Intl.message(
      'Write The Task Description Please',
      name: 'AlertDescription',
      desc: '',
      args: [],
    );
  }

  /// `Choose The Task Date Please`
  String get AlertDate {
    return Intl.message(
      'Choose The Task Date Please',
      name: 'AlertDate',
      desc: '',
      args: [],
    );
  }

  /// `Write The Task Times Please`
  String get AlertTimes {
    return Intl.message(
      'Write The Task Times Please',
      name: 'AlertTimes',
      desc: '',
      args: [],
    );
  }

  /// `Yearly Task Configuration`
  String get AddYearlyTitle {
    return Intl.message(
      'Yearly Task Configuration',
      name: 'AddYearlyTitle',
      desc: '',
      args: [],
    );
  }

  /// `Specify how often your task should repeat each year.`
  String get AddYearlySub {
    return Intl.message(
      'Specify how often your task should repeat each year.',
      name: 'AddYearlySub',
      desc: '',
      args: [],
    );
  }

  /// `Monthly Task Configuration`
  String get AddMonthlyTitle {
    return Intl.message(
      'Monthly Task Configuration',
      name: 'AddMonthlyTitle',
      desc: '',
      args: [],
    );
  }

  /// `Specify how often your task should repeat each month.`
  String get AddMonthlySub {
    return Intl.message(
      'Specify how often your task should repeat each month.',
      name: 'AddMonthlySub',
      desc: '',
      args: [],
    );
  }

  /// `Weekly Task Configuration`
  String get AddWeeklyTitle {
    return Intl.message(
      'Weekly Task Configuration',
      name: 'AddWeeklyTitle',
      desc: '',
      args: [],
    );
  }

  /// `Specify how often your task should repeat each week.`
  String get AddWeeklySub {
    return Intl.message(
      'Specify how often your task should repeat each week.',
      name: 'AddWeeklySub',
      desc: '',
      args: [],
    );
  }

  /// `Yearly`
  String get YearlyRadioTitle {
    return Intl.message(
      'Yearly',
      name: 'YearlyRadioTitle',
      desc: '',
      args: [],
    );
  }

  /// `Schedule your yearly tasks`
  String get YearlyRadioSub {
    return Intl.message(
      'Schedule your yearly tasks',
      name: 'YearlyRadioSub',
      desc: '',
      args: [],
    );
  }

  /// `Monthly`
  String get monthlyRadioTitle {
    return Intl.message(
      'Monthly',
      name: 'monthlyRadioTitle',
      desc: '',
      args: [],
    );
  }

  /// `Schedule your monthly tasks`
  String get monthlyRadioSub {
    return Intl.message(
      'Schedule your monthly tasks',
      name: 'monthlyRadioSub',
      desc: '',
      args: [],
    );
  }

  /// `Weekly`
  String get weeklyRadioTitle {
    return Intl.message(
      'Weekly',
      name: 'weeklyRadioTitle',
      desc: '',
      args: [],
    );
  }

  /// `Schedule your weekly tasks`
  String get weeklyRadioSub {
    return Intl.message(
      'Schedule your weekly tasks',
      name: 'weeklyRadioSub',
      desc: '',
      args: [],
    );
  }

  /// `Repeatable Task Frequency`
  String get repeatTypeTitle {
    return Intl.message(
      'Repeatable Task Frequency',
      name: 'repeatTypeTitle',
      desc: '',
      args: [],
    );
  }

  /// `Set the frequency for your repeating task.`
  String get repeatTypeSub {
    return Intl.message(
      'Set the frequency for your repeating task.',
      name: 'repeatTypeSub',
      desc: '',
      args: [],
    );
  }

  /// `Choose the type of task`
  String get typeOfTaskTitle {
    return Intl.message(
      'Choose the type of task',
      name: 'typeOfTaskTitle',
      desc: '',
      args: [],
    );
  }

  /// `To give you a better experience we need to know your schedule type.`
  String get typeOfTaskSub {
    return Intl.message(
      'To give you a better experience we need to know your schedule type.',
      name: 'typeOfTaskSub',
      desc: '',
      args: [],
    );
  }

  /// `One Time`
  String get oneTime {
    return Intl.message(
      'One Time',
      name: 'oneTime',
      desc: '',
      args: [],
    );
  }

  /// `Repeatable`
  String get Repeatable {
    return Intl.message(
      'Repeatable',
      name: 'Repeatable',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Repeat Times`
  String get repeatTimes {
    return Intl.message(
      'Repeat Times',
      name: 'repeatTimes',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
