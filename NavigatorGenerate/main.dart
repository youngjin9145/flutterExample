import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NavigatorGeneratePage(),
    );
  }
}

class NavigatorGeneratePage extends StatefulWidget {
  @override
  State<NavigatorGeneratePage> createState() => _NavigatorGeneratePageState();
}

class _NavigatorGeneratePageState extends State<NavigatorGeneratePage> {
  int _barSelected = 0;

  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop == true) return;

        final navigator = _navigatorKeys[_barSelected].currentState;
        if (navigator != null) {
          await navigator.maybePop();
        }
      },
      child: Scaffold(
        appBar: AppBar(centerTitle: true, title: Text('MY Health DATA')),
        body: IndexedStack(
          index: _barSelected,
          children: [
            _buildNavigator(
              child: HomePageDetail(depth: 0),
              Navkey: _navigatorKeys[0],
            ), // 0
            _buildNavigator(
              child: SearchDetail(depth: 0),
              Navkey: _navigatorKeys[1],
            ),
          ],
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _barSelected,
          onDestinationSelected: (value) {
            setState(() {
              print(value);
              _barSelected = value;
            });
          },
          destinations: [
            NavigationDestination(icon: Icon(Icons.home), label: 'home'),
            NavigationDestination(icon: Icon(Icons.search), label: 'search'),
          ],
        ),
      ),
    );
  }
}

class _buildNavigator extends StatelessWidget {
  final Widget child;
  final GlobalKey<NavigatorState> Navkey;

  _buildNavigator({required this.child, required this.Navkey});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Navkey,
      onGenerateRoute: (setting) {
        return MaterialPageRoute(
          builder: (_) {
            return child;
          },
        );
      },
    );
  }
}

class HomePageDetail extends StatelessWidget {
  late int depth;
  late List<String> detail = List.generate(depth + 1, (index) {
    if (depth == 0) return '홈 입니다.';
    return '탭 깊이가 $index 입니다';
  });

  HomePageDetail({required this.depth});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(color: Colors.blue[100 + depth * 100]),
          child: Column(
            children: [
              ...detail.reversed.map((e) {
                return Text('아따 징한겨~~ **$e**');
              }),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => HomePageDetail(depth: depth + 1),
              ),
            );
          },
          child: Text('한 번 더!', style: TextStyle(color: Colors.black)),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red[400]),
        ),
        ElevatedButton(
          onPressed: () {
            if (depth > 0) {
              Navigator.of(context).pop();
            }
          },
          child: Text('이전으로!', style: TextStyle(color: Colors.white)),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.purple[400]),
        ),
      ],
    );
  }
}

class SearchDetail extends StatelessWidget {
  late int depth;
  late List<String> detail = List.generate(depth + 1, (index) {
    if (depth == 0) return '홈 입니다.';
    return '탭 깊이가 $index 입니다';
  });

  SearchDetail({super.key, required this.depth});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(color: Colors.green[100 + depth * 100]),
          child: Column(
            children: [
              ...detail.reversed.map((e) {
                return Text('아따 얼마나 찾은겨~~~ **$e**');
              }),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => SearchDetail(depth: depth + 1)),
            );
          },
          child: Text('한 번 더!', style: TextStyle(color: Colors.black)),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red[400]),
        ),
      ],
    );
  }
}
