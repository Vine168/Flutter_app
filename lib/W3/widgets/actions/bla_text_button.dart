import 'package:flutter/material.dart';
import '../../theme/theme.dart';

/// Text Button rendering for the whole application
class BlaTextButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry padding;

  const BlaTextButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.textStyle,
    this.padding = const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
  });

  @override
  Widget build(BuildContext context) {
    // Render the button
    return SizedBox(
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onPressed,
          child: Container(
            padding: padding,
            child: Text(
              text,
              style: textStyle ?? BlaTextStyles.button.copyWith(color: BlaColors.primary),
            ),
          ),
        ),
      ),
    );
  }
}