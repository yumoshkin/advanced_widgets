import 'package:flutter/material.dart';

import 'package:advanced_widgets/widgets/app_style_theme.dart';
import 'package:advanced_widgets/widgets/slider_line_label.dart';
import 'package:advanced_widgets/widgets/slider_line_mark.dart';

class SliderLabelWidget extends StatefulWidget {
  SliderLabelWidget({required this.cloudOpacity, required this.onChanged});
  final double cloudOpacity;
  final Function onChanged;

  @override
  _SliderLabelWidgetState createState() => _SliderLabelWidgetState();
}

class _SliderLabelWidgetState extends State<SliderLabelWidget> {
  double indexTop = 0.0;

  @override
  void initState() {
    super.initState();
    indexTop = widget.cloudOpacity;
  }

  void handleChange(double value) {
    setState(() {
      indexTop = value;
    });
    widget.onChanged(value);
  }

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderThemeData(
        thumbColor: Colors.orange[900],
        activeTrackColor: Colors.orange[900],
      ),
      child: _buildSliderTopLabel(),
    );
  }

  Widget _buildSliderTopLabel() {
    final labels = List<String>.generate(10, (int index) => '0.$index')
      ..add('1.0');

    final min = 0.0;
    final max = 1.0;
    final divisions = 10;

    return Container(
      width: MediaQuery.of(context).size.width - 32,
      padding: EdgeInsets.only(top: 16, bottom: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black54),
        borderRadius: BorderRadius.circular(8),
        color: AppStyleTheme.of(context).appPanelColor,
      ),
      child: Column(
        children: [
          Text(
            'Индикатор облачности',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          SizedBox(height: 8),
          SliderLineMark(),
          SizedBox(height: 8),
          SliderLineLabel(indexTop: indexTop, labels: labels),
          Slider(
            value: indexTop,
            min: min,
            max: max,
            divisions: divisions,
            onChanged: handleChange,
          ),
        ],
      ),
    );
  }
}
