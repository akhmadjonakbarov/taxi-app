import 'package:flutter/material.dart';
import 'package:taxi_app/screens/screens.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Yo'lo'vchi",
      theme: ThemeData(primarySwatch: Colors.amber),
      home: const RegisterScreen(),
    );
  }
}
