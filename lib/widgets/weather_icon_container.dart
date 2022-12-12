import 'package:flutter/material.dart';

import 'package:advanced_widgets/widgets/app_style_theme.dart';
import 'package:advanced_widgets/widgets/weather_icon_painter.dart';

class WeatherIconContainer extends StatelessWidget {
  const WeatherIconContainer({
    Key? key,
    required this.cloudOpacity,
    required this.controller,
    required this.width,
    required this.height,
    required this.factor,
    required this.top,
    required this.right,
    required this.topImage,
  }) : super(key: key);
  final double cloudOpacity;
  final AnimationController controller;
  final double width;
  final double height;
  final double factor;
  final double top;
  final double right;
  final double topImage;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned(
        top: top,
        right: right,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: AppStyleTheme.of(context).iconBackgroundColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Stack(
            children: [
              _buildIconImage(context),
              _buildIconText(context),
              _buildIconCloseIcon(context),
            ],
          ),
        ),
      ),
    ]);
  }

  Widget _buildIconImage(BuildContext context) {
    return CustomPaint(
      painter: WeatherIconPainter(
        context,
        width,
        height,
        factor,
        topImage,
        cloudOpacity,
      ),
    );
  }

  Widget _buildIconText(BuildContext context) {
    if (factor >= 2.98) {
      return Positioned(
        top: 190,
        left: 24,
        child: Text(
          _getWeatherText(cloudOpacity),
          style: TextStyle(
            fontSize: 48,
            color: AppStyleTheme.of(context).iconTextColor,
          ),
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }

  Widget _buildIconCloseIcon(BuildContext context) {
    if (factor >= 2.98) {
      return Positioned(
        right: 2,
        child: IconButton(
          onPressed: () => controller.reset(),
          icon: Icon(
            Icons.close,
            color: AppStyleTheme.of(context).iconTextColor,
            size: 30,
          ),
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }

  String _getWeatherText(double opacity) {
    var result = '';

    if (opacity < 0.2) {
      result = 'Ясно';
    } else if (opacity >= 0.2 && opacity < 1.0) {
      result = 'Облачно';
    } else if (opacity == 1.0) {
      result = 'Дождь';
    }

    return '$result,\n12 градусов';
  }
}
