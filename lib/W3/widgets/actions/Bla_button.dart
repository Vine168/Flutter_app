import 'package:flutter/material.dart';
import '../../theme/theme.dart';

enum ButtonType { primary, secondary }
class BlaButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonType type;
  final IconData? icon;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final double iconSize;

  const BlaButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.type = ButtonType.primary,
    this.icon,
    this.padding = const EdgeInsets.symmetric(vertical: 20),
    this.borderRadius = 8.0,
    this.iconSize = 20.0,
  });

  @override
  Widget build(BuildContext context) {
    // Compute the rendering
    Color backgroundColor = type == ButtonType.primary ? BlaColors.primary : BlaColors.white;
    BorderSide border = type == ButtonType.primary
        ? BorderSide.none
        : BorderSide(color: BlaColors.greyLight, width: 2);
    Color textColor = type == ButtonType.primary ? BlaColors.white : BlaColors.primary;
    Color iconColor = type == ButtonType.primary ? BlaColors.white : BlaColors.primary;

    // Create the button icon - if any
    List<Widget> children = [];
    if (icon != null) {
      children.add(Icon(icon, size: iconSize, color: iconColor));
      children.add(SizedBox(width: BlaSpacings.s));
    }

    // Create the button text
    Text buttonText = Text(text, style: BlaTextStyles.button.copyWith(color: textColor));
    children.add(buttonText);

    // Render the button
    return SizedBox(
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor,
          padding: padding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          side: border,
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: children,
        ),
      ),
    );
  }
}