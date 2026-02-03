import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Loading Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

// 가상의 데이터 모델
class UserData {
  final String username;
  final double height;
  final double weight;
  final int steps;
  final int heartRate;
  final int waterIntake;

  UserData({
    required this.username,
    required this.height,
    required this.weight,
    required this.steps,
    required this.heartRate,
    required this.waterIntake,
  });
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = true;
  String? _error;
  UserData? _data;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  // 가상의 API 호출 시뮬레이션
  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      // 2초 지연으로 API 호출 시뮬레이션
      await Future.delayed(const Duration(seconds: 2));

      // 가상 데이터 반환
      final data = UserData(
        username: 'Competitor99',
        height: 182.5,
        weight: 80.5,
        steps: 2578,
        heartRate: 118,
        waterIntake: 250,
      );

      setState(() {
        _data = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Dashboard'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          // 새로고침 버튼
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadData,
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    // 로딩 중
    if (_isLoading) {
      return _buildLoadingUI();
    }

    // 에러 발생
    if (_error != null) {
      return _buildErrorUI();
    }

    // 데이터 표시
    return _buildContentUI();
  }

  // ========== 로딩 UI ==========
  Widget _buildLoadingUI() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 기본 CircularProgressIndicator
          const CircularProgressIndicator(),
          const SizedBox(height: 20),
          Text(
            '데이터를 불러오는 중...',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  // ========== 에러 UI ==========
  Widget _buildErrorUI() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.red[300],
          ),
          const SizedBox(height: 16),
          const Text(
            '데이터를 불러오지 못했습니다',
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 8),
          Text(
            _error!,
            style: TextStyle(color: Colors.grey[600]),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: _loadData,
            icon: const Icon(Icons.refresh),
            label: const Text('다시 시도'),
          ),
        ],
      ),
    );
  }

  // ========== 컨텐츠 UI ==========
  Widget _buildContentUI() {
    final data = _data!;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hello ${data.username},',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
          ),
          const SizedBox(height: 20),

          // 신체 정보 카드
          _buildInfoCard(
            title: '신체 정보',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem('${data.height}', 'cm'),
                _buildDivider(),
                _buildStatItem('${data.weight}', 'kg'),
                _buildDivider(),
                _buildStatItem(
                  (data.weight / ((data.height / 100) * (data.height / 100)))
                      .toStringAsFixed(2),
                  'BMI',
                ),
              ],
            ),
          ),

          // 걸음 수 카드
          _buildInfoCard(
            title: 'Steps',
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${data.steps}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text('/5,000 Steps'),
                  ],
                ),
                const Spacer(),
                SizedBox(
                  width: 100,
                  child: LinearProgressIndicator(
                    value: data.steps / 5000,
                    minHeight: 8,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
          ),

          // 심박수 카드
          _buildInfoCard(
            title: 'Heart Rate',
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                  child: const Icon(
                    Icons.favorite,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  '${data.heartRate} bpm',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // 물 섭취 카드
          _buildInfoCard(
            title: 'Water',
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                  child: const Icon(
                    Icons.water_drop,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${data.waterIntake} ml',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text('/ 2,000 ml'),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // 다양한 CircularProgressIndicator 예시들
          const Text(
            'CircularProgressIndicator 예시들',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildIndicatorExamples(),
        ],
      ),
    );
  }

  Widget _buildInfoCard({required String title, required Widget child}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 40,
      width: 1,
      color: Colors.grey[300],
    );
  }

  // CircularProgressIndicator 다양한 예시
  Widget _buildIndicatorExamples() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // 첫 번째 줄
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // 기본
                Column(
                  children: [
                    const CircularProgressIndicator(),
                    const SizedBox(height: 8),
                    const Text('기본'),
                  ],
                ),

                // 색상 변경
                Column(
                  children: [
                    const CircularProgressIndicator(
                      color: Colors.red,
                    ),
                    const SizedBox(height: 8),
                    const Text('색상 변경'),
                  ],
                ),

                // 배경 포함
                Column(
                  children: [
                    CircularProgressIndicator(
                      color: Colors.green,
                      backgroundColor: Colors.green[100],
                    ),
                    const SizedBox(height: 8),
                    const Text('배경 포함'),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 30),

            // 두 번째 줄
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // 크기 조절
                Column(
                  children: [
                    const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text('작은 크기'),
                  ],
                ),

                // 두께 변경
                Column(
                  children: [
                    const SizedBox(
                      width: 40,
                      height: 40,
                      child: CircularProgressIndicator(
                        strokeWidth: 8,
                        color: Colors.purple,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text('두꺼운 선'),
                  ],
                ),

                // 진행률 표시
                Column(
                  children: [
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: CircularProgressIndicator(
                        value: 0.7, // 70%
                        color: Colors.orange,
                        backgroundColor: Colors.orange[100],
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text('70% 진행'),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 30),

            // 세 번째 줄 - 버튼 내 로딩
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: null, // 비활성화
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text('로딩중...'),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('일반 버튼'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}