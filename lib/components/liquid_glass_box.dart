import 'dart:ui';

import 'package:flutter/material.dart';

class LiquidGlassBox extends StatelessWidget {
  const LiquidGlassBox({super.key, required this.width, required this.height, required this.child, required this.top, required this.left});
  final double width;
  final double height;
  final Widget child;
  final double top;
  final double left;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      width: width,
      height: height,
      top: top,
      left: left,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: () {},
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Stack(
              children: [
                BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 10,
                    sigmaY: 10,
                  ),
                  child: Container(
                    color: Colors.blue.withValues(alpha: 0.3),
                  ),
                ),
                child
              ],
            ),
          ),
        ),
      ),
    );
  }
}