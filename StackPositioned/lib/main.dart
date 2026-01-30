import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stack & Positioned Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const StackExamplePage(),
    );
  }
}

class StackExamplePage extends StatelessWidget {
  const StackExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stack & Positioned'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 예제 1: 기본 Stack
            _buildSectionTitle('1. 기본 Stack (위젯 겹치기)'),
            _buildExample1(),
            const SizedBox(height: 24),

            // 예제 2: Stack alignment
            _buildSectionTitle('2. Stack alignment 속성'),
            _buildExample2(),
            const SizedBox(height: 24),

            // 예제 3: Positioned 기본
            _buildSectionTitle('3. Positioned로 정확한 위치 지정'),
            _buildExample3(),
            const SizedBox(height: 24),

            // 예제 4: Positioned.fill
            _buildSectionTitle('4. Positioned.fill (전체 채우기)'),
            _buildExample4(),
            const SizedBox(height: 24),

            // 예제 5: 실전 예제 - 프로필 카드
            _buildSectionTitle('5. 실전: 프로필 카드 with 배지'),
            _buildProfileCard(),
            const SizedBox(height: 24),

            // 예제 6: 실전 예제 - 이미지 오버레이
            _buildSectionTitle('6. 실전: 이미지 + 그라데이션 오버레이'),
            _buildImageOverlay(),
            const SizedBox(height: 24),

            // 예제 7: IndexedStack
            _buildSectionTitle('7. IndexedStack (하나만 보여주기)'),
            const IndexedStackExample(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // 예제 1: 기본 Stack - 위젯들이 순서대로 쌓임
  Widget _buildExample1() {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        // 첫 번째 자식이 맨 아래, 마지막 자식이 맨 위
        children: [
          Container(
            width: 150,
            height: 150,
            color: Colors.red.shade300,
            child: const Center(child: Text('1번 (맨 아래)')),
          ),
          Container(
            width: 120,
            height: 120,
            color: Colors.green.shade300,
            child: const Center(child: Text('2번')),
          ),
          Container(
            width: 90,
            height: 90,
            color: Colors.blue.shade300,
            child: const Center(child: Text('3번 (맨 위)')),
          ),
        ],
      ),
    );
  }

  // 예제 2: Stack alignment
  Widget _buildExample2() {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        // alignment: 모든 자식의 기본 정렬 위치
        alignment: Alignment.center,
        children: [
          Container(
            width: 150,
            height: 150,
            color: Colors.orange.shade200,
          ),
          Container(
            width: 100,
            height: 100,
            color: Colors.orange.shade400,
          ),
          Container(
            width: 50,
            height: 50,
            color: Colors.orange.shade600,
            child: const Center(
              child: Text('중앙', style: TextStyle(color: Colors.white, fontSize: 12)),
            ),
          ),
        ],
      ),
    );
  }

  // 예제 3: Positioned 기본
  Widget _buildExample3() {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          // top, left로 위치 지정
          Positioned(
            top: 10,
            left: 10,
            child: Container(
              width: 60,
              height: 60,
              color: Colors.purple.shade300,
              child: const Center(child: Text('TL', style: TextStyle(color: Colors.white))),
            ),
          ),
          // top, right로 위치 지정
          Positioned(
            top: 10,
            right: 10,
            child: Container(
              width: 60,
              height: 60,
              color: Colors.teal.shade300,
              child: const Center(child: Text('TR', style: TextStyle(color: Colors.white))),
            ),
          ),
          // bottom, left로 위치 지정
          Positioned(
            bottom: 10,
            left: 10,
            child: Container(
              width: 60,
              height: 60,
              color: Colors.amber.shade300,
              child: const Center(child: Text('BL')),
            ),
          ),
          // bottom, right로 위치 지정
          Positioned(
            bottom: 10,
            right: 10,
            child: Container(
              width: 60,
              height: 60,
              color: Colors.pink.shade300,
              child: const Center(child: Text('BR', style: TextStyle(color: Colors.white))),
            ),
          ),
          // 중앙 - top/bottom/left/right 조합
          const Positioned(
            top: 80,
            left: 0,
            right: 0,
            child: Center(
              child: Text('Positioned로 정확한 위치!'),
            ),
          ),
        ],
      ),
    );
  }

  // 예제 4: Positioned.fill
  Widget _buildExample4() {
    return Container(
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          // Positioned.fill = 부모 전체 채우기
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.indigo.shade100,
              ),
              child: const Center(child: Text('Positioned.fill\n(전체 채움)', textAlign: TextAlign.center)),
            ),
          ),
          // 마진을 주고 싶으면 all 속성들 조절
          Positioned(
            top: 20,
            left: 20,
            right: 20,
            bottom: 20,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.indigo.shade300,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Text(
                  '마진 20씩',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 예제 5: 실전 - 프로필 카드
  Widget _buildProfileCard() {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          // 프로필 이미지
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.person, size: 60, color: Colors.grey),
          ),
          // 온라인 뱃지 (우측 하단)
          Positioned(
            bottom: 8,
            right: 8,
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 3),
              ),
            ),
          ),
          // 알림 뱃지 (우측 상단)
          Positioned(
            top: 0,
            right: 6,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: const Text(
                '3',
                style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 예제 6: 이미지 오버레이
  Widget _buildImageOverlay() {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // 배경 이미지 (여기선 색상으로 대체)
          Positioned.fill(
            child: Container(
              color: Colors.blueGrey.shade700,
              child: const Icon(Icons.landscape, size: 100, color: Colors.white24),
            ),
          ),
          // 그라데이션 오버레이
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.7),
                  ],
                ),
              ),
            ),
          ),
          // 텍스트 (하단)
          const Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '멋진 풍경 사진',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '그라데이션 오버레이로 텍스트 가독성 UP!',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),
          // 좋아요 버튼 (우측 상단)
          Positioned(
            top: 12,
            right: 12,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.5),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.favorite_border, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}

// 예제 7: IndexedStack - 한 번에 하나의 자식만 보여줌
class IndexedStackExample extends StatefulWidget {
  const IndexedStackExample({super.key});

  @override
  State<IndexedStackExample> createState() => _IndexedStackExampleState();
}

class _IndexedStackExampleState extends State<IndexedStackExample> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 100,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: IndexedStack(
            index: _currentIndex,
            children: [
              Container(
                color: Colors.red.shade100,
                child: const Center(child: Text('페이지 0 (빨강)', style: TextStyle(fontSize: 18))),
              ),
              Container(
                color: Colors.green.shade100,
                child: const Center(child: Text('페이지 1 (초록)', style: TextStyle(fontSize: 18))),
              ),
              Container(
                color: Colors.blue.shade100,
                child: const Center(child: Text('페이지 2 (파랑)', style: TextStyle(fontSize: 18))),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < 3; i++)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: ElevatedButton(
                  onPressed: () => setState(() => _currentIndex = i),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _currentIndex == i ? Colors.deepPurple : null,
                    foregroundColor: _currentIndex == i ? Colors.white : null,
                  ),
                  child: Text('$i'),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        const Text(
          'IndexedStack: 모든 자식을 메모리에 유지하면서\n하나만 보여줌 (탭 전환에 유용!)',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }
}