import 'dart:math';
import 'package:flutter/material.dart';

import 'package:advanced_widgets/widgets/app_style_theme.dart';

class WeatherIconPainter extends CustomPainter {
  const WeatherIconPainter(
    this.context,
    this.width,
    this.height,
    this.factor,
    this.topImage,
    this.cloudOpacity,
  );
  final BuildContext context;
  final double width;
  final double height;
  final double factor;
  final double topImage;
  final double cloudOpacity;

  @override
  void paint(Canvas canvas, Size size) {
    _paintSun(canvas);
    _paintCloud(canvas);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegte) => false;

  void _paintSun(Canvas canvas) {
    if (cloudOpacity == 1.0) {
      return;
    }

    final sunRadius = 18.0;
    final sunTop = getSunTop(sunRadius, topImage, cloudOpacity, factor);

    final sunPaint = Paint()
      ..color = AppStyleTheme.of(context).iconSunColor
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(width / 2, sunTop), sunRadius * factor, sunPaint);
  }

  void _paintCloud(Canvas canvas) {
    final cloudPaint = Paint()
      ..color = getCloudColor(cloudOpacity)
      ..style = PaintingStyle.fill;

    final cloudWidth = 80.0 * factor;
    final cloudHeight = 20.0 * factor;
    final cloudLeft = (width - cloudWidth) / 2;
    final cloudTop = getCloudTop(18, topImage, cloudOpacity, factor);

    final rect = Rect.fromPoints(
      Offset(cloudLeft, cloudTop),
      Offset(cloudLeft + cloudWidth, cloudTop + cloudHeight),
    );
    final radius = Radius.circular(10 * factor);
    canvas.drawRRect(RRect.fromRectAndRadius(rect, radius), cloudPaint);

    final arcRect = Rect.fromPoints(
      Offset(cloudLeft + 28 * factor, cloudTop - 10 * factor),
      Offset(cloudLeft + cloudWidth - 14 * factor,
          cloudTop + cloudHeight - 10 * factor),
    );
    canvas.drawArc(arcRect, pi, pi, true, cloudPaint);

    if (cloudOpacity == 1.0) {
      _paintRain(canvas, cloudTop + cloudHeight);
    }
  }

  void _paintRain(Canvas canvas, double cloudTopSize) {
    final rainPaint = Paint()
      ..color = AppStyleTheme.of(context).iconTextColor
      ..style = PaintingStyle.fill;

    final rainCenter = width / 2;
    final rainTop = cloudTopSize + 2 * factor;

    final rainRect1 = Rect.fromPoints(
      Offset(rainCenter - 22 * factor, rainTop),
      Offset(rainCenter - 18 * factor, rainTop + 12 * factor),
    );
    canvas.drawOval(rainRect1, rainPaint);
    final rainRect2 = Rect.fromPoints(
      Offset(rainCenter - 2 * factor, rainTop),
      Offset(rainCenter + 2 * factor, rainTop + 12 * factor),
    );
    canvas.drawOval(rainRect2, rainPaint);
    final rainRect3 = Rect.fromPoints(
      Offset(rainCenter + 18 * factor, rainTop),
      Offset(rainCenter + 22 * factor, rainTop + 12 * factor),
    );
    canvas.drawOval(rainRect3, rainPaint);
  }
}

double getSunTop(
    double sunRadius, double topImage, double opacity, double factor) {
  var sunTop = topImage + sunRadius;

  if (opacity >= 0.2) {
    sunTop -= 4 * factor;
  }

  return sunTop;
}

double getCloudTop(
    double sunRadius, double topImage, double opacity, double factor) {
  var sunTop = getSunTop(18, topImage, opacity, factor);

  if (opacity < 1.0) {
    sunTop += 5 * factor;
  } else {
    sunTop -= 8 * factor;
  }

  return sunTop;
}

Color getCloudColor(double opacity) {
  final num = (opacity * 10).toInt();

  switch (num) {
    case 0:
    case 1:
      return Colors.white.withOpacity(0.0);
    case 2:
      return Colors.white.withOpacity(opacity * 1.5);
    case 3:
      return Colors.white.withOpacity(opacity * 1.5);
    case 4:
      return Colors.white.withOpacity(opacity * 1.5);
    case 5:
      return Colors.grey[300]!;
    case 6:
      return Colors.grey[400]!;
    case 7:
      return Colors.grey[500]!;
    case 8:
      return Colors.grey[700]!;
    case 9:
      return Colors.grey[900]!;
    case 10:
      return Colors.black;
    default:
      return Colors.black.withOpacity(0.0);
  }
}
