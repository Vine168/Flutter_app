import 'package:flutter/material.dart';
import '../widgets/color_tap.dart';

class ColorTapsScreen extends StatelessWidget {
  final int redTapCount;
  final int blueTapCount;
  final VoidCallback onRedTap;
  final VoidCallback onBlueTap;

  const ColorTapsScreen({
    super.key,
    required this.redTapCount,
    required this.blueTapCount,
    required this.onRedTap,
    required this.onBlueTap,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Color Taps')),
      body: Column(
        children: [
          ColorTap(
            type: CardType.red,
            tapCount: redTapCount,
            onTap: onRedTap,
          ),
          ColorTap(
            type: CardType.blue,
            tapCount: blueTapCount,
            onTap: onBlueTap,
          ),
        ],
      ),
    );
  }
}