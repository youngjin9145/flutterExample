import 'package:flutter/material.dart';

void main() {
  runApp(Step1Basic());
}

class Step1Basic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Step 1: 기본 TextField')),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: TextField(
            decoration: InputDecoration(
              labelText: '이름을 입력하세요',
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ),
    );
  }
}
