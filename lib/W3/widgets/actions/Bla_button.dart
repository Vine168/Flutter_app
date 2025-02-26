import 'package:flutter/material.dart';
import '/theme/theme.dart';

/// A reusable button widget that handles primary and secondary button styles.
class BlaButton extends StatelessWidget {
  final String label; // Text displayed on the button.
  final VoidCallback onPressed; // Callback function when the button is pressed.
  final bool
      isPrimary; // Determines whether the button is primary or secondary.
  final IconData? icon;

  const BlaButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isPrimary = true,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor =
        isPrimary ? BlaColors.primary : BlaColors.backgroundAccent;
    final Color textColor = isPrimary ? BlaColors.white : BlaColors.textNormal;

    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
        padding: const EdgeInsets.symmetric(
          horizontal: BlaSpacings.xl,
          vertical: BlaSpacings.l,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BlaSpacings.radius),
        ),
      ),
      icon: icon != null
          ? Icon(icon, color: BlaColors.iconLight)
          : const SizedBox.shrink(),
      label: Text(label, style: BlaTextStyles.button),
      onPressed: onPressed,
    );
  }
}

class BlaButtonTestScreen extends StatelessWidget {
  const BlaButtonTestScreen({super.key});

  void _onButtonPressed(String type) {
    print('$type button pressed');
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlaButton(
            label: 'Contact Volodia',
            onPressed: () => _onButtonPressed('Contact Volodia'),
            isPrimary: false,
            icon: Icons.chat,
          ),
          const SizedBox(height: BlaSpacings.m),
          BlaButton(
            label: 'Request to Book',
            onPressed: () => _onButtonPressed('Request to Book'),
            isPrimary: true,
            icon: Icons.calendar_today,
          ),
        ],
      ),
    );
  }
}
