import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Widget Examples',
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
      ),
      home: const ExampleHome(),
    );
  }
}

class ExampleHome extends StatelessWidget {
  const ExampleHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Widget Examples')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // =============================================
            // 10. Container Decoration 예제
            // =============================================
            _sectionTitle('10. Container Decoration'),
            const SizedBox(height: 12),

            // 기본 배경색 + 둥근 모서리
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.indigo.shade50,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Text(
                '배경색 + 둥근 모서리 (borderRadius)',
                style: TextStyle(fontSize: 16),
              ),
            ),

            const SizedBox(height: 12),

            // 테두리(border) + 그림자(boxShadow)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.indigo,
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Text(
                '테두리(border) + 그림자(boxShadow)',
                style: TextStyle(fontSize: 16),
              ),
            ),

            const SizedBox(height: 12),

            // 그라데이션(gradient)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: const LinearGradient(
                  colors: [Colors.indigo, Colors.purple, Colors.pink],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Text(
                '그라데이션 (LinearGradient)',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),

            const SizedBox(height: 12),

            // 원형(shape: BoxShape.circle)
            Center(
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [Colors.amber.shade200, Colors.orange],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.orange.withValues(alpha: 0.4),
                      blurRadius: 15,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    '원형',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // 이미지 배경 + 오버레이
            Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: const DecorationImage(
                  image: NetworkImage('https://picsum.photos/400/200'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.black.withValues(alpha: 0.4),
                ),
                alignment: Alignment.center,
                child: const Text(
                  '이미지 배경 + 오버레이',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 32),

            // =============================================
            // 11. SizedBox Spacing 예제
            // =============================================
            _sectionTitle('11. SizedBox로 간격 조절'),
            const SizedBox(height: 12),

            // 세로 간격 예제
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '▼ 세로 간격 (height)',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  _colorBox('위 박스', Colors.blue.shade200),
                  const SizedBox(height: 8), // 8px 간격
                  _label('↕ SizedBox(height: 8)'),
                  _colorBox('아래 박스', Colors.blue.shade300),
                  const SizedBox(height: 20),
                  _colorBox('위 박스', Colors.green.shade200),
                  const SizedBox(height: 24), // 24px 간격
                  _label('↕ SizedBox(height: 24)'),
                  _colorBox('아래 박스', Colors.green.shade300),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // 가로 간격 예제
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '▶ 가로 간격 (width)',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(child: _colorBox('왼쪽', Colors.purple.shade200)),
                      const SizedBox(width: 8), // 8px 간격
                      Expanded(child: _colorBox('오른쪽', Colors.purple.shade300)),
                    ],
                  ),
                  const Center(
                    child: Text(
                      '↔ SizedBox(width: 8)',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(child: _colorBox('왼쪽', Colors.teal.shade200)),
                      const SizedBox(width: 32), // 32px 간격
                      Expanded(child: _colorBox('오른쪽', Colors.teal.shade300)),
                    ],
                  ),
                  const Center(
                    child: Text(
                      '↔ SizedBox(width: 32)',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // SizedBox 고정 크기 지정
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '📐 고정 크기 지정',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: 200,
                    height: 60,
                    child: Container(
                      color: Colors.amber.shade200,
                      alignment: Alignment.center,
                      child: const Text('SizedBox(w:200, h:60)'),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: Container(
                      color: Colors.red.shade200,
                      alignment: Alignment.center,
                      child: const Text('SizedBox(w: infinity, h:40)'),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // =============================================
            // 12. AspectRatio 위젯 예제
            // =============================================
            _sectionTitle('12. AspectRatio 위젯'),
            const SizedBox(height: 12),

            // 16:9 비율
            const Text('16:9 비율', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: const LinearGradient(
                    colors: [Colors.deepPurple, Colors.indigo],
                  ),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'aspectRatio: 16/9',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // 4:3 비율
            const Text('4:3 비율', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            AspectRatio(
              aspectRatio: 4 / 3,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.teal,
                ),
                alignment: Alignment.center,
                child: const Text(
                  'aspectRatio: 4/3',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // 1:1 정사각형
            const Text('1:1 정사각형', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: const LinearGradient(
                    colors: [Colors.orange, Colors.pink],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'aspectRatio: 1/1',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // 카드형 이미지에 AspectRatio 적용
            const Text('카드형 이미지 (3:2)', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Card(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  AspectRatio(
                    aspectRatio: 3 / 2,
                    child: Container(
                      color: Colors.grey.shade300,
                      child: const Icon(Icons.image, size: 48, color: Colors.grey),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '카드 제목',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text('AspectRatio로 이미지 영역의 비율을 3:2로 고정합니다.'),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // 그리드에서 AspectRatio 활용
            const Text('그리드에서 활용 (1:1)', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 1, // 1:1 정사각형
              children: List.generate(6, (index) {
                final colors = [
                  Colors.red.shade300,
                  Colors.blue.shade300,
                  Colors.green.shade300,
                  Colors.amber.shade300,
                  Colors.purple.shade300,
                  Colors.teal.shade300,
                ];
                return Container(
                  decoration: BoxDecoration(
                    color: colors[index],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${index + 1}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // =============================================
  // Helper Widgets
  // =============================================

  Widget _sectionTitle(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  static Widget _colorBox(String text, Color color) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: Text(text),
    );
  }

  static Widget _label(String text) {
    return Center(
      child: Text(
        text,
        style: const TextStyle(fontSize: 12, color: Colors.grey),
      ),
    );
  }
}