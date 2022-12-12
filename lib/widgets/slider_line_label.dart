import 'package:flutter/material.dart';

class SliderLineLabel extends StatelessWidget {
  const SliderLineLabel(
      {Key? key, required this.indexTop, required this.labels})
      : super(key: key);
  final double indexTop;
  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _labelListBuilder<String>(
          labels,
          (index, label) {
            final selectedColor = Colors.brown;
            final unselectedColor = Colors.black.withOpacity(0.3);
            final isSelected = index / 10 == indexTop;
            final color = isSelected ? selectedColor : unselectedColor;

            return _buildLabel(label: label, color: color, width: 30);
          },
        ),
      ),
    );
  }

  Widget _buildLabel({
    required String label,
    required double width,
    required Color color,
  }) {
    return Container(
      width: width,
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ).copyWith(color: color),
      ),
    );
  }

  List<Widget> _labelListBuilder<T>(
      List<T> models, Widget Function(int index, T model) builder) {
    return models
        .asMap()
        .map<int, Widget>(
            (index, model) => MapEntry(index, builder(index, model)))
        .values
        .toList();
  }
}
