import 'package:flutter/material.dart';

import 'package:advanced_widgets/widgets/app_style_theme.dart';
import 'package:advanced_widgets/widgets/slider_label_widget.dart';
import 'package:advanced_widgets/widgets/theme_switcher_widget.dart';
import 'package:advanced_widgets/widgets/weather_icon_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool isShowSettings = false;
  String themeName = 'dark';
  double cloudOpacity = 0.0;

  void changeIconTheme(String value) {
    setState(() {
      themeName = value;
    });
  }

  void changeCloudOpacity(double value) {
    setState(() {
      cloudOpacity = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppStyleTheme(
      theme: appThemes[themeName]!,
      child: Builder(
        builder: (innerContext) => Scaffold(
          backgroundColor: AppStyleTheme.of(innerContext).appBackgroundColor,
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: WeatherIconWidget(cloudOpacity: cloudOpacity),
                ),
                if (isShowSettings)
                  Column(
                    children: [
                      SizedBox(height: 16),
                      SliderLabelWidget(
                        cloudOpacity: cloudOpacity,
                        onChanged: changeCloudOpacity,
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          SizedBox(width: 16),
                          ThemeSwitcherWidget(
                            value: themeName,
                            onChanged: changeIconTheme,
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                    ],
                  ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppStyleTheme.of(innerContext).appButtonColor,
            onPressed: () => setState(() {
              isShowSettings = !isShowSettings;
            }),
            child: Icon(
              Icons.settings,
              color: isShowSettings ? Colors.white54 : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
