import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Step2Controller()
    );
  }
}

class Step2Controller extends StatefulWidget {
  @override
  _Step2ControllerState createState() => _Step2ControllerState();
}

class _Step2ControllerState extends State<Step2Controller> {
  final TextEditingController _controller = TextEditingController();

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
        child: TextField(
          controller: _controller,
          decoration: InputDecoration(
            labelText: '메시지 입력',
            border: OutlineInputBorder()
          ),
        ),
      )
    );
  }
}