import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  // Only MyApp3 전용 설정들.
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.blue[300],
      statusBarBrightness: Brightness.light,
      systemNavigationBarColor: Colors.yellow[300], // 제스처 네비게이션에게는 Navigattion 설정들이 무시가 됩니다.
      systemNavigationBarIconBrightness: Brightness.dark,
    )
  );
  // runApp(MyApp1());
  // runApp(MyApp2());
  runApp(MyApp3());
}

class MyApp1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.blue[300],
            statusBarBrightness: Brightness.light,
            systemNavigationBarColor: Colors.yellow[300],
            systemNavigationBarIconBrightness: Brightness.dark,
          )
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('SystemUiOverlayStyle1'),
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}

class MyApp2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.blue[300],
          statusBarBrightness: Brightness.light,
          systemNavigationBarColor: Colors.yellow[300],
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}

class MyApp3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
      ),
    );
  }
}