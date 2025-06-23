import 'package:flutter/material.dart';
import 'package:hotel_room/components/liquid_glass_box.dart';

class GlassButton extends StatelessWidget {
  const GlassButton({
    super.key, required this.children, required this.alignment,
  });
  final Alignment alignment;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return LiquidGlassBox(
      width: 150,
      height: 150,
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