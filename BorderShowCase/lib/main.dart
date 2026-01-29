import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(const BorderShowcaseApp());
}

class BorderShowcaseApp extends StatelessWidget {
  const BorderShowcaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Border 완전 정복',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const BorderShowcasePage(),
    );
  }
}

class BorderShowcasePage extends StatefulWidget {
  const BorderShowcasePage({super.key});

  @override
  State<BorderShowcasePage> createState() => _BorderShowcasePageState();
}

class _BorderShowcasePageState extends State<BorderShowcasePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<String> _tabs = [
    'BoxBorder',
    'OutlinedBorder',
    'InputBorder',
    'BorderRadius',
    'Decoration',
    'CustomPaint',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🎨 Flutter Border 완전 정복'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: _tabs.map((t) => Tab(text: t)).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          BoxBorderSection(),
          OutlinedBorderSection(),
          InputBorderSection(),
          BorderRadiusSection(),
          DecorationSection(),
          CustomPaintSection(),
        ],
      ),
    );
  }
}

// ============================================================
// 1. BoxBorder 섹션
// ============================================================
class BoxBorderSection extends StatelessWidget {
  const BoxBorderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildSectionTitle('Border.all()'),
        _buildDescription('모든 면에 동일한 테두리'),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.blue,
              width: 3,
            ),
          ),
          child: const Text('Border.all(color: Colors.blue, width: 3)'),
        ),

        const SizedBox(height: 24),
        _buildSectionTitle('Border() - 각 면 개별 설정'),
        _buildDescription('상/하/좌/우 각각 다른 스타일'),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(color: Colors.red, width: 5),
              bottom: BorderSide(color: Colors.blue, width: 5),
              left: BorderSide(color: Colors.green, width: 5),
              right: BorderSide(color: Colors.orange, width: 5),
            ),
          ),
          child: const Text('각 면 다른 색상'),
        ),

        const SizedBox(height: 24),
        _buildSectionTitle('특정 면만 테두리'),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.purple, width: 3),
                  ),
                ),
                child: const Text('bottom만', textAlign: TextAlign.center),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  border: Border(
                    left: BorderSide(color: Colors.teal, width: 4),
                  ),
                ),
                child: const Text('left만', textAlign: TextAlign.center),
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),
        _buildSectionTitle('BorderDirectional (RTL 지원)'),
        _buildDescription('start/end로 방향 자동 대응'),
        Directionality(
          textDirection: TextDirection.ltr,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              border: BorderDirectional(
                start: BorderSide(color: Colors.green, width: 8),
                end: BorderSide(color: Colors.red, width: 8),
              ),
            ),
            child: const Text('LTR: start=왼쪽(녹색), end=오른쪽(빨강)'),
          ),
        ),
        const SizedBox(height: 8),
        Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              border: BorderDirectional(
                start: BorderSide(color: Colors.green, width: 8),
                end: BorderSide(color: Colors.red, width: 8),
              ),
            ),
            child: const Text('RTL: start=오른쪽(녹색), end=왼쪽(빨강)'),
          ),
        ),

        const SizedBox(height: 24),
        _buildSectionTitle('BorderSide.strokeAlign'),
        _buildDescription('테두리 선의 위치 조절'),
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      border: const Border.fromBorderSide(
                        BorderSide(
                          color: Colors.blue,
                          width: 8,
                          strokeAlign: BorderSide.strokeAlignInside,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text('Inside', style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      border: const Border.fromBorderSide(
                        BorderSide(
                          color: Colors.green,
                          width: 8,
                          strokeAlign: BorderSide.strokeAlignCenter,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text('Center', style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.orange.shade100,
                      border: const Border.fromBorderSide(
                        BorderSide(
                          color: Colors.orange,
                          width: 8,
                          strokeAlign: BorderSide.strokeAlignOutside,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text('Outside', style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ============================================================
// 2. OutlinedBorder 섹션
// ============================================================
class OutlinedBorderSection extends StatelessWidget {
  const OutlinedBorderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildSectionTitle('RoundedRectangleBorder'),
        _buildDescription('가장 흔한 둥근 사각형'),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 80,
                decoration: ShapeDecoration(
                  color: Colors.blue.shade50,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(color: Colors.blue, width: 2),
                  ),
                ),
                child: const Center(child: Text('radius: 8')),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                height: 80,
                decoration: ShapeDecoration(
                  color: Colors.purple.shade50,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: const BorderSide(color: Colors.purple, width: 2),
                  ),
                ),
                child: const Center(child: Text('radius: 20')),
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),
        _buildSectionTitle('StadiumBorder'),
        _buildDescription('알약 모양 (완전한 반원 끝)'),
        Container(
          width: double.infinity,
          height: 60,
          decoration: ShapeDecoration(
            color: Colors.green.shade50,
            shape: const StadiumBorder(
              side: BorderSide(color: Colors.green, width: 2),
            ),
          ),
          child: const Center(child: Text('StadiumBorder')),
        ),

        const SizedBox(height: 24),
        _buildSectionTitle('CircleBorder'),
        _buildDescription('완벽한 원형'),
        Center(
          child: Container(
            width: 100,
            height: 100,
            decoration: ShapeDecoration(
              color: Colors.orange.shade50,
              shape: const CircleBorder(
                side: BorderSide(color: Colors.orange, width: 3),
              ),
            ),
            child: const Center(child: Text('Circle')),
          ),
        ),

        const SizedBox(height: 24),
        _buildSectionTitle('BeveledRectangleBorder'),
        _buildDescription('모서리가 깎인 사각형'),
        Container(
          width: double.infinity,
          height: 80,
          decoration: ShapeDecoration(
            color: Colors.red.shade50,
            shape: const BeveledRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              side: BorderSide(color: Colors.red, width: 2),
            ),
          ),
          child: const Center(child: Text('Beveled')),
        ),

        const SizedBox(height: 24),
        _buildSectionTitle('ContinuousRectangleBorder'),
        _buildDescription('iOS 스타일 부드러운 곡선 (Squircle)'),
        Container(
          width: double.infinity,
          height: 80,
          decoration: ShapeDecoration(
            color: Colors.cyan.shade50,
            shape: const ContinuousRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(40)),
              side: BorderSide(color: Colors.cyan, width: 2),
            ),
          ),
          child: const Center(child: Text('Continuous (iOS style)')),
        ),

        const SizedBox(height: 24),
        _buildSectionTitle('StarBorder ⭐'),
        _buildDescription('별 모양 (Flutter 3.10+)'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: ShapeDecoration(
                color: Colors.yellow.shade100,
                shape: const StarBorder(
                  points: 5,
                  innerRadiusRatio: 0.5,
                  side: BorderSide(color: Colors.amber, width: 2),
                ),
              ),
            ),
            Container(
              width: 80,
              height: 80,
              decoration: ShapeDecoration(
                color: Colors.pink.shade100,
                shape: const StarBorder(
                  points: 6,
                  innerRadiusRatio: 0.7,
                  side: BorderSide(color: Colors.pink, width: 2),
                ),
              ),
            ),
            Container(
              width: 80,
              height: 80,
              decoration: ShapeDecoration(
                color: Colors.indigo.shade100,
                shape: const StarBorder(
                  points: 8,
                  innerRadiusRatio: 0.8,
                  side: BorderSide(color: Colors.indigo, width: 2),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),
        _buildSectionTitle('StarBorder.polygon()'),
        _buildDescription('다각형 만들기'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: const ShapeDecoration(
                color: Color(0xFFE8F5E9),
                shape: StarBorder.polygon(
                  sides: 3,
                  side: BorderSide(color: Colors.green, width: 2),
                ),
              ),
              child: const Center(child: Text('3')),
            ),
            Container(
              width: 80,
              height: 80,
              decoration: const ShapeDecoration(
                color: Color(0xFFE3F2FD),
                shape: StarBorder.polygon(
                  sides: 5,
                  side: BorderSide(color: Colors.blue, width: 2),
                ),
              ),
              child: const Center(child: Text('5')),
            ),
            Container(
              width: 80,
              height: 80,
              decoration: const ShapeDecoration(
                color: Color(0xFFFCE4EC),
                shape: StarBorder.polygon(
                  sides: 6,
                  side: BorderSide(color: Colors.pink, width: 2),
                ),
              ),
              child: const Center(child: Text('6')),
            ),
          ],
        ),

        const SizedBox(height: 24),
        _buildSectionTitle('Button에서 사용'),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Rounded'),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
              ),
              child: const Text('Stadium'),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                shape: const BeveledRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
              ),
              child: const Text('Beveled'),
            ),
          ],
        ),
      ],
    );
  }
}

// ============================================================
// 3. InputBorder 섹션
// ============================================================
class InputBorderSection extends StatefulWidget {
  const InputBorderSection({super.key});

  @override
  State<InputBorderSection> createState() => _InputBorderSectionState();
}

class _InputBorderSectionState extends State<InputBorderSection> {
  final _focusNode1 = FocusNode();
  final _focusNode2 = FocusNode();
  final _focusNode3 = FocusNode();

  @override
  void dispose() {
    _focusNode1.dispose();
    _focusNode2.dispose();
    _focusNode3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildSectionTitle('OutlineInputBorder'),
        _buildDescription('사각형 테두리 + Label Gap 지원'),
        TextField(
          focusNode: _focusNode1,
          decoration: InputDecoration(
            labelText: 'Email (포커스 해보세요!)',
            hintText: 'example@email.com',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.blue, width: 2),
            ),
          ),
        ),

        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.amber.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            '💡 Label이 테두리 위로 올라가면서 border에 gap이 생기는 것이 '
                'OutlineInputBorder만의 특징입니다!',
            style: TextStyle(fontSize: 13),
          ),
        ),

        const SizedBox(height: 24),
        _buildSectionTitle('UnderlineInputBorder'),
        _buildDescription('Material Design 기본 스타일 (밑줄)'),
        TextField(
          focusNode: _focusNode2,
          decoration: const InputDecoration(
            labelText: 'Username',
            hintText: '사용자 이름 입력',
            border: UnderlineInputBorder(),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.purple, width: 2),
            ),
          ),
        ),

        const SizedBox(height: 24),
        _buildSectionTitle('다양한 상태별 Border'),
        _buildDescription('enabled, focused, error, disabled'),
        TextField(
          focusNode: _focusNode3,
          decoration: InputDecoration(
            labelText: 'Password',
            hintText: '비밀번호 입력',
            errorText: '비밀번호가 너무 짧습니다',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.blue, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red, width: 3),
            ),
          ),
        ),

        const SizedBox(height: 24),
        _buildSectionTitle('gapPadding 비교'),
        _buildDescription('Label 주변 여백 조절'),
        Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'gapPadding: 4',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    gapPadding: 4,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'gapPadding: 16',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    gapPadding: 16,
                  ),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),
        _buildSectionTitle('커스텀 스타일 예시'),
        TextField(
          decoration: InputDecoration(
            labelText: '검색',
            prefixIcon: const Icon(Icons.search),
            suffixIcon: const Icon(Icons.mic),
            filled: true,
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: Colors.blue, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}

// ============================================================
// 4. BorderRadius 섹션
// ============================================================
class BorderRadiusSection extends StatelessWidget {
  const BorderRadiusSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildSectionTitle('BorderRadius.circular()'),
        _buildDescription('모든 모서리 동일한 원형'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _radiusBox('0', BorderRadius.zero),
            _radiusBox('8', BorderRadius.circular(8)),
            _radiusBox('16', BorderRadius.circular(16)),
            _radiusBox('30', BorderRadius.circular(30)),
          ],
        ),

        const SizedBox(height: 24),
        _buildSectionTitle('BorderRadius.only()'),
        _buildDescription('각 모서리 개별 설정'),
        Container(
          width: double.infinity,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.purple.shade100,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(0),
              bottomRight: Radius.circular(20),
            ),
            border: Border.all(color: Colors.purple, width: 2),
          ),
          child: const Center(
            child: Text('topLeft:30, topRight:10\nbottomLeft:0, bottomRight:20',
                textAlign: TextAlign.center),
          ),
        ),

        const SizedBox(height: 24),
        _buildSectionTitle('BorderRadius.vertical()'),
        _buildDescription('상/하 그룹으로 설정'),
        Container(
          width: double.infinity,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.teal.shade100,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(30),
              bottom: Radius.circular(5),
            ),
            border: Border.all(color: Colors.teal, width: 2),
          ),
          child: const Center(child: Text('top: 30, bottom: 5')),
        ),

        const SizedBox(height: 24),
        _buildSectionTitle('BorderRadius.horizontal()'),
        _buildDescription('좌/우 그룹으로 설정'),
        Container(
          width: double.infinity,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.indigo.shade100,
            borderRadius: const BorderRadius.horizontal(
              left: Radius.circular(30),
              right: Radius.circular(5),
            ),
            border: Border.all(color: Colors.indigo, width: 2),
          ),
          child: const Center(child: Text('left: 30, right: 5')),
        ),

        const SizedBox(height: 24),
        _buildSectionTitle('Radius.elliptical()'),
        _buildDescription('타원형 모서리 (가로/세로 다름)'),
        Container(
          width: double.infinity,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.amber.shade100,
            borderRadius: const BorderRadius.all(
              Radius.elliptical(50, 20),
            ),
            border: Border.all(color: Colors.amber.shade700, width: 2),
          ),
          child: const Center(child: Text('Radius.elliptical(50, 20)')),
        ),

        const SizedBox(height: 24),
        _buildSectionTitle('실전 UI 패턴'),
        _buildDescription('카드 상단만 둥글게'),
        Card(
          clipBehavior: Clip.antiAlias,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              Container(
                height: 80,
                color: Colors.blue,
                child: const Center(
                  child:
                  Text('Header', style: TextStyle(color: Colors.white)),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text('Content Area'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _radiusBox(String label, BorderRadius radius) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.blue.shade100,
            borderRadius: radius,
            border: Border.all(color: Colors.blue, width: 2),
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}

// ============================================================
// 5. Decoration 섹션
// ============================================================
class DecorationSection extends StatelessWidget {
  const DecorationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildSectionTitle('BoxDecoration'),
        _buildDescription('사각형용 복합 장식 (가장 흔함)'),
        Container(
          width: double.infinity,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.blue, width: 2),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Center(child: Text('BoxDecoration\n+ border + shadow')),
        ),

        const SizedBox(height: 24),
        _buildSectionTitle('ShapeDecoration'),
        _buildDescription('ShapeBorder 기반 (더 다양한 모양)'),
        Container(
          width: double.infinity,
          height: 100,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: const StadiumBorder(
              side: BorderSide(color: Colors.purple, width: 2),
            ),
            shadows: [
              BoxShadow(
                color: Colors.purple.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Center(child: Text('ShapeDecoration + StadiumBorder')),
        ),

        const SizedBox(height: 24),
        _buildSectionTitle('그라데이션 + Border'),
        Container(
          width: double.infinity,
          height: 100,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Colors.blue, Colors.purple],
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white, width: 3),
          ),
          child: const Center(
            child: Text(
              'Gradient Background',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),

        const SizedBox(height: 24),
        _buildSectionTitle('🔥 그라데이션 Border 트릭'),
        _buildDescription('중첩 Container 활용'),
        Container(
          padding: const EdgeInsets.all(4), // 테두리 두께
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Colors.pink, Colors.orange, Colors.yellow],
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Center(child: Text('Gradient Border!')),
          ),
        ),

        const SizedBox(height: 24),
        _buildSectionTitle('DecoratedBox'),
        _buildDescription('Container보다 가벼움 (padding/margin 없음)'),
        DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            border: Border.all(color: Colors.green, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Padding(
            padding: EdgeInsets.all(20),
            child: Text('DecoratedBox + Padding'),
          ),
        ),

        const SizedBox(height: 24),
        _buildSectionTitle('PhysicalModel'),
        _buildDescription('elevation + 자동 클리핑'),
        PhysicalModel(
          color: Colors.white,
          elevation: 8,
          shadowColor: Colors.black54,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            child: const Text('PhysicalModel\nelevation: 8'),
          ),
        ),

        const SizedBox(height: 24),
        _buildSectionTitle('이미지 + Border'),
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 4),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [ // 이 친구 때문에 위에 borderRadius 을 함.
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                'https://picsum.photos/300/150',
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: 150,
                  color: Colors.grey.shade300,
                  child: const Center(child: Icon(Icons.image)),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomPaintSection extends StatelessWidget {
  const CustomPaintSection();
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        SizedBox(
          height: 50,
          width: 50,
          child: CustomPaint(
            painter: MyPainter(),
          ),
        )
      ],
    );
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(100, 0);
    path.lineTo(50, 100);
    path.close();

    final paint = Paint();
    paint.color = Colors.blue;
    paint.style = PaintingStyle.fill;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant MyPainter oldDelegate) {
    return false;
  }
}

// ============================================================
// Animated Border Demo
// ============================================================

class AnimatedBorderDemo extends StatefulWidget {
  const AnimatedBorderDemo({super.key});

  @override
  State<AnimatedBorderDemo> createState() => _AnimatedBorderDemoState();
}

class _AnimatedBorderDemoState extends State<AnimatedBorderDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: AnimatedGradientBorderPainter(
            progress: _controller.value,
          ),
          child: Container(
            width: double.infinity,
            height: 100,
            alignment: Alignment.center,
            child: const Text('Rotating Gradient Border'),
          ),
        );
      },
    );
  }
}

class AnimatedGradientBorderPainter extends CustomPainter {
  final double progress;

  AnimatedGradientBorderPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final paint = Paint()
      ..shader = SweepGradient(
        startAngle: progress * 2 * math.pi,
        endAngle: progress * 2 * math.pi + 2 * math.pi,
        colors: const [
          Colors.red,
          Colors.orange,
          Colors.yellow,
          Colors.green,
          Colors.blue,
          Colors.purple,
          Colors.red,
        ],
        transform: GradientRotation(progress * 2 * math.pi),
      ).createShader(rect)
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    final rrect = RRect.fromRectAndRadius(
      rect.deflate(2),
      const Radius.circular(16),
    );

    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(covariant AnimatedGradientBorderPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

// ============================================================
// Helper Widgets
// ============================================================

Widget _buildSectionTitle(String title) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget _buildDescription(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 14,
        color: Colors.grey.shade600,
      ),
    ),
  );
}