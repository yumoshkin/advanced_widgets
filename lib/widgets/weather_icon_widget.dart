import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:advanced_widgets/widgets/weather_icon_container.dart';

class WeatherIconWidget extends StatefulWidget {
  const WeatherIconWidget({
    Key? key,
    required this.cloudOpacity,
  }) : super(key: key);
  final double cloudOpacity;

  @override
  State<WeatherIconWidget> createState() => _WeatherIconWidgetState();
}

class _WeatherIconWidgetState extends State<WeatherIconWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  late Animation<double> widthAnimation;
  late Animation<double> heightAnimation;
  late Animation<double> factorAnimation;
  late Animation<double> topAnimation;
  Animation<double>? rightAnimation;
  late Animation<double> topImageAnimation;

  double widthBegin = 100;
  double widthEnd = 320;
  double heightBegin = 74;
  double heightEnd = 320;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );

    final curvedAnimation =
        CurvedAnimation(parent: controller, curve: Curves.ease);

    widthAnimation = Tween<double>(begin: widthBegin, end: widthEnd)
        .animate(curvedAnimation);
    heightAnimation = Tween<double>(begin: heightBegin, end: heightEnd)
        .animate(curvedAnimation);
    factorAnimation =
        Tween<double>(begin: 1, end: 3.0).animate(curvedAnimation);
    topAnimation = Tween<double>(begin: 12, end: 80).animate(curvedAnimation);
    topImageAnimation =
        Tween<double>(begin: 17, end: 80).animate(curvedAnimation);

    SchedulerBinding.instance.addPostFrameCallback((_) {
      rightAnimation = Tween<double>(
        begin: 10,
        end: (MediaQuery.of(context).size.width - widthEnd) / 2,
      ).animate(curvedAnimation);
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return GestureDetector(
          onTap: () => controller.forward(),
          child: WeatherIconContainer(
            cloudOpacity: widget.cloudOpacity,
            controller: controller,
            width: widthAnimation.value,
            height: heightAnimation.value,
            factor: factorAnimation.value,
            top: topAnimation.value,
            right: rightAnimation != null ? rightAnimation!.value : 10,
            topImage: topImageAnimation.value,
          ),
        );
      },
    );
  }
}
