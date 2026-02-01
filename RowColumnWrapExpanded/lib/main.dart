// ============================================================
// 7. Row, Column - MainAxis / CrossAxis 정렬
// ============================================================
//
// 핵심 개념:
// - Row: 가로 방향 배치 (mainAxis = 가로, crossAxis = 세로)
// - Column: 세로 방향 배치 (mainAxis = 세로, crossAxis = 가로)
// - MainAxisAlignment: 주축 방향 정렬 (start, center, end, spaceBetween, spaceAround, spaceEvenly)
// - CrossAxisAlignment: 교차축 방향 정렬 (start, center, end, stretch, baseline)

import 'package:flutter/material.dart';

// ── 7번 예제 ──────────────────────────────────────────────────
class RowColumnExample extends StatelessWidget {
  const RowColumnExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('7. Row & Column 정렬')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Row 예제 ──
            const Text(
              '▶ Row - MainAxisAlignment 비교',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // spaceBetween: 양 끝에 붙이고 나머지 균등 배분
            const Text('spaceBetween:'),
            Container(
              color: Colors.grey[200],
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _box(Colors.red, 'A'),
                  _box(Colors.green, 'B'),
                  _box(Colors.blue, 'C'),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // spaceEvenly: 모든 간격이 동일
            const Text('spaceEvenly:'),
            Container(
              color: Colors.grey[200],
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _box(Colors.red, 'A'),
                  _box(Colors.green, 'B'),
                  _box(Colors.blue, 'C'),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // center
            const Text('center:'),
            Container(
              color: Colors.grey[200],
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _box(Colors.red, 'A'),
                  const SizedBox(width: 8),
                  _box(Colors.green, 'B'),
                  const SizedBox(width: 8),
                  _box(Colors.blue, 'C'),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // ── Column + CrossAxisAlignment 예제 ──
            const Text(
              '▶ Column - CrossAxisAlignment 비교',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            Row(
              children: [
                // CrossAxisAlignment.start (왼쪽 정렬)
                Expanded(
                  child: Column(
                    children: [
                      const Text(
                        'start',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Container(
                        color: Colors.grey[200],
                        height: 150,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start, // ← 왼쪽
                          children: [
                            _box(Colors.orange, '1'),
                            const SizedBox(height: 4),
                            _box(Colors.purple, '22'),
                            const SizedBox(height: 4),
                            _box(Colors.teal, '333'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),

                // CrossAxisAlignment.center (가운데 정렬)
                Expanded(
                  child: Column(
                    children: [
                      const Text(
                        'center',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Container(
                        color: Colors.grey[200],
                        height: 150,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment:
                              CrossAxisAlignment.center, // ← 가운데
                          children: [
                            _box(Colors.orange, '1'),
                            const SizedBox(height: 4),
                            _box(Colors.purple, '22'),
                            const SizedBox(height: 4),
                            _box(Colors.teal, '333'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),

                // CrossAxisAlignment.end (오른쪽 정렬)
                Expanded(
                  child: Column(
                    children: [
                      const Text(
                        'end',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Container(
                        color: Colors.grey[200],
                        height: 150,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end, // ← 오른쪽
                          children: [
                            _box(Colors.orange, '1'),
                            const SizedBox(height: 4),
                            _box(Colors.purple, '22'),
                            const SizedBox(height: 4),
                            _box(Colors.teal, '333'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// 8. Wrap - 자동 줄바꿈
// ============================================================
//
// 핵심 개념:
// - Row는 공간이 부족하면 overflow 에러 발생 💥
// - Wrap은 공간이 부족하면 자동으로 다음 줄로 넘김 ✅
// - direction: 배치 방향 (horizontal / vertical)
// - spacing: 같은 줄 내 아이템 간격
// - runSpacing: 줄과 줄 사이 간격
// - 태그 UI, 칩(Chip) 목록 등에 자주 사용

class WrapExample extends StatelessWidget {
  const WrapExample({super.key});

  @override
  Widget build(BuildContext context) {
    final tags = [
      'Flutter',
      'Dart',
      'Widget',
      'State',
      'BuildContext',
      'Material',
      'Cupertino',
      'Animation',
      'Layout',
      'Navigation',
      'Provider',
      'Riverpod',
      'BLoC',
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('8. Wrap 자동 줄바꿈')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Row로 하면? → overflow! ──
            const Text(
              '▶ Row로 넣으면 overflow 발생 🚨',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              color: Colors.red[50],
              // Row 사용 시 화면 밖으로 넘침 (실제로는 에러)
              // 여기서는 SingleChildScrollView로 감싸서 보여줌
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: tags
                      .take(7)
                      .map(
                        (tag) => Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Chip(label: Text(tag)),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // ── Wrap으로 하면? → 자동 줄바꿈! ──
            const Text(
              '▶ Wrap으로 넣으면 자동 줄바꿈 ✅',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              color: Colors.green[50],
              padding: const EdgeInsets.all(8),
              child: Wrap(
                spacing: 8, // 가로 간격
                runSpacing: 8, // 세로(줄 간) 간격
                children: tags
                    .map(
                      (tag) => Chip(
                        label: Text(tag),
                        backgroundColor: Colors.blue[100],
                      ),
                    )
                    .toList(),
              ),
            ),
            const SizedBox(height: 24),

            // ── Wrap + alignment ──
            const Text(
              '▶ Wrap alignment: center',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              color: Colors.yellow[50],
              padding: const EdgeInsets.all(8),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                alignment: WrapAlignment.center, // 줄 단위 가운데 정렬
                children: tags
                    .map(
                      (tag) => ActionChip(label: Text(tag), onPressed: () {}),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// 9. Expanded vs Flexible
// ============================================================
//
// 핵심 개념:
// - 둘 다 Row/Column 안에서 남은 공간을 분배할 때 사용
// - Expanded: 남은 공간을 반드시 꽉 채움 (fit: FlexFit.tight)
// - Flexible: 남은 공간 중 필요한 만큼만 차지 (fit: FlexFit.loose)
// - flex 값으로 비율 조절 가능 (기본값 1)
//
//  비유:
//  Expanded = "할당된 공간 전부 다 써!" (강제)
//  Flexible = "필요한 만큼만 써, 남으면 비워둬" (유연)

class ExpandedFlexibleExample extends StatelessWidget {
  const ExpandedFlexibleExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('9. Expanded vs Flexible')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── 1) Expanded: flex 비율 ──
            const Text(
              '▶ Expanded - flex 비율로 공간 분배',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Text('flex 1 : 2 : 1 비율'),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  flex: 1, // 1/4
                  child: Container(
                    height: 60,
                    color: Colors.red[300],
                    alignment: Alignment.center,
                    child: const Text(
                      'flex:1',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2, // 2/4
                  child: Container(
                    height: 60,
                    color: Colors.green[300],
                    alignment: Alignment.center,
                    child: const Text(
                      'flex:2',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1, // 1/4
                  child: Container(
                    height: 60,
                    color: Colors.blue[300],
                    alignment: Alignment.center,
                    child: const Text(
                      'flex:1',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // ── 2) Expanded vs Flexible 차이 ──
            const Text(
              '▶ Expanded vs Flexible 차이 비교',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // Expanded: 공간을 꽉 채움
            const Text('Expanded (꽉 채움):'),
            const SizedBox(height: 4),
            Container(
              color: Colors.grey[200],
              child: Row(
                children: [
                  Container(
                    width: 80,
                    height: 50,
                    color: Colors.orange,
                    alignment: Alignment.center,
                    child: const Text('고정 80'),
                  ),
                  Expanded(
                    // ← 나머지 공간 전부 차지
                    child: Container(
                      height: 50,
                      width: 50, // 무시
                      color: Colors.purple[200],
                      alignment: Alignment.center,
                      child: const Text(
                        'Expanded\n(남은 공간 전부)',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Flexible: 필요한 만큼만 차지
            const Text('Flexible (필요한 만큼만):'),
            const SizedBox(height: 4),
            Container(
              color: Colors.grey[200],
              child: Row(
                children: [
                  Container(
                    width: 80,
                    height: 50,
                    color: Colors.orange,
                    alignment: Alignment.center,
                    child: const Text('고정 80'),
                  ),
                  Flexible(
                    // ← 필요한 만큼만 차지, 나머지는 빈 공간
                    child: Container(
                      height: 50,
                      width: 50, // 존중
                      color: Colors.purple[200],
                      alignment: Alignment.center,
                      child: const Text('Flexible (필요한 만큼만)'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // ── 3) 실전 활용: 검색바 ──
            const Text(
              '▶ 실전 예제: 검색바 레이아웃',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                // 검색 입력 필드 → 남은 공간 전부 차지
                Expanded(
                  child: Container(
                    height: 48,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(24),
                    ),
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      '검색어를 입력하세요...',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                // 버튼 → 고정 크기
                Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Icon(Icons.search, color: Colors.white),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // ── 요약 표 ──
            const Text(
              '📌 요약',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Table(
              border: TableBorder.all(color: Colors.grey),
              columnWidths: const {
                0: FlexColumnWidth(1),
                1: FlexColumnWidth(2),
              },
              children: const [
                TableRow(
                  decoration: BoxDecoration(color: Color(0xFFE3F2FD)),
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        '구분',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        '설명',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text('Expanded'),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text('남은 공간을 반드시 꽉 채움\n(FlexFit.tight)'),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text('Flexible'),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text('필요한 만큼만 차지, 나머지는 빈 공간\n(FlexFit.loose)'),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Padding(padding: EdgeInsets.all(8), child: Text('flex')),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text('비율 지정 (기본값: 1)\nflex:2는 flex:1의 2배 공간'),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ── 공용 헬퍼 위젯 ──
Widget _box(Color color, String label) {
  return Container(
    width: 50,
    height: 40,
    color: color,
    alignment: Alignment.center,
    child: Text(
      label,
      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
  );
}

// ============================================================
// 메인 앱 - 3개 예제를 탭으로 확인
// ============================================================
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final examples = [
      {'title': '7. Row / Column 정렬', 'page': const RowColumnExample()},
      {'title': '8. Wrap 자동 줄바꿈', 'page': const WrapExample()},
      {
        'title': '9. Expanded vs Flexible',
        'page': const ExpandedFlexibleExample(),
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Layout 예제')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: examples.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          return ElevatedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => examples[index]['page'] as Widget,
              ),
            ),
            child: Text(examples[index]['title'] as String),
          );
        },
      ),
    );
  }
}
