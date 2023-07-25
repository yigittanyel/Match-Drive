import 'package:flutter/material.dart';
import 'package:flutter_application_2/gameTimeDesign.dart';
import 'package:flutter_application_2/home.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Material App',
      home: GameTime(),
    );
  }
}
