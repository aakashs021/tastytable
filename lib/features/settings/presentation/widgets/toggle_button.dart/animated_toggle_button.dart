import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math';

import 'package:tastytable/features/settings/presentation/cubit/theme_cubit.dart';

class AnimatedToggleSwitch extends StatefulWidget {
  @override
  _AnimatedToggleSwitchState createState() => _AnimatedToggleSwitchState();
}

class _AnimatedToggleSwitchState extends State<AnimatedToggleSwitch>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleSwitch() {
    context.read<ThemeCubit>().toggleTheme(); // Toggle theme using Cubit
  }

  @override
  Widget build(BuildContext context) {
    final isSwitched = context.watch<ThemeCubit>().state ==
        ThemeMode.dark; // Get current theme mode

    return GestureDetector(
      onTap: _toggleSwitch,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        height: 30.0,
        width: 60.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: isSwitched ? Colors.transparent : Colors.grey.shade700,
        ),
        child: Stack(
          children: <Widget>[
            if (isSwitched)
              LightMode(animationController: _animationController),
            if (!isSwitched)
              DarkMode(animationController: _animationController),
            AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeIn,
              top: 3.0,
              left: isSwitched ? 30.0 : 0.0,
              right: isSwitched ? 0.0 : 30.0,
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return RotationTransition(
                    turns: animation,
                    child: Center(child: child),
                  );
                },
                child: isSwitched
                    ? Icon(
                        Icons.sunny,
                        color: Colors.white,
                        key: UniqueKey(),
                      )
                    : Icon(
                        Icons.dark_mode_outlined,
                        color: Colors.white,
                        key: UniqueKey(),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LightMode extends StatelessWidget {
  final AnimationController animationController;

  LightMode({required this.animationController});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          gradient: LinearGradient(
            colors: [Colors.orange.shade300, Colors.yellow.shade100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            // Pulsing sun animation
            Positioned(
              top: 10,
              left: 15,
              child: AnimatedBuilder(
                animation: animationController,
                builder: (context, child) {
                  return Transform.scale(
                    scale: 1 + 0.2 * sin(animationController.value * 2 * pi),
                    child: Icon(Icons.wb_sunny,
                        size: 50, color: Colors.orange.shade200),
                  );
                },
              ),
            ),
            // Add bird silhouettes
            Positioned(
              top: 60,
              left: 10,
              child: Icon(
                Icons.flight_takeoff,
                size: 20,
                color: Colors.white.withValues(alpha: 0.6),
              ),
            ),
            Positioned(
              top: 90,
              left: 120,
              child: Icon(
                Icons.flight_takeoff,
                size: 20,
                color: Colors.white.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DarkMode extends StatelessWidget {
  final AnimationController animationController;

  DarkMode({required this.animationController});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      right: 5,
      bottom: 0,
      child: Container(
        width: 30,
        child: AnimatedBuilder(
          animation: animationController,
          builder: (context, child) {
            return CustomPaint(
              painter: StarryBackgroundPainter(animationController.value),
            );
          },
        ),
      ),
    );
  }
}

class StarryBackgroundPainter extends CustomPainter {
  final double animationValue;
  StarryBackgroundPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.5 + 0.5 * animationValue)
      ..style = PaintingStyle.fill;

    final List<Offset> starPositions = [
      Offset(14, 10),
      Offset(3, 5),
      Offset(8, 20),
      Offset(20, 20),
      Offset(27, 10)
    ];

    final List<double> starSizes = [1.2, 1.8, 1.0, 1.3, 1.2];

    for (int i = 0; i < starPositions.length; i++) {
      // Twinkling effect: random opacity for each star
      paint.color = Colors.white.withValues(
        alpha: 0.5 + 0.5 * (sin(animationValue * pi * (i + 1)) + 1) / 2,
      );
      canvas.drawCircle(starPositions[i], starSizes[i], paint);
    }
  }

  @override
  bool shouldRepaint(covariant StarryBackgroundPainter oldDelegate) => true;
}
