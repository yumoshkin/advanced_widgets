import 'package:flutter/material.dart';

import 'package:advanced_widgets/widgets/app_style_theme.dart';
import 'package:advanced_widgets/widgets/theme_dropdown_button.dart';

class ThemeSwitcherWidget extends StatelessWidget {
  const ThemeSwitcherWidget({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);
  final String value;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 16, bottom: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black54),
        borderRadius: BorderRadius.circular(8),
        color: AppStyleTheme.of(context).appPanelColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(width: 16),
          Text(
            'Тема',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          SizedBox(width: 16),
          ThemeDropdownButton(value: value, onChanged: onChanged),
          SizedBox(width: 16),
        ],
      ),
    );
  }
}
