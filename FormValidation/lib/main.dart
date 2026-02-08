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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const FormValidationPage(),
    );
  }
}

class FormValidationPage extends StatefulWidget {
  const FormValidationPage({super.key});

  @override
  State<FormValidationPage> createState() => _FormValidationPageState();
}

class _FormValidationPageState extends State<FormValidationPage> {
  // ============================================================
  // 핵심 1: GlobalKey<FormState>로 폼 상태를 관리
  // ============================================================
  final _formKey = GlobalKey<FormState>();

  // controller 방식: 비밀번호 확인 비교용으로만 사용
  final _passwordController = TextEditingController();

  // ============================================================
  // onSaved 방식: save() 호출 시 여기에 값이 저장됨
  // ============================================================
  String? _savedName;
  String? _savedEmail;
  String? _savedPassword;

  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  // autovalidateMode 전환용 (제출 전에는 검증 안 함)
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void _submitForm() {
    // ============================================================
    // 핵심 2: _formKey.currentState!.validate()로 모든 필드 검증
    // ============================================================
    if (_formKey.currentState!.validate()) {
      // ============================================================
      // 핵심 3: save() → 모든 TextFormField의 onSaved 콜백 실행
      // ============================================================
      _formKey.currentState!.save();

      // save() 후 _savedName, _savedEmail, _savedPassword에 값이 들어있음
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('회원가입 성공!'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('이름: $_savedName'),
              Text('이메일: $_savedEmail'),
              Text('비밀번호: ${'*' * (_savedPassword?.length ?? 0)}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('확인'),
            ),
          ],
        ),
      );
    } else {
      // 검증 실패 시 자동 검증 모드 활성화
      setState(() {
        _autovalidateMode = AutovalidateMode.onUserInteraction;
      });
    }
  }

  void _resetForm() {
    // ============================================================
    // 핵심 4: reset()으로 폼 초기화
    // - reset(): 에러 메시지 제거 + 입력값 초기화 (onSaved 방식에선 이것만으로 충분)
    // - controller.clear(): controller를 쓰는 필드만 추가로 필요
    // ============================================================
    _formKey.currentState!.reset();
    _passwordController.clear();
    _savedName = null;
    _savedEmail = null;
    _savedPassword = null;
    setState(() {
      _autovalidateMode = AutovalidateMode.disabled;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Day 14: Form Validation'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 설명 카드
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Form + GlobalKey + validator',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Day 13에서는 TextField + setState로 직접 검증했지만,\n'
                      'Form 위젯을 사용하면 여러 필드를 한번에 검증할 수 있습니다.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // ============================================================
            // 핵심: Form 위젯으로 감싸기
            // ============================================================
            Form(
              key: _formKey,
              autovalidateMode: _autovalidateMode,
              child: Column(
                children: [
                  // 이름 필드 (onSaved 방식 - controller 없음)
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: '이름',
                      hintText: '홍길동',
                      prefixIcon: const Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    // ============================================================
                    // 핵심 5: validator 콜백 - null 반환 시 통과, 문자열 반환 시 에러
                    // ============================================================
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return '이름을 입력하세요';
                      }
                      if (value.trim().length < 2) {
                        return '이름은 2자 이상이어야 합니다';
                      }
                      return null; // 검증 통과
                    },
                    // 핵심: save() 호출 시 이 콜백이 실행됨
                    onSaved: (value) {
                      _savedName = value?.trim();
                    },
                  ),

                  const SizedBox(height: 16),

                  // 이메일 필드 (onSaved 방식 - controller 없음)
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: '이메일',
                      hintText: 'example@email.com',
                      prefixIcon: const Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return '이메일을 입력하세요';
                      }
                      // 간단한 이메일 정규식 검증
                      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                      if (!emailRegex.hasMatch(value.trim())) {
                        return '올바른 이메일 형식이 아닙니다';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _savedEmail = value?.trim();
                    },
                  ),

                  const SizedBox(height: 16),

                  // 비밀번호 필드 (controller 유지 - 비밀번호 확인 비교용)
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      labelText: '비밀번호',
                      hintText: '6자 이상 입력',
                      prefixIcon: const Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '비밀번호를 입력하세요';
                      }
                      if (value.length < 6) {
                        return '비밀번호는 6자 이상이어야 합니다';
                      }
                      if (!RegExp(r'[A-Za-z]').hasMatch(value)) {
                        return '영문자를 포함해야 합니다';
                      }
                      if (!RegExp(r'[0-9]').hasMatch(value)) {
                        return '숫자를 포함해야 합니다';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _savedPassword = value;
                    },
                  ),

                  const SizedBox(height: 16),

                  // 비밀번호 확인 필드 (다른 필드 값과 비교하는 validator)
                  TextFormField(
                    obscureText: _obscureConfirm,
                    decoration: InputDecoration(
                      labelText: '비밀번호 확인',
                      hintText: '비밀번호를 다시 입력',
                      prefixIcon: const Icon(Icons.lock_outline),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obscureConfirm = !_obscureConfirm;
                          });
                        },
                        icon: Icon(
                          _obscureConfirm
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '비밀번호를 다시 입력하세요';
                      }
                      // 핵심: 다른 컨트롤러의 값과 비교
                      if (value != _passwordController.text) {
                        return '비밀번호가 일치하지 않습니다';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 32),

                  // 버튼 영역
                  Row(
                    children: [
                      // 초기화 버튼
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _resetForm,
                          icon: const Icon(Icons.refresh),
                          label: const Text('초기화'),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      // 제출 버튼
                      Expanded(
                        flex: 2,
                        child: FilledButton.icon(
                          onPressed: _submitForm,
                          icon: const Icon(Icons.check),
                          label: const Text('회원가입'),
                          style: FilledButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // 핵심 개념 정리
            Card(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '핵심 개념 정리',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildConceptRow('Form', '여러 TextFormField를 묶어 관리'),
                    _buildConceptRow('GlobalKey<FormState>', '폼 상태에 접근하는 키'),
                    _buildConceptRow('validator', 'null→통과, String→에러메시지'),
                    _buildConceptRow('validate()', '모든 필드의 validator 실행'),
                    _buildConceptRow('save()', 'onSaved 콜백 실행'),
                    _buildConceptRow('reset()', '폼을 초기 상태로 되돌림'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConceptRow(String concept, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              concept,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(description, style: const TextStyle(fontSize: 13)),
          ),
        ],
      ),
    );
  }
}
