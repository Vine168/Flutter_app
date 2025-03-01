import 'package:flutter/material.dart';
import '../../theme/theme.dart';
/// Icon Button rendering for the whole application
class BlaIconButton extends StatelessWidget {
  final IconData? icon;
  final VoidCallback? onPressed;
  final double iconSize;
  final Color? iconColor;

  const BlaIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.iconSize = BlaSize.icon,
    this.iconColor = BlaColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0), // Optional: add border radius
            color: Colors.transparent, // Optional: background color
          ),
          child: Icon(
            icon,
            size: iconSize,
            color: iconColor,
          ),
        ),
      ),
    );
  }
}