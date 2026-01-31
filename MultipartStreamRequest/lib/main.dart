import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MultipartStreamRequest());
  }
}

class MultipartStreamRequest extends StatelessWidget {
  void requestTest() async {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('https://httpbin.org/post'),
    );

    request.fields['name'] = '이영진';
    request.fields['age'] = '17';

    final responseStream = await request.send();
    final response = await http.Response.fromStream(responseStream);

    print('결과 값 : $response');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('MultipartRequest Test Page'),
      ),

      body: Center(
        child: ElevatedButton(
          onPressed: () => requestTest(),
          child: Text('Click Me!'),
        ),
      ),
    );
  }
}
