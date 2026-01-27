import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ButtonStyle 예제',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ButtonStyleExample(),
    );
  }
}

class ButtonStyleExample extends StatelessWidget {
  const ButtonStyleExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ButtonStyle 예제'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ============================================
            // 예제 1: styleFrom 사용 (간편한 방법)
            // ============================================
            const Text(
              '1. styleFrom 사용 (간편)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('styleFrom 버튼'),
            ),

            const SizedBox(height: 32),

            // ============================================
            // 예제 2: ButtonStyle + all (모든 상태 동일)
            // ============================================
            const Text(
              '2. ButtonStyle + all (모든 상태 동일)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.green),
                foregroundColor: WidgetStateProperty.all(Colors.white),
                padding: WidgetStateProperty.all(
                  const EdgeInsets.symmetric(vertical: 16),
                ),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              child: const Text('all 버튼'),
            ),

            const SizedBox(height: 32),

            // ============================================
            // 예제 3: ButtonStyle + resolveWith (상태별 다른 스타일)
            // ============================================
            const Text(
              '3. resolveWith (상태별 다른 스타일)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              '눌러보세요! pressed 상태에서 색이 바뀝니다.',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.pressed)) {
                    return Colors.orange; // 눌렀을 때
                  }
                  if (states.contains(WidgetState.hovered)) {
                    return Colors.purple.shade300; // 마우스 호버 (웹/데스크톱)
                  }
                  return Colors.purple; // 기본 상태
                }),
                foregroundColor: WidgetStateProperty.all(Colors.white),
                overlayColor: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.pressed)) {
                    return Colors.white.withValues(alpha: 0.2); // ripple 효과
                  }
                  return null; // 기본 테마 사용
                }),
                padding: WidgetStateProperty.all(
                  const EdgeInsets.symmetric(vertical: 16),
                ),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              child: const Text('resolveWith 버튼'),
            ),

            const SizedBox(height: 32),

            // ============================================
            // 예제 4: disabled 상태 처리
            // ============================================
            const Text(
              '4. disabled 상태 처리',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {}, // 활성화
                    style: _buildDisabledAwareStyle(),
                    child: const Text('활성화'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: null, // 비활성화
                    style: _buildDisabledAwareStyle(),
                    child: const Text('비활성화'),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // ============================================
            // 예제 5: 커스텀 버튼 위젯으로 재사용
            // ============================================
            const Text(
              '5. 재사용 가능한 커스텀 버튼',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const PrimaryButton(text: '로그인'),
            const SizedBox(height: 8),
            const SecondaryButton(text: '회원가입'),
          ],
        ),
      ),
    );
  }

  /// disabled 상태를 고려한 ButtonStyle
  ButtonStyle _buildDisabledAwareStyle() {
    return ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return Colors.grey.shade300; // 비활성화 시 회색
        }
        if (states.contains(WidgetState.pressed)) {
          return Colors.red.shade700;
        }
        return Colors.red; // 기본
      }),
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return Colors.grey.shade500; // 비활성화 시 텍스트도 연하게
        }
        return Colors.white;
      }),
      padding: WidgetStateProperty.all(
        const EdgeInsets.symmetric(vertical: 16),
      ),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}

// ============================================
// 재사용 가능한 커스텀 버튼 위젯들
// ============================================

/// Primary 버튼 - 주요 액션용
class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const PrimaryButton({super.key, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed ?? () {},
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return Colors.indigo.shade200;
          }
          if (states.contains(WidgetState.pressed)) {
            return Colors.indigo.shade800;
          }
          return Colors.indigo;
        }),
        foregroundColor: WidgetStateProperty.all(Colors.white),
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        elevation: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.pressed)) {
            return 0; // 눌렀을 때 그림자 제거
          }
          return 2;
        }),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }
}

/// Secondary 버튼 - 보조 액션용 (outline 스타일)
class SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const SecondaryButton({super.key, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed ?? () {},
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.pressed)) {
            return Colors.indigo.shade800;
          }
          return Colors.indigo;
        }),
        side: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.pressed)) {
            return BorderSide(color: Colors.indigo.shade800, width: 2);
          }
          return const BorderSide(color: Colors.indigo, width: 2);
        }),
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        overlayColor: WidgetStateProperty.all(Colors.indigo.withValues(alpha: 0.1)),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }
}
