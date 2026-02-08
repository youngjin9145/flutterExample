import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: GestureInWellPage(),
    );
  }
}

class GestureInWellPage extends StatefulWidget {
  const GestureInWellPage({super.key});

  @override
  State<GestureInWellPage> createState() => _GestureInWellPageState();
}

class _GestureInWellPageState extends State<GestureInWellPage> {
  String _lastEvent = '아직 이벤트 없음';

  void _updateEvent(String event) {
    setState(() {
      _lastEvent = event;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Day 15: GestureDetector & InkWell'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 이벤트 표시 영역
            Card(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    _lastEvent,
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
