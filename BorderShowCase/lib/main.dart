import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Border 튜토리얼',
      debugShowCheckedModeBanner: false,
      home: const BorderTutorial(),
    );
  }
}

class BorderTutorial extends StatelessWidget {
  const BorderTutorial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Border 튜토리얼'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            '안녕하세요! 여기서 시작합니다.'
          )
        ],
      ),
    );
  }
}
