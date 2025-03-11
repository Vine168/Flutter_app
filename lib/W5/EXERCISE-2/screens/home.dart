import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/color_counters.dart';
import 'color_taps_screen.dart';
import 'statistics_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ColorCounters>(
        builder: (context, colorCounters, child) {
          return _currentIndex == 0
              ? ColorTapsScreen(
                  redTapCount: colorCounters.redTapCount,
                  blueTapCount: colorCounters.blueTapCount,
                  onRedTap: colorCounters.incrementRedTapCount,
                  onBlueTap: colorCounters.incrementBlueTapCount,
                )
              : StatisticsScreen(
                  redTapCount: colorCounters.redTapCount,
                  blueTapCount: colorCounters.blueTapCount,
                );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.tap_and_play),
            label: 'Taps',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Statistics',
          ),
        ],
      ),
    );
  }
}