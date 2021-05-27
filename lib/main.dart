import 'dart:async';

import 'package:flutter/material.dart';
import 'app/ui/scenes/route/route.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runZonedGuarded(() {
    runApp(
      MyApp(),
    );
  }, (error, stackTrace) {});
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainScreen(),
    );
  }
}
