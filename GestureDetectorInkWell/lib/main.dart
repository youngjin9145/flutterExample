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

            // ============================================================
            // 1. GestureDetector - 물결 효과 없음, 다양한 제스처 감지
            // ============================================================
            Text(
              'GestureDetector',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            GestureDetector(
              onTap: () => _updateEvent('GestureDetector: onTap'),
              onDoubleTap: () => _updateEvent('GestureDetector: onDoubleTap'),
              onLongPress: () => _updateEvent('GestureDetector: onLongPress'),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.teal.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.teal.shade200),
                ),
                child: const Text(
                  '탭 / 더블탭 / 길게 누르기',
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            const SizedBox(height: 12),

            GestureDetector(
              onPanUpdate: (details) {
                _updateEvent(
                  'GestureDetector: 드래그 '
                  'dx=${details.delta.dx.toStringAsFixed(1)}, '
                  'dy=${details.delta.dy.toStringAsFixed(1)}',
                );
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.orange.shade200),
                ),
                child: const Text(
                  '여기를 드래그 해보세요',
                  textAlign: TextAlign.center,
                ),
              )
            ),
            const SizedBox(height: 32,)
          ],
        ),
      ),
    );
  }
}
