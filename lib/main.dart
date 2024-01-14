import 'package:flutter/material.dart';

import 'dialogbox.dart';
import 'homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ulang Tahun Rajel',
      theme: ThemeData(primarySwatch: Colors.blue),
      home:
          // HomeScreen()
          BirthdaySurpriseScreen(),
    );
  }
}
