import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/color_counters.dart';
import 'screens/home.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ColorCounters(),
      child: MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: Home()),
    );
  }
}