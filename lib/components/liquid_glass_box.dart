import 'dart:ui';

import 'package:flutter/material.dart';

class LiquidGlassBox extends StatelessWidget {
  const LiquidGlassBox({
    super.key,
    required this.width,
    required this.height,
    required this.child,
    required this.alignment,
    this.padding = const EdgeInsets.all(16),
    required this.onTap,
    this.isActive = false
  });

  final double width;
  final double height;
  final Widget child;
  final Alignment alignment;
  final EdgeInsets padding;
  final VoidCallback onTap;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Padding(
        padding: padding,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: InkWell(
            onTap: onTap,
            child: Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: isActive ? Colors.white : null
              ),
              child: Stack(
                children: [
                  if (!isActive)
                  BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 10,
                      sigmaY: 10,
                    ),
                    child: Container(
                      color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.4),
                    ),
                  ),
                  child
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}