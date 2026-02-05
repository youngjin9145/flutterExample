import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Step2Controller());
  }
}

class Step2Controller extends StatefulWidget {
  @override
  _Step2ControllerState createState() => _Step2ControllerState();
}

class _Step2ControllerState extends State<Step2Controller> {
  final TextEditingController _controller = TextEditingController();
  String _displayText = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Step 2: Controller 연결')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: '메시지 입력',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),

            Wrap(
              spacing: 4,
              runSpacing: 4,
              children: [
                ElevatedButton(
                  // 텍스트 읽기
                  onPressed: () {
                    setState(() {
                      _displayText = _controller.text;
                    });
                  },
                  child: Text('텍스트 가져오기'),
                ),
                SizedBox(width: 8),

                // 텍스트 쓰기
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _controller.text = 'Hello Flutter!';
                    });
                  },
                  child: Text('텍스트 설정'),
                ),
                SizedBox(width: 8),

                // 텍스트 지우기
                ElevatedButton(
                  onPressed: () {
                    _controller.clear();
                    setState(() {
                      _displayText = '';
                    });
                  },
                  child: Text('지우기'),
                ),
              ]
            ),
            SizedBox(height: 24),
            Text('입력된 텍스트: $_displayText', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
