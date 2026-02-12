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
            const SizedBox(height: 32,),

            // ============================================================
            // 2. InkWell - Material 물결(ripple) 효과 있음
            // ============================================================
            Text(
              'InkWell',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            // Material로 감싸야 물결 효과가 보임
            Material(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(12),
              child: InkWell(
                onTap: () => _updateEvent('InkWell: onTap (물결 효과!)'),
                onDoubleTap: () => _updateEvent('InkWell: onDoubleTap'),
                onLongPress: () => _updateEvent('InkWell: onLongPress'),
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  child: const Text(
                    '탭하면 물결 효과가 보입니다',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // splashColor, highlightColor 커스텀
            Material(
              color: Colors.purple.shade50,
              borderRadius: BorderRadius.circular(12),
              child: InkWell(
                onTap: () => _updateEvent('InkWell: 커스텀 물결 색상'),
                splashColor: Colors.purple.withValues(alpha: 0.3),
                highlightColor: Colors.purple.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  child: const Text(
                      'splashColor / highlightColor 커스텀',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 32),

              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'GestureDetector vs InkWell',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildCompareRow('물결 효과', '없음', '있음 (Material)'),
                      _buildCompareRow('드래그', 'onPanUpdate 지원', '지원 안 함'),
                      _buildCompareRow('스케일', 'onScaleUpdate 지원', '지원 안 함'),
                      _buildCompareRow('용도', '커스텀 제스처', '버튼처럼 쓸 때'),
                    ],
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}

Widget _buildCompareRow(String label, String gesture, String inkwell) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        SizedBox(
          width: 70,
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ),
        Expanded(
          child: Text('GD: $gesture', style: const TextStyle(fontSize: 12)),
        ),
        Expanded(
          child: Text('IW: $inkwell', style: const TextStyle(fontSize: 12)),
        ),
      ],
    ),
  );
}