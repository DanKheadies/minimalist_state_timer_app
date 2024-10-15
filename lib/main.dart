import 'package:flutter/material.dart';
import 'package:minimalist_state_timer_app/pages/timer_page/timer_page.dart';
import 'package:minimalist_state_timer_app/services/service_locator.dart';

void main() {
  setupGetIt();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TimerPage(),
    );
  }
}
