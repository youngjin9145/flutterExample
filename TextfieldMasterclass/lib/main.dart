import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Step4Controller());
  }
}

class Step4Controller extends StatefulWidget {
  @override
  _Step4ControllerState createState() => _Step4ControllerState();
}

class _Step4ControllerState extends State<Step4Controller> {
  final TextEditingController _controller = TextEditingController();
  int _charCount = 0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextChange); // _controller 의 값이 바뀔 때 마다 실행.
  }

  void _onTextChange() {
    setState(() {
      _charCount = _controller.text.length;
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChange);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Step 4: 실시간 감지')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              maxLength: 50,
              decoration: InputDecoration(
                labelText: '자기소개',
                hintText: '50자 이내로 입력해주세요',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                )
              ),
            ),
            SizedBox(height: 16),

            Text(
              '글자 수: $_charCount / 50',
              style: TextStyle(
                color: _charCount > 40 ? Colors.red : Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),

            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '미리보기: ${_controller.text.isEmpty ? '(입력 대기중...)' : _controller.text}'
              ),
            )
          ],
        ),
      ),
    );
  }
}
