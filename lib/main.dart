import 'package:flutter/material.dart';
import 'package:google_map/convert_longitude_latitude.dart';
import 'package:google_map/finger_print_auth.dart';
import 'package:google_map/google_places_api_page.dart';
import 'package:google_map/user_current_location.dart';

import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const FingerPrintAuth(),
    );
  }
}


