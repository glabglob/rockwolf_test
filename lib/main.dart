import 'package:flutter/material.dart';
import 'package:rockwolf_test/presentaition/screens/upload_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Photo Uploader Cubit',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const UploadScreen(),
    );
  }
}
