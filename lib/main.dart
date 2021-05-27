import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_webant_gallery_app/app/ui/scenes/route/route.dart';

import 'app/ui/scenes/gallery/bloc/gallery_bloc.dart';

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
