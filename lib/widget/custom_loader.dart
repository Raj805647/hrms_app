import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'help_widget.dart';

Widget customLoader({String message = 'Loading...'}) {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            // Outer rotating ring
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: 2 * 3.14159),
              duration: const Duration(seconds: 2),
              builder: (context, double angle, child) {
                return Transform.rotate(
                  angle: angle,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Colors.purple,
                          Colors.pink,
                          Colors.blue,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(60),
                    ),
                    child: Container(
                      margin: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(57),
                      ),
                    ),
                  ),
                );
              },
            ),

            // Lottie animation
            Lottie.network(
              'https://assets4.lottiefiles.com/packages/lf20_x62chJ.json',
              height: 100,
              repeat: true,
              reverse: true,
              animate: true,
            ),
          ],
        ),

        spaceHeight(24),

        Text(
          message,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.purple,
          ),
        ),

        spaceHeight(12),

        // Pulsing dots
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildPulsingDot(0),
            buildPulsingDot(1),
            buildPulsingDot(2),
          ],
        ),
      ],
    ),
  );
}

Widget buildPulsingDot(int index) {
  return TweenAnimationBuilder(
    tween: Tween<double>(begin: 0.5, end: 1.2),
    duration: Duration(milliseconds: 800 + (index * 200)),
    builder: (context, double scale, child) {
      return Transform.scale(
        scale: scale,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: 8,
          height: 8,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple, Colors.pink],
            ),
            shape: BoxShape.circle,
          ),
        ),
      );
    },
  );
}