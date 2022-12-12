import 'package:flutter/material.dart';

class MyAppTheme {
  final Color appBackgroundColor;
  final Color appButtonColor;
  final Color appPanelColor;
  final Color iconBackgroundColor;
  final Color iconSunColor;
  final Color iconTextColor;

  MyAppTheme({
    required this.appBackgroundColor,
    required this.appButtonColor,
    required this.appPanelColor,
    required this.iconBackgroundColor,
    required this.iconSunColor,
    required this.iconTextColor,
  });
}

final Map<String, MyAppTheme> appThemes = {
  'dark': MyAppTheme(
    appBackgroundColor: Colors.black,
    appButtonColor: Colors.blueGrey[300]!,
    appPanelColor: Colors.grey[200]!,
    iconBackgroundColor: Colors.blue[800]!,
    iconSunColor: Colors.yellow,
    iconTextColor: Colors.grey[300]!,
  ),
  'light': MyAppTheme(
    appBackgroundColor: Colors.white,
    appButtonColor: Colors.teal[300]!,
    appPanelColor: Colors.teal[50]!,
    iconBackgroundColor: Colors.blue[400]!,
    iconSunColor: Colors.yellowAccent,
    iconTextColor: Colors.white,
  ),
};

class AppStyleTheme extends InheritedWidget {
  final MyAppTheme theme;

  AppStyleTheme({
    required this.theme,
    required Widget child,
    Key? key,
  }) : super(child: child, key: key);

  static MyAppTheme of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<AppStyleTheme>();
    assert(result != null, 'No AppStyleTheme found in context');
    return result!.theme;
  }

  @override
  bool updateShouldNotify(AppStyleTheme old) => theme != old.theme;
}
