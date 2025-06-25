import 'package:flutter/material.dart';
import 'package:hotel_room/components/liquid_glass_box.dart';

class GlassButton extends StatelessWidget {
  const GlassButton({
    super.key,
    required this.children,
    required this.alignment,
    required this.onTap,
    this.isActive = false
  });
  final Alignment alignment;
  final List<Widget> children;
  final VoidCallback onTap;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return LiquidGlassBox(
      onTap: onTap,
      width: 150,
      height: 150,
      isActive: isActive,
      alignment: alignment,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ...children
          ],
        ),
      ),
    );
  }
}