import 'package:flutter/material.dart';

class MenuItem {
  String label;
  String value;
  MenuItem({required this.label, required this.value});
}

final items = [
  MenuItem(label: 'Темная', value: 'dark'),
  MenuItem(label: 'Светлая', value: 'light'),
];

class ThemeDropdownButton extends StatelessWidget {
  const ThemeDropdownButton({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);
  final String value;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black54),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButton(
        value: value,
        items: items.map(
          (item) {
            return DropdownMenuItem(
              value: item.value,
              child: Text(
                item.label,
                style: TextStyle(
                  color: Colors.grey[800],
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            );
          },
        ).toList(),
        onChanged: (value) => onChanged(value),
      ),
    );
  }
}
