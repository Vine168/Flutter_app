import 'package:flutter/material.dart';

class AnimationUtils {
  static const int transitionSpeed = 500; // Animation speed in milliseconds

  ////
  /// Slide the given screen from bottom to top
  ///
  static Route<T> createBottomToTopRoute<T>(Widget screen) {
    const begin = Offset(0.0, 1.0); // Start from the bottom
    const end = Offset(0.0, 0.0);   // End at the normal position
    return _createAnimatedRoute(screen, begin, end);
  }

  ////
  /// Slide the given screen from top to bottom
  ///
  static Route<T> createTopToBottomRoute<T>(Widget screen) {
    const begin = Offset(0.0, -1.0); // Start from the top
    const end = Offset(0.0, 0.0);     // End at the normal position
    return _createAnimatedRoute(screen, begin, end);
  }

  ////
  /// Create a generic animated route with given start and end offsets
  ///
  static Route<T> _createAnimatedRoute<T>(Widget screen, Offset begin, Offset end) {
    return PageRouteBuilder<T>(
      transitionDuration: const Duration(milliseconds: transitionSpeed), // Animation duration
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: Curves.easeInOut));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  ////
  /// Slide the given screen from top to a fixed height (not fullscreen)
  ///
  static Route<T> createTopSheetRoute<T>(Widget screen, {double maxHeightFactor = 0.5}) {
    return PageRouteBuilder<T>(
      opaque: false, // Allow previous screen to be visible
      transitionDuration: const Duration(milliseconds: transitionSpeed),
      pageBuilder: (context, animation, secondaryAnimation) {
        return GestureDetector(
          onTap: () => Navigator.pop(context), // Close when tapping outside
          child: Scaffold(
            backgroundColor: Colors.black.withOpacity(0.5), // Semi-transparent overlay
            body: Align(
              alignment: Alignment.topCenter,
              child: FractionallySizedBox(
                widthFactor: 1, // Full width
                heightFactor: maxHeightFactor, // Customizable height
                child: Material(
                  color: Colors.white,
                  borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
                  child: screen, // Embed your custom content
                ),
              ),
            ),
          ),
        );
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var tween = Tween(begin: const Offset(0, -1), end: Offset.zero)
            .chain(CurveTween(curve: Curves.easeInOut));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}