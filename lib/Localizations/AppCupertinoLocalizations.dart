import 'package:flutter/cupertino.dart';

class AppCupertinoLocalizations extends CupertinoLocalizations {
  final CupertinoLocalizations _localizations;

  AppCupertinoLocalizations(this._localizations);


  static const List<String> _months = <String>[
    '1月',
    '2月',
    '3月',
    '4月',
    '5月',
    '6月',
    '7月',
    '8月',
    '9月',
    '10月',
    '11月',
    '12月',
  ];

  @override
  String get alertDialogLabel => _localizations.alertDialogLabel;

  @override
  String get anteMeridiemAbbreviation => _localizations.anteMeridiemAbbreviation;

  @override
  String get copyButtonLabel => _localizations.copyButtonLabel;

  @override
  String get cutButtonLabel => _localizations.cutButtonLabel;

  @override
  DatePickerDateOrder get datePickerDateOrder => DatePickerDateOrder.ymd;

  @override
  DatePickerDateTimeOrder get datePickerDateTimeOrder => _localizations.datePickerDateTimeOrder;

  @override
  String datePickerDayOfMonth(int dayIndex) => _localizations.datePickerDayOfMonth(dayIndex);

  @override
  String datePickerHour(int hour) => _localizations.datePickerHour(hour);

  @override
  String? datePickerHourSemanticsLabel(int hour) => _localizations.datePickerHourSemanticsLabel(hour);

  @override
  String datePickerMediumDate(DateTime date) => _localizations.datePickerMediumDate(date);

  @override
  String datePickerMinute(int minute) => _localizations.datePickerMinute(minute);

  @override
  String? datePickerMinuteSemanticsLabel(int minute) => _localizations.datePickerMinuteSemanticsLabel(minute);

  @override
  String datePickerMonth(int monthIndex) => _months[monthIndex - 1];

  @override
  String datePickerYear(int yearIndex) =>
      _localizations.datePickerYear(yearIndex);

  @override
  String get modalBarrierDismissLabel =>
      _localizations.modalBarrierDismissLabel;

  @override
  String get pasteButtonLabel => _localizations.pasteButtonLabel;

  @override
  String get postMeridiemAbbreviation =>
      _localizations.postMeridiemAbbreviation;

  @override
  String get searchTextFieldPlaceholderLabel =>
      _localizations.searchTextFieldPlaceholderLabel;

  @override
  String get selectAllButtonLabel =>
      _localizations.selectAllButtonLabel;

  @override
  String tabSemanticsLabel({required int tabIndex, required int tabCount}) =>
      _localizations.tabSemanticsLabel(
          tabIndex: tabIndex, tabCount: tabCount);

  @override
  String timerPickerHour(int hour) =>
      _localizations.timerPickerHour(hour);

  @override
  String? timerPickerHourLabel(int hour) =>
      _localizations.timerPickerHourLabel(hour);

  @override
  List<String> get timerPickerHourLabels =>
      _localizations.timerPickerHourLabels;

  @override
  String timerPickerMinute(int minute) =>
      _localizations.timerPickerMinute(minute);

  @override
  String? timerPickerMinuteLabel(int minute) =>
      _localizations.timerPickerMinuteLabel(minute);

  @override
  List<String> get timerPickerMinuteLabels => _localizations.timerPickerMinuteLabels;

  @override
  String timerPickerSecond(int second) => _localizations.timerPickerSecond(second);

  @override
  String? timerPickerSecondLabel(int second) => _localizations.timerPickerSecondLabel(second);

  @override
  List<String> get timerPickerSecondLabels => _localizations.timerPickerSecondLabels;

  @override
  String get todayLabel => _localizations.todayLabel;

}