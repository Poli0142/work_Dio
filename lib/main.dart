import 'package:flutter/material.dart';
import 'di.dart';
import 'screens/home_screen.dart';

void main() {
  setupDependencies(); // Инициализация зависимостей (Dio, GetIt)
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API Ninjas Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
    );
  }
}